extends Button
class_name HoldButton

## HoldButton — Interaktywny przycisk VR stylizowany na wyryty w betonowej ścianie.
## Po najechaniu wskaźnikiem napis delikatnie wysuwa się w stronę gracza (scale-up) i rozbłyska.
## Samo najechanie NIE ładuje opcji. Aby zatwierdzić, gracz musi PRZYTRZYMAĆ spust (trigger)
## lub przycisk "A" na kontrolerze tak długo, aż pasek energii napełni się w 100%.

@export var charge_time_hold: float = 0.55   # Czas przytrzymania spustu (trigger) do zatwierdzenia

var _is_hovered: bool = false
var _is_input_holding: bool = false
var _charge: float = 0.0
var _cooldown: float = 0.0
var _current_scale: float = 1.0
var _target_scale: float = 1.0
var _tween: Tween

# Kolory kamiennego wyrycia (Normal)
const COLOR_ENGRAVED_TEXT := Color(0.60, 0.66, 0.74, 0.8)
const COLOR_ENGRAVED_SHADOW := Color(0.01, 0.015, 0.02, 0.95)
const COLOR_ENGRAVED_OUTLINE := Color(0.03, 0.05, 0.07, 0.95)

# Kolory rozżarzonego neonu w ścianie (Hover)
const COLOR_GLOW_TEXT := Color(1.0, 1.0, 1.0, 1.0)
const COLOR_GLOW_NEON := Color(0.0, 1.0, 0.64, 1.0)
const COLOR_GLOW_AURA := Color(0.0, 1.0, 0.64, 0.6)

func _ready() -> void:
	# Usuwamy wszelkie prostokątne tła — napis leży bezpośrednio na ścianie
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
	gui_input.connect(_on_gui_input)
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

func _process(delta: float) -> void:
	# Cooldown po zatwierdzeniu — blokuje natychmiastowe kliknięcie na kolejnym ekranie
	if _cooldown > 0.0:
		_cooldown -= delta
		_charge = 0.0
		_is_input_holding = false
		queue_redraw()
		return

	# Płynne skalowanie wyrytego napisu (wysuwanie w stronę gracza)
	_current_scale = lerp(_current_scale, _target_scale, delta * 12.0)
	scale = Vector2(_current_scale, _current_scale)
	
	# Jeśli gracz nie najeżdża na napis:
	if not _is_hovered:
		_is_input_holding = false
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()
		return

	# Gracz najeżdża na napis — sprawdzamy CZY TRZYMA SPUST / PRZYCISK:
	var holding := _is_input_holding or _is_trigger_down_on_controller() or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	
	if holding:
		# Ładowanie postępuje TYLKO wtedy, gdy trigger/przycisk jest aktywnie trzymany!
		_charge += delta / max(0.05, charge_time_hold)
		queue_redraw()
		
		# Sprawdzenie warunku zatwierdzenia (100% naładowania)
		if _charge >= 1.0:
			_trigger_activation()
	else:
		# Gracz tylko najeżdża laserem LUB puścił trigger przed dojściem do 100%:
		# Pasek energii cofa się do zera. Samo najechanie NIE ładuje opcji!
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()

func _trigger_activation() -> void:
	_charge = 0.0
	_is_input_holding = false
	_cooldown = 0.4  # 0.4s przerwy
	queue_redraw()
	
	# Efekt rozbłysku potwierdzenia
	_current_scale = 1.14
	scale = Vector2(_current_scale, _current_scale)
	
	# 1. BEZWZGLĘDNIE NAJPIERW: Wywołanie akcji przycisku
	emit_signal("pressed")
	
	# 2. Bezpieczna haptyka przez XRServer
	_trigger_haptic_feedback()

func _is_trigger_down_on_controller() -> bool:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		for hand_name in ["XROrigin3D/right_hand", "XROrigin3D/left_hand"]:
			var ctrl = player.get_node_or_null(hand_name) as XRController3D
			if ctrl and ctrl.get_is_active():
				# Spust analogowy wciśnięty powyżej 40%
				if ctrl.get_float("trigger") > 0.4:
					return true
				# Przycisk "A" na Quest (ax_button)
				if ctrl.is_button_pressed("ax_button"):
					return true
				# Spust binarny
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
	_target_scale = 1.07  # Delikatne wysunięcie w stronę gracza
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	
	# Płynne rozbłyśnięcie szczelin neonem
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
	_target_scale = 1.0  # Powrót do poziomu ściany
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	
	# Powrót do matowego wyrycia w kamieniu
	_tween.tween_property(self, "theme_override_colors/font_color", COLOR_ENGRAVED_TEXT, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_outline_color", COLOR_ENGRAVED_OUTLINE, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_shadow_color", COLOR_ENGRAVED_SHADOW, 0.25)
	_tween.tween_property(self, "theme_override_constants/outline_size", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_x", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_y", 3, 0.25)
	queue_redraw()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_is_input_holding = event.pressed
	elif event is InputEventScreenTouch:
		_is_input_holding = event.pressed

func _draw() -> void:
	# Rysowanie wyrytego rowka i napełniającego się paska energii pod napisem
	if not _is_hovered and _charge <= 0.01:
		return
		
	var w := size.x
	var h := size.y
	
	# Położenie rowka w ścianie (wyśrodkowany pod tekstem)
	var groove_w: float = min(w * 0.65, 340.0)
	var groove_x: float = (w - groove_w) * 0.5
	var groove_y: float = h - 6.0
	var groove_h: float = 3.0
	
	# 1. Ciemna szczelina wyryta w ścianie
	var groove_rect := Rect2(groove_x, groove_y, groove_w, groove_h)
	draw_rect(groove_rect, Color(0.02, 0.04, 0.06, 0.6), true)
	
	# 2. Napełniający się strumień energii (#00ffa3) — widoczny TYLKO gdy trigger jest trzymany!
	if _charge > 0.01:
		var fill_w: float = groove_w * clamp(_charge, 0.0, 1.0)
		var fill_rect := Rect2(groove_x, groove_y, fill_w, groove_h)
		# Poświata
		draw_rect(Rect2(groove_x, groove_y - 1.0, fill_w, groove_h + 2.0), Color(0.0, 1.0, 0.64, 0.3), true)
		# Rdzeń
		draw_rect(fill_rect, COLOR_GLOW_NEON, true)
		# Iskra na czele ładowania
		draw_circle(Vector2(groove_x + fill_w, groove_y + groove_h * 0.5), 3.5, Color(1.0, 1.0, 1.0, 0.95))
