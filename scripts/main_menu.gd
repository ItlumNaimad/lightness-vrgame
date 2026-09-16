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
			
	print("[MainMenu] Scene loaded. Connecting UI signals...")
	_connect_ui_signals()

func _connect_ui_signals() -> void:
	var viewport_2d = $Viewport2Din3D
	if not viewport_2d:
		print("[MainMenu] ERROR: Viewport2Din3D not found!")
		return
		
	if not viewport_2d.is_node_ready():
		print("[MainMenu] Waiting for Viewport2Din3D to be ready...")
		await viewport_2d.ready
		
	await get_tree().process_frame
	
	var ui = viewport_2d.get_scene_instance()
	if not ui and $Viewport2Din3D/Viewport.get_child_count() > 0:
		ui = $Viewport2Din3D/Viewport.get_child(0)
		
	if ui:
		print("[MainMenu] Found UI instance: ", ui.name)
		if ui.has_signal("start_pressed"):
			if not ui.start_pressed.is_connected(_on_start_pressed):
				ui.start_pressed.connect(_on_start_pressed)
				print("[MainMenu] start_pressed CONNECTED!")
		else:
			print("[MainMenu] ERROR: UI does not have start_pressed signal!")
			
		if ui.has_signal("exit_pressed"):
			if not ui.exit_pressed.is_connected(_on_exit_pressed):
				ui.exit_pressed.connect(_on_exit_pressed)
				print("[MainMenu] exit_pressed CONNECTED!")
		else:
			print("[MainMenu] ERROR: UI does not have exit_pressed signal!")
	else:
		print("[MainMenu] ERROR: Could not find UI instance inside Viewport2Din3D!")

func _on_start_pressed():
	print("[MainMenu] _on_start_pressed called! Loading game map...")
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_exit_pressed():
	print("[MainMenu] _on_exit_pressed called! Quitting game...")
	get_tree().quit()
