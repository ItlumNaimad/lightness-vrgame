@tool
extends XRToolsSceneBase

const GAME_MAP_PATH = "res://scenes/game_map.tscn"
const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	# Zablokowanie ruchu kontrolerem dla sceny Game Over
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		if "enabled" in p:
			p.enabled = false
			
	# Podpinamy sygnały z UI wewnątrz Viewport2Din3D
	var viewport_2d = $Viewport2Din3D
	if viewport_2d:
		if not viewport_2d.is_node_ready():
			await viewport_2d.ready
		var ui = viewport_2d.get_scene_instance()
		if ui:
			ui.restart_pressed.connect(_on_restart_pressed)
			ui.menu_pressed.connect(_on_menu_pressed)

func _on_restart_pressed() -> void:
	SceneLoader.load_scene(GAME_MAP_PATH)

func _on_menu_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU_PATH)
