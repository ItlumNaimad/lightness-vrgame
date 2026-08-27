extends Button
class_name HoldButton

## HoldButton — Interaktywny przycisk VR stylizowany na wyryty w betonowej ścianie.
## Po najechaniu wskaźnikiem napis delikatnie wysuwa się w stronę gracza (scale-up) i rozbłyska.
## Zatwierdzenie opcji następuje po przytrzymaniu spustu (trigger), przycisku "A" lub przytrzymaniu wskaźnika,
## czemu towarzyszy cyberpunkowo-eldrytcka animacja napełniającego się paska energii.

@export var charge_time_hold: float = 0.45   # Czas przytrzymania triggera / przycisku "A"
@export var charge_time_dwell: float = 0.85  # Czas automatycznego zatwierdzenia samym wskaźnikiem
@export var allow_repeat_on_hold: bool = false

var _is_hovered: bool = false
var _charge: float = 0.0
var _hover_dwell_timer: float = 0.0
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
	# Usuwamy wszelkie prostokątne tła — napis ma leżeć bezpośrednio na ścianie
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
	# Płynne skalowanie wyrytego napisu (wysuwanie w stronę gracza)
	_current_scale = lerp(_current_scale, _target_scale, delta * 12.0)
	scale = Vector2(_current_scale, _current_scale)
	
	if not _is_hovered:
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()
		_hover_dwell_timer = 0.0
		return

	# Gracz celuje we wskaźnik
	var is_pressing := _is_action_active()
	
	if is_pressing:
		# Gracz trzyma spust (trigger), przycisk A lub lewy klik -> szybkie ładowanie (0.45s)
		_charge += delta / max(0.05, charge_time_hold)
		queue_redraw()
	else:
		# Gracz celuje samym laserem bez wciskania przycisków -> dwell charge
		_hover_dwell_timer += delta
		if _hover_dwell_timer > 0.2:
			_charge += delta / max(0.1, charge_time_dwell)
			queue_redraw()
		elif _charge > 0.0:
			_charge = max(0.0, _charge - delta * 2.0)
			queue_redraw()

	# Warunek aktywacji (100% naładowania)
	if _charge >= 1.0:
		_trigger_activation()

func _trigger_activation() -> void:
	_charge = 0.0
	_hover_dwell_timer = 0.0
	queue_redraw()
	
	# Efekt rozbłysku potwierdzenia
	_current_scale = 1.14
	scale = Vector2(_current_scale, _current_scale)
	
	# Dźwięk potwierdzenia
	if TTSManager:
		TTSManager.play_turn_sound(0.1)
	
	# Wibracja w kontrolerze (haptics)
	_trigger_haptic_feedback()
	
	# Wywołanie akcji
	emit_signal("pressed")

func _is_action_active() -> bool:
	# 1. Odpytanie serwera OpenXR o kontrolery VR (spust, przycisk A, przycisk B)
	for tracker_name in [&"right_hand", &"left_hand"]:
		var tracker = XRServer.get_tracker(tracker_name)
		if tracker:
			# Spust analogowy
			var trig = tracker.get_input(&"trigger")
			if trig is float and trig >= 0.25:
				return true
			# Trigger click
			var trig_click = tracker.get_input(&"trigger_click")
			if (trig_click is bool and trig_click) or (trig_click is float and trig_click >= 0.25):
				return true
			# Przycisk "A" (primary_click)
			var prim = tracker.get_input(&"primary_click")
			if (prim is bool and prim) or (prim is float and prim >= 0.25):
				return true
			# Przycisk "B" (secondary_click)
			var sec = tracker.get_input(&"secondary_click")
			if (sec is bool and sec) or (sec is float and sec >= 0.25):
				return true
			# Grip
			var grip = tracker.get_input(&"grip_click")
			if (grip is bool and grip) or (grip is float and grip >= 0.25):
				return true

	# 2. Tradycyjne zdarzenia myszy i klawiatury
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return true
	if Input.is_action_pressed("ui_accept"):
		return true

	return false

func _trigger_haptic_feedback() -> void:
	for tracker_name in [&"right_hand", &"left_hand"]:
		var tracker = XRServer.get_tracker(tracker_name)
		if tracker and tracker.has_method("trigger_haptic_pulse"):
			tracker.trigger_haptic_pulse("haptic", 100.0, 0.6, 0.1, 0.0)

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
	# Kliknięcie natychmiastowe (tap)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and _is_hovered:
			_trigger_activation()
	elif event is InputEventScreenTouch and event.pressed:
		_trigger_activation()

func _draw() -> void:
	# Rysowanie wyrytego rowka napełniającego się energią pod napisem
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
	
	# 2. Napełniający się strumień energii (#00ffa3)
	if _charge > 0.01:
		var fill_w: float = groove_w * clamp(_charge, 0.0, 1.0)
		var fill_rect := Rect2(groove_x, groove_y, fill_w, groove_h)
		# Poświata
		draw_rect(Rect2(groove_x, groove_y - 1.0, fill_w, groove_h + 2.0), Color(0.0, 1.0, 0.64, 0.25), true)
		# Rdzeń
		draw_rect(fill_rect, COLOR_GLOW_NEON, true)
		# Iskra na czele ładowania
		draw_circle(Vector2(groove_x + fill_w, groove_y + groove_h * 0.5), 3.0, Color(1.0, 1.0, 1.0, 0.95))
