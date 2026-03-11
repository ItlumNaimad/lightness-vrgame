@tool
extends XRToolsSceneBase

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	# Podpinamy sygnały z UI (które jest wewnątrz Viewport2Din3D)
	# Viewport2Din3D instancjonuje scenę jako swoje dziecko
	var viewport_2d = $Viewport2Din3D
	if viewport_2d:
		# Czekamy na klatkę, aby scena UI zdążyła się załadować w viewporcie
		if not viewport_2d.is_node_ready():
			await viewport_2d.ready
		var ui = viewport_2d.get_scene_instance()
		if ui:
			ui.start_pressed.connect(_on_start_pressed)
			ui.exit_pressed.connect(_on_exit_pressed)
			ui.settings_pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	request_load_scene.emit("res://scenes/game_map.tscn")

func _on_exit_pressed():
	request_quit.emit()

func _on_settings_pressed():
	print("Settings not implemented yet")
