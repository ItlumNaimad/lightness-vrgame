extends Button
class_name HoldButton

## HoldButton — Interaktywny przycisk VR stylizowany na wyryty w betonowej ścianie.
## Samo najechanie NIE ładuje opcji. Aby zatwierdzić, gracz musi PRZYTRZYMAĆ spust (trigger).
## Po aktywacji przycisk jest zablokowany do momentu, gdy gracz PUŚCI trigger.

@export var charge_time_hold: float = 0.55

var _is_hovered: bool = false
var _is_input_holding: bool = false
var _charge: float = 0.0
var _cooldown: float = 0.0
var _current_scale: float = 1.0
var _target_scale: float = 1.0
var _tween: Tween
var _wait_for_release: bool = false  # Blokada aż gracz puści trigger

# Kolory kamiennego wyrycia (Normal)
const COLOR_ENGRAVED_TEXT := Color(0.60, 0.66, 0.74, 0.8)
const COLOR_ENGRAVED_SHADOW := Color(0.01, 0.015, 0.02, 0.95)
const COLOR_ENGRAVED_OUTLINE := Color(0.03, 0.05, 0.07, 0.95)

# Kolory rozżarzonego neonu w ścianie (Hover)
const COLOR_GLOW_TEXT := Color(1.0, 1.0, 1.0, 1.0)
const COLOR_GLOW_NEON := Color(0.0, 1.0, 0.64, 1.0)
const COLOR_GLOW_AURA := Color(0.0, 1.0, 0.64, 0.6)

func _ready() -> void:
	disabled = false
	toggle_mode = false
	action_mode = BaseButton.ACTION_MODE_BUTTON_RELEASE
	
	var empty_style := StyleBoxEmpty.new()
	add_theme_stylebox_override("normal", empty_style)
	add_theme_stylebox_override("hover", empty_style)
	add_theme_stylebox_override("pressed", empty_style)
	add_theme_stylebox_override("focus", empty_style)
	add_theme_stylebox_override("disabled", empty_style)
	
	_apply_engraved_style()
	
	mouse_entered.connect(_on_hover_started)
	focus_entered.connect(_on_hover_started)
	mouse_exited.connect(_on_hover_ended)
	focus_exited.connect(_on_hover_ended)
	resized.connect(_update_pivot)
	_update_pivot()

func _update_pivot() -> void:
	pivot_offset = size / 2.0

func _apply_engraved_style() -> void:
	add_theme_color_override("font_color", COLOR_ENGRAVED_TEXT)
	add_theme_color_override("font_hover_color", COLOR_GLOW_TEXT)
	add_theme_color_override("font_focus_color", COLOR_GLOW_TEXT)
	add_theme_color_override("font_shadow_color", COLOR_ENGRAVED_SHADOW)
	add_theme_color_override("font_outline_color", COLOR_ENGRAVED_OUTLINE)
	add_theme_constant_override("shadow_offset_x", 2)
	add_theme_constant_override("shadow_offset_y", 3)
	add_theme_constant_override("outline_size", 2)

func _input(event: InputEvent) -> void:
	if not _is_hovered:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_is_input_holding = event.pressed
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	# Cooldown po zatwierdzeniu
	if _cooldown > 0.0:
		_cooldown -= delta
		_charge = 0.0
		_is_input_holding = false
		queue_redraw()
		return

	_current_scale = lerp(_current_scale, _target_scale, delta * 12.0)
	scale = Vector2(_current_scale, _current_scale)
	
	if not _is_hovered:
		_is_input_holding = false
		_wait_for_release = false
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()
		return

	var trigger_held := _is_input_holding or _is_trigger_down_on_controller()
	
	# Po aktywacji: czekamy aż gracz PUŚCI trigger zanim pozwolimy na kolejne ładowanie
	if _wait_for_release:
		if not trigger_held:
			_wait_for_release = false
		# Nie ładujemy — gracz wciąż trzyma trigger po poprzedniej aktywacji
		return
	
	if trigger_held:
		_charge += delta / max(0.05, charge_time_hold)
		queue_redraw()
		if _charge >= 1.0:
			_trigger_activation()
	else:
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()

func _trigger_activation() -> void:
	_charge = 0.0
	_is_input_holding = false
	_cooldown = 0.3
	_wait_for_release = true  # Blokada do puszczenia triggera!
	queue_redraw()
	
	_current_scale = 1.14
	scale = Vector2(_current_scale, _current_scale)
	
	print("[HoldButton] ACTIVATED: ", name, " | text: ", text)
	
	# Wywołanie akcji
	pressed.emit()
	
	# Haptyka
	_trigger_haptic_feedback()

func _is_trigger_down_on_controller() -> bool:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		for hand_name in ["XROrigin3D/right_hand", "XROrigin3D/left_hand"]:
			var ctrl = player.get_node_or_null(hand_name) as XRController3D
			if ctrl and ctrl.get_is_active():
				if ctrl.get_float("trigger") > 0.4:
					return true
				if ctrl.is_button_pressed("ax_button"):
					return true
				if ctrl.is_button_pressed("trigger_click"):
					return true
	return false

func _trigger_haptic_feedback() -> void:
	if XRServer.primary_interface:
		for tracker in ["right_hand", "left_hand"]:
			XRServer.primary_interface.trigger_haptic_pulse("haptic", tracker, 100.0, 0.7, 0.1, 0.0)

func _on_hover_started() -> void:
	_is_hovered = true
	_update_pivot()
	_target_scale = 1.07
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	_tween.tween_property(self, "theme_override_colors/font_color", COLOR_GLOW_TEXT, 0.18)
	_tween.tween_property(self, "theme_override_colors/font_outline_color", COLOR_GLOW_NEON, 0.18)
	_tween.tween_property(self, "theme_override_colors/font_shadow_color", COLOR_GLOW_AURA, 0.18)
	_tween.tween_property(self, "theme_override_constants/outline_size", 5, 0.18)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_x", 0, 0.18)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_y", 0, 0.18)
	queue_redraw()

func _on_hover_ended() -> void:
	_is_hovered = false
	_is_input_holding = false
	_target_scale = 1.0
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	_tween.tween_property(self, "theme_override_colors/font_color", COLOR_ENGRAVED_TEXT, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_outline_color", COLOR_ENGRAVED_OUTLINE, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_shadow_color", COLOR_ENGRAVED_SHADOW, 0.25)
	_tween.tween_property(self, "theme_override_constants/outline_size", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_x", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_y", 3, 0.25)
	queue_redraw()

func _draw() -> void:
	if not _is_hovered and _charge <= 0.01:
		return
		
	var w := size.x
	var h := size.y
	var groove_w: float = min(w * 0.65, 340.0)
	var groove_x: float = (w - groove_w) * 0.5
	var groove_y: float = h - 6.0
	var groove_h: float = 3.0
	
	draw_rect(Rect2(groove_x, groove_y, groove_w, groove_h), Color(0.02, 0.04, 0.06, 0.6), true)
	
	if _charge > 0.01:
		var fill_w: float = groove_w * clamp(_charge, 0.0, 1.0)
		draw_rect(Rect2(groove_x, groove_y - 1.0, fill_w, groove_h + 2.0), Color(0.0, 1.0, 0.64, 0.3), true)
		draw_rect(Rect2(groove_x, groove_y, fill_w, groove_h), COLOR_GLOW_NEON, true)
		draw_circle(Vector2(groove_x + fill_w, groove_y + groove_h * 0.5), 3.5, Color(1.0, 1.0, 1.0, 0.95))
