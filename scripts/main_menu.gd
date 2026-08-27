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
			
	_connect_ui_signals()

func _connect_ui_signals() -> void:
	var viewport_2d = $Viewport2Din3D
	if not viewport_2d:
		return
		
	if not viewport_2d.is_node_ready():
		await viewport_2d.ready
		
	await get_tree().process_frame
	
	var ui = viewport_2d.get_scene_instance()
	if not ui and $Viewport2Din3D/Viewport.get_child_count() > 0:
		ui = $Viewport2Din3D/Viewport.get_child(0)
		
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
