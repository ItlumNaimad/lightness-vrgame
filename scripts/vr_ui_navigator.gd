extends Node
class_name VRUINavigator

## VRUINavigator — Komponent uniwersalnej nawigacji joystickiem VR w menu.
## Zapewnia pełną dostępność dla osób niewidomych:
## - Wychylenie gałki góra/dół sekwencyjnie przenosi focus między przyciskami
## - Automatyczny odczyt lektorski TTS zaznaczonej opcji
## - Impuls haptyczny w kontrolerze przy każdej zmianie focusu
## - Wciśnięcie przycisku A (ax_button) lub pociągnięcie spustu zatwierdza wybór

signal horizontal_navigated(direction: int)

@export var root_control: Control
@export var debounce_time: float = 0.28
@export var enabled: bool = true

var _cooldown: float = 0.0
var _current_buttons: Array[Button] = []
var _current_index: int = -1

var _left_ctrl: XRController3D
var _right_ctrl: XRController3D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if root_control == null and get_parent() is Control:
		root_control = get_parent() as Control
	_find_controllers()
	refresh_buttons()

func _find_controllers() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var origin = player.get_node_or_null("XROrigin3D")
		if origin:
			_left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
			_right_ctrl = origin.get_node_or_null("right_hand") as XRController3D

func refresh_buttons() -> void:
	_current_buttons.clear()
	if root_control:
		_gather_buttons(root_control, _current_buttons)
	
	if not _current_buttons.is_empty():
		# Szukamy aktualnie sfokusowanego przycisku
		_current_index = -1
		for i in range(_current_buttons.size()):
			if _current_buttons[i].has_focus():
				_current_index = i
				break
		if _current_index == -1:
			_current_index = 0
			# Nie wymuszamy natychmiastowego TTS przy starcie, aby nie zagłuszyć zapowiedzi ekranu
			_current_buttons[0].grab_focus()

func _gather_buttons(node: Node, out_list: Array[Button]) -> void:
	if node is CanvasItem:
		if not (node as CanvasItem).is_visible_in_tree():
			return
	elif node is Node3D:
		if not (node as Node3D).is_visible_in_tree():
			return

	if node is Button and not node.disabled and node.focus_mode != Control.FOCUS_NONE and (node as CanvasItem).is_visible_in_tree():
		out_list.append(node)
	for child in node.get_children():
		_gather_buttons(child, out_list)

func _process(delta: float) -> void:
	if not enabled:
		return
	if root_control == null or not is_instance_valid(root_control):
		return
	if not root_control.is_visible_in_tree():
		return
		
	# Sprawdzamy czy nadrzędny węzeł 3D (np. Viewport2Din3D) nie jest ukryty w świecie gry
	var vp = root_control.get_viewport()
	if vp and vp.get_parent() is Node3D:
		if not (vp.get_parent() as Node3D).is_visible_in_tree():
			return

	if _cooldown > 0.0:
		_cooldown -= delta
		return

	if _left_ctrl == null or _right_ctrl == null:
		_find_controllers()

	# Odczyt gałki z kontrolerów VR
	var stick_y := 0.0
	var stick_x := 0.0
	var active_ctrl: XRController3D = null
	
	if _left_ctrl and _left_ctrl.get_is_active():
		var v = _left_ctrl.get_vector2("primary")
		if abs(v.y) > 0.45:
			stick_y = v.y
			active_ctrl = _left_ctrl
		if abs(v.x) > 0.45:
			stick_x = v.x
			active_ctrl = _left_ctrl
			
	if active_ctrl == null and _right_ctrl and _right_ctrl.get_is_active():
		var v = _right_ctrl.get_vector2("primary")
		if abs(v.y) > 0.45:
			stick_y = v.y
			active_ctrl = _right_ctrl
		if abs(v.x) > 0.45:
			stick_x = v.x
			active_ctrl = _right_ctrl

	# Fallback dla klawiatury PC podczas testów
	if stick_y == 0.0:
		if Input.is_action_just_pressed("ui_down") or Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
			stick_y = -1.0
		elif Input.is_action_just_pressed("ui_up") or Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
			stick_y = 1.0

	if stick_x == 0.0:
		if Input.is_action_just_pressed("ui_left") or Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
			stick_x = -1.0
		elif Input.is_action_just_pressed("ui_right") or Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
			stick_x = 1.0

	# Nawigacja pozioma lewo / prawo (np. suwaki w settings)
	if stick_x != 0.0:
		_cooldown = debounce_time
		var dir = -1 if stick_x < 0.0 else 1
		if active_ctrl:
			active_ctrl.trigger_haptic_pulse("haptic", 100.0, 0.4, 0.05, 0.0)
		horizontal_navigated.emit(dir)
		return

	# Nawigacja góra / dół
	if stick_y != 0.0 and not _current_buttons.is_empty():
		_cooldown = debounce_time
		
		# W OpenXR / Godot: wychylenie gałki w dół ma wartość ujemną
		if stick_y < 0.0:
			_current_index = (_current_index + 1) % _current_buttons.size()
		else:
			_current_index = (_current_index - 1 + _current_buttons.size()) % _current_buttons.size()
			
		_apply_focus_to_current(active_ctrl)
		return

	# Zatwierdzenie przyciskiem A (ax_button) na kontrolerze VR
	var confirm_pressed := false
	if _left_ctrl and (_left_ctrl.is_button_pressed("ax_button") or _left_ctrl.is_button_pressed("trigger_click")):
		confirm_pressed = true
		active_ctrl = _left_ctrl
	elif _right_ctrl and (_right_ctrl.is_button_pressed("ax_button") or _right_ctrl.is_button_pressed("trigger_click")):
		confirm_pressed = true
		active_ctrl = _right_ctrl

	if confirm_pressed and not _current_buttons.is_empty() and _current_index >= 0 and _current_index < _current_buttons.size():
		_cooldown = 0.45 # Debounce zatwierdzenia
		var target_btn = _current_buttons[_current_index]
		if is_instance_valid(target_btn):
			if active_ctrl:
				active_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.8, 0.12, 0.0)
			if target_btn is HoldButton:
				(target_btn as HoldButton)._trigger_activation()
			else:
				target_btn.pressed.emit()

func _apply_focus_to_current(ctrl: XRController3D) -> void:
	if _current_buttons.is_empty() or _current_index < 0 or _current_index >= _current_buttons.size():
		return
		
	var target_btn = _current_buttons[_current_index]
	if not is_instance_valid(target_btn):
		refresh_buttons()
		return
		
	target_btn.grab_focus()
	
	# Haptyka
	if ctrl:
		ctrl.trigger_haptic_pulse("haptic", 120.0, 0.5, 0.06, 0.0)
		
	# Odczyt lektora TTS (z pierwszeństwem dla zarejestrowanych funkcji TTSManager.setup_button)
	if TTSManager:
		if TTSManager.has_method("flush_pending_speech") and not TTSManager._pending_speech_text.is_empty():
			TTSManager.flush_pending_speech()
		else:
			var txt = target_btn.text.strip_edges()
			if txt.is_empty() and target_btn.tooltip_text:
				txt = target_btn.tooltip_text
			if not txt.is_empty():
				TTSManager.speak(txt, true)

