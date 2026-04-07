extends Node3D

@onready var player = $Player
@onready var world = $World
@onready var start_xr = $StartXR

var current_scene : Node3D
var next_scene_path : String

func _ready():
	player.global_position = Vector3(0,10,0)
	await get_tree().create_timer(1.0).timeout
	_load_initial_scene("res://scenes/main_menu.tscn")
	

func _load_initial_scene(path: String):
	var scene_res = load(path)
	if scene_res:
		current_scene = scene_res.instantiate()
		world.add_child(current_scene)
		_connect_scene_signals(current_scene)
		

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
	var tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished
	
	
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)
	await tween.finished
	ResourceLoader.load_threaded_request(next_scene_path)
	
	if current_scene:
		world.remove_child(current_scene)
		current_scene.queue_free()
	
	
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 0.0, 1.0, 0.5)
	await tween.finished
	var new_scene_res = ResourceLoader.load_threaded_get(next_scene_path)
	current_scene = new_scene_res.instantiate()
	world.add_child(current_scene)
	_connect_scene_signals(current_scene)
	
	if current_scene.has_method("scene_loaded"):
		current_scene.scene_loaded()
	
	tween = get_tree().create_tween()
	tween.tween_method(_set_fade, 1.0, 0.0, 0.5)


func _set_fade(value: float):
	XRToolsFade.set_fade("main_transition", Color(0, 0, 0, value))
