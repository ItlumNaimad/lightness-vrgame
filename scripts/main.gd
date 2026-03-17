extends Node3D

@onready var player = $Player
@onready var world = $World
@onready var loading_screen = $LoadingScreen
@onready var start_xr = $StartXR

var current_scene : Node3D
var next_scene_path : String

func _ready():
	# Podpinamy kamerę pod LoadingScreen, aby podążał za wzrokiem
	var camera = player.get_node("XRCamera3D")
	if camera:
		loading_screen.set_camera(camera)
	
	loading_screen.visible = false
	
	# Czekamy na pełną inicjalizację silnika i systemów XR
	# Zwiększamy opóźnienie, aby uniknąć błędów Viewport Texture
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	
	# Startujemy od menu głównego
	_load_initial_scene("res://scenes/main_menu.tscn")

func _process(_delta):
	# Aktualizuj pozycję ekranu ładowania, aby zawsze był przy graczu
	if loading_screen.visible:
		loading_screen.global_position = player.global_position

func _load_initial_scene(path: String):
	var scene_res = load(path)
	if scene_res:
		current_scene = scene_res.instantiate()
		world.add_child(current_scene)
		_connect_scene_signals(current_scene)
		if current_scene.has_method("scene_loaded"):
			current_scene.scene_loaded()

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
	# 0. Zaciemnienie (Fade out)
	var tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished

	# 1. Pokaż ekran ładowania
	loading_screen.progress = 0.0
	loading_screen.enable_press_to_continue = false
	loading_screen.visible = true
	
	# Rozjaśnij do ekranu ładowania
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)
	await tween.finished

	# 2. Zacznij ładować nową scenę w tle
	ResourceLoader.load_threaded_request(next_scene_path)
	
	# 3. Usuń starą scenę
	if current_scene:
		world.remove_child(current_scene)
		current_scene.queue_free()
	
	# 4. Czekaj na załadowanie i aktualizuj pasek postępu
	while true:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			loading_screen.progress = 1.0
			break
		elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			loading_screen.progress = progress[0]
		else:
			push_error("Błąd ładowania sceny: ", next_scene_path)
			return
		await get_tree().create_timer(0.1).timeout
	
	# 5. Pozwól graczowi kontynuować (mechanizm przytrzymania przycisku)
	loading_screen.enable_press_to_continue = true
	
	# Konfigurujemy przycisk na prawą rękę (zgodnie z pointerem)
	var hold_button = loading_screen.get_node_or_null("PressToContinue/HoldButton")
	if hold_button:
		hold_button.activate_action = "trigger_click" # Prawy spust zazwyczaj
	
	await loading_screen.continue_pressed
	
	# Zaciemnij przed pokazaniem nowej sceny
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished

	# 6. Instancjonuj nową scenę
	var new_scene_res = ResourceLoader.load_threaded_get(next_scene_path)
	current_scene = new_scene_res.instantiate()
	world.add_child(current_scene)
	_connect_scene_signals(current_scene)
	
	# Wywołaj scene_loaded jeśli istnieje (kompatybilność z XRToolsSceneBase)
	if current_scene.has_method("scene_loaded"):
		current_scene.scene_loaded()
	
	# 7. Ukryj ekran ładowania i rozjaśnij (Fade in)
	loading_screen.visible = false
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)

func _set_fade(value: float):
	XRToolsFade.set_fade("main_transition", Color(0, 0, 0, value))
