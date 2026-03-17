extends Node3D

@onready var player = $Player
@onready var world = $World
@onready var loading_screen = $Player/LoadingScreen
@onready var start_xr = $StartXR

var current_scene : Node3D
var next_scene_path : String

func _ready():
	# Podpinamy kamerę pod LoadingScreen
	var camera = player.get_node_or_null("XRCamera3D")
	if camera:
		loading_screen.set_camera(camera)
	
	loading_screen.visible = false
	
	# Całkowicie wyłączamy gracza i sterowanie na starcie
	_set_player_physics_enabled(false)
	_set_movement_enabled(false)
	
	# Czekamy na stabilizację systemów VR
	await get_tree().create_timer(1.5).timeout
	
	# Startujemy od menu głównego
	_load_initial_scene("res://scenes/main_menu.tscn")

func _load_initial_scene(path: String):
	var scene_res = load(path)
	if scene_res:
		current_scene = scene_res.instantiate()
		world.add_child(current_scene)
		_connect_scene_signals(current_scene)
		if current_scene.has_method("scene_loaded"):
			current_scene.scene_loaded()
		
		# Włączamy fizykę po załadowaniu pierwszego poziomu
		await _stabilize_player()

func _connect_scene_signals(scene):
	if scene.has_signal("request_load_scene"):
		scene.request_load_scene.connect(_on_request_load_scene)
	if scene.has_signal("request_quit"):
		scene.request_quit.connect(_on_request_quit)

func _on_request_load_scene(path: String, _user_data = null):
	next_scene_path = path
	_start_transition()

func _on_request_quit():
	get_tree().quit()

func _start_transition():
	# 0. Zaciemnienie
	var tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished

	# 1. Blokada ruchu i fizyki
	_set_player_physics_enabled(false)
	_set_movement_enabled(false)
	
	loading_screen.progress = 0.0
	loading_screen.enable_press_to_continue = false
	loading_screen.visible = true
	
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)
	await tween.finished

	# 2. Ładowanie nowej sceny
	ResourceLoader.load_threaded_request(next_scene_path)
	
	if current_scene:
		world.remove_child(current_scene)
		current_scene.queue_free()
	
	while true:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			loading_screen.progress = 1.0
			break
		elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_screen.progress = progress[0]
		else:
			return
		await get_tree().create_timer(0.1).timeout
	
	# 3. Czekaj na potwierdzenie gracza
	loading_screen.enable_press_to_continue = true
	var hold_button = loading_screen.get_node_or_null("PressToContinue/HoldButton")
	if hold_button:
		hold_button.activate_action = "trigger_click" 
	
	await loading_screen.continue_pressed
	
	# 4. Przełączenie sceny
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished

	var new_scene_res = ResourceLoader.load_threaded_get(next_scene_path)
	current_scene = new_scene_res.instantiate()
	world.add_child(current_scene)
	_connect_scene_signals(current_scene)
	
	if current_scene.has_method("scene_loaded"):
		current_scene.scene_loaded()
	
	loading_screen.visible = false
	
	# 5. Stabilizacja i odblokowanie sterowania
	await _stabilize_player()
	
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)

func _set_fade(value: float):
	XRToolsFade.set_fade("main_transition", Color(0, 0, 0, value))

func _set_player_physics_enabled(enabled: bool):
	var player_body = player.get_node_or_null("PlayerBody")
	if player_body:
		player_body.enabled = enabled
		player_body.velocity = Vector3.ZERO
		player_body.process_mode = PROCESS_MODE_INHERIT if enabled else PROCESS_MODE_DISABLED

func _set_movement_enabled(enabled: bool):
	# Szukamy wszystkich movement providerów w grupie
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		p.enabled = enabled

func _stabilize_player():
	# Włączamy fizykę, ale przez pierwsze 10 klatek wymuszamy brak ruchu
	# To zabija pęd powstały przy "skoku" trackingu VR
	_set_player_physics_enabled(true)
	var player_body = player.get_node_or_null("PlayerBody")
	if player_body:
		for i in range(10):
			player_body.velocity = Vector3.ZERO
			await get_tree().physics_frame
	
	# Dopiero teraz odblokowujemy joysticki
	_set_movement_enabled(true)
