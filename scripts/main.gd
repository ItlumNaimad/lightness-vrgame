extends Node3D

@onready var player = $Player
@onready var world = $World
@onready var start_xr = $StartXR

var current_scene : Node3D
var next_scene_path : String

func _ready():
	_set_player_physics_enabled(false)
	await get_tree().create_timer(1.0).timeout
	_load_initial_scene("res://scenes/main_menu.tscn")
	

func _load_initial_scene(path: String):
	var scene_res = load(path)
	if scene_res:
		current_scene = scene_res.instantiate()
		world.add_child(current_scene)
		_connect_scene_signals(current_scene)
		await _teleport_and_stabilize()
		
		var tween = get_tree().create_tween()
		tween.tween_method(_set_fade, 1.0, 0.0, 0.5)

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
	# 1. Ściemnianie ekranu
	var tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished
	# 2. Wyłaczenie fizyki gracza przed usunięciem starego podłoża
	_set_player_physics_enabled(false)
	_set_movement_enabled(false)
	# 3. Zlecenie ładowania w tle i usunięcie starej sceny
	ResourceLoader.load_threaded_request(next_scene_path)
	if current_scene:
		world.remove_child(current_scene)
		current_scene.queue_free()
	
	#4. Pobranie instancjonowanie nowej sceny
	var new_scene_res = ResourceLoader.load_threaded_get(next_scene_path)
	current_scene = new_scene_res.instantiate()
	world.add_child(current_scene)
	_connect_scene_signals(current_scene)
	
	#5. Bezpieczna relokacja gracza na Marker 3D nowej mapu i zdjęcie blokad
	await _teleport_and_stabilize()
	# 6. rozjaśnienie ekranu
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)


func _set_fade(value: float):
	if ClassDB.class_exists("XRToolsFade"):
		XRToolsFade.set_fade("main_transition", Color(0, 0, 0, value))

# --- NOWE FUNKCJE POMOCNICZE ---
func _set_player_physics_enabled(enabled: bool):
	var player_body = player.get_node_or_null("PlayerBody")
	if player_body:
		player_body.enabled = enabled
		if not enabled:
			player_body.velocity = Vector3.ZERO

func _set_movement_enabled(enabled: bool):
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		if "enabled" in p:
			p.enabled = enabled

func _teleport_and_stabilize():
	var player_body = player.get_node_or_null("PlayerBody")
	if player_body:
		# Zdejmuejmy wszystkie blokady
		_set_player_physics_enabled(true)
		
		var target_transform = Transform3D(Basis(), Vector3(0, 0.5, 0))
		var spawn_marker = current_scene.get_node_or_null("PlayerSpawn")
		if spawn_marker:
			target_transform = spawn_marker.global_transform
			target_transform.origin.y += 1.0
		
		# Teleportacja uwzględniająca relację gogli względem środka obszaru
		player_body.teleport(target_transform)
		
		# Odczekanie dwóch klatek silnika
		await get_tree().physics_frame
		await get_tree().physics_frame
		
		# Amortyzacja pędu, która pwostrzymuje odrzut
		for i  in range(3):
			player_body.velocity = Vector3.ZERO
			await get_tree().physics_frame
		# Weryfikacja typu mapy i aktywacja odpowiedniej lokomocji
		if current_scene.scene_file_path.contains("main_menu"):
			_set_movement_enabled(false)
		else:
			_set_movement_enabled(true)
