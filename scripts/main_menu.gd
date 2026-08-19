@tool
extends XRToolsSceneBase

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	# Zablokowanie ruchu kontrolerem specjalnie i tylko dla sceny menu
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		if "enabled" in p:
			p.enabled = false
			
	# Podpinamy sygnały z UI (które jest wewnątrz Viewport2Din3D)
	var viewport_2d = $Viewport2Din3D
	if viewport_2d:
		if not viewport_2d.is_node_ready():
			await viewport_2d.ready
		var ui = viewport_2d.get_scene_instance()
		if ui:
			if ui.has_signal("start_pressed") and not ui.start_pressed.is_connected(_on_start_pressed):
				ui.start_pressed.connect(_on_start_pressed)
			if ui.has_signal("exit_pressed") and not ui.exit_pressed.is_connected(_on_exit_pressed):
				ui.exit_pressed.connect(_on_exit_pressed)

func _on_start_pressed():
	# Używamy nowego SceneLoader do płynnego przejścia
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_exit_pressed():
	get_tree().quit()
