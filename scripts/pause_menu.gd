extends Node3D

@onready var viewport_2d: Node3D = $Viewport2Din3D

var is_paused: bool = false
var left_ctrl: XRController3D
var right_ctrl: XRController3D
var camera: XRCamera3D

var _menu_btn_down: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	_find_vr_nodes()
	
	if viewport_2d and viewport_2d.has_method("get_scene_instance"):
		var ui = viewport_2d.get_scene_instance()
		if ui:
			_connect_ui_signals(ui)
	elif viewport_2d:
		# Fallback - czekamy klatkę na załadowanie sceny w Viewport2D
		call_deferred("_deferred_connect_ui")

func _deferred_connect_ui() -> void:
	if viewport_2d:
		var sub_vp = viewport_2d.get_node_or_null("Viewport")
		if sub_vp and sub_vp.get_child_count() > 0:
			var ui = sub_vp.get_child(0)
			_connect_ui_signals(ui)

var _ui_instance: Node = null

func _connect_ui_signals(ui: Node) -> void:
	_ui_instance = ui
	if _ui_instance and _ui_instance.has_method("set_active"):
		_ui_instance.set_active(false)
	if ui.has_signal("resume_requested") and not ui.resume_requested.is_connected(toggle_pause):
		ui.resume_requested.connect(toggle_pause)
	if ui.has_signal("restart_requested") and not ui.restart_requested.is_connected(_on_restart):
		ui.restart_requested.connect(_on_restart)
	if ui.has_signal("main_menu_requested") and not ui.main_menu_requested.is_connected(_on_main_menu):
		ui.main_menu_requested.connect(_on_main_menu)

func _find_vr_nodes() -> void:
	var head = get_tree().get_first_node_in_group("player_head")
	var root = get_tree().get_first_node_in_group("player")
	if head is XRCamera3D:
		camera = head
	elif root:
		camera = root.get_node_or_null("XROrigin3D/XRCamera3D")
		
	if root:
		var origin = root.get_node_or_null("XROrigin3D")
		if origin:
			left_ctrl = origin.get_node_or_null("left_hand")
			right_ctrl = origin.get_node_or_null("right_hand")

func _process(_delta: float) -> void:
	if left_ctrl == null or right_ctrl == null:
		_find_vr_nodes()

	var pressed := false
	if left_ctrl:
		if left_ctrl.is_button_pressed("menu_button") or left_ctrl.is_button_pressed("by_button"):
			pressed = true
	if right_ctrl and not pressed:
		if right_ctrl.is_button_pressed("menu_button") or right_ctrl.is_button_pressed("by_button"):
			pressed = true
			
	if not pressed:
		if Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_ESCAPE) or Input.is_key_pressed(KEY_P):
			pressed = true
		
	if pressed and not _menu_btn_down:
		_menu_btn_down = true
		toggle_pause()
	elif not pressed and _menu_btn_down:
		_menu_btn_down = false

func toggle_pause() -> void:
	if JumpscareHelper.is_jumpscaring_global:
		return
		
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused
	
	if _ui_instance and _ui_instance.has_method("set_active"):
		_ui_instance.set_active(is_paused)
	
	if is_paused:
		_position_in_front_of_player()
		if TTSManager:
			TTSManager.speak("Game paused", true)
	else:
		if TTSManager:
			TTSManager.speak("Game resumed", true)

func _position_in_front_of_player() -> void:
	if camera:
		var cam_forward = -camera.global_transform.basis.z.normalized()
		cam_forward.y = 0.0
		cam_forward = cam_forward.normalized()
		
		var target_pos = camera.global_position + cam_forward * 1.6
		target_pos.y = camera.global_position.y - 0.1
		global_position = target_pos
		
		# Obrót twarzą do gracza
		look_at(camera.global_position, Vector3.UP)
		rotate_y(PI)

func _on_restart() -> void:
	get_tree().paused = false
	visible = false
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_main_menu() -> void:
	get_tree().paused = false
	visible = false
	SceneLoader.load_scene("res://scenes/main_menu.tscn")
