@tool
extends Button
class_name HoldButton

## HoldButton — Przycisk z wizualnym wskaźnikiem ładowania (Hold-to-Click)
## Animacja pojawia się TYLKO na przycisku po najechaniu/dotknięciu i trwa hold_time sekund.

@export var hold_time: float = 0.7
@export var auto_click_on_hold: bool = true

var _time_held: float = 0.0
var _is_hovered: bool = false
var _has_clicked: bool = false

var _progress_bar: ProgressBar

func _ready() -> void:
	mouse_entered.connect(_on_hover_started)
	focus_entered.connect(_on_hover_started)
	mouse_exited.connect(_on_hover_ended)
	focus_exited.connect(_on_hover_ended)
	pressed.connect(_on_pressed_manually)
	
	_create_progress_bar()

func _create_progress_bar() -> void:
	if _progress_bar == null:
		_progress_bar = ProgressBar.new()
		_progress_bar.show_percentage = false
		_progress_bar.max_value = 1.0
		_progress_bar.value = 0.0
		_progress_bar.mouse_filter = Control.MOUSE_FILTER_IGNORE
		_progress_bar.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
		_progress_bar.custom_minimum_size = Vector2(0, 4)
		
		# Styl paska fosforowego
		var style_fill = StyleBoxFlat.new()
		style_fill.bg_color = Color(0.0, 1.0, 0.64, 0.9)
		style_fill.set_corner_radius_all(2)
		_progress_bar.add_theme_stylebox_override("fill", style_fill)
		
		var style_bg = StyleBoxFlat.new()
		style_bg.bg_color = Color(0.0, 0.0, 0.0, 0.3)
		_progress_bar.add_theme_stylebox_override("background", style_bg)
		
		add_child(_progress_bar)
		_progress_bar.visible = false

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
		
	if _is_hovered and not _has_clicked and auto_click_on_hold:
		_time_held += delta
		if _progress_bar:
			_progress_bar.visible = true
			_progress_bar.value = clamp(_time_held / hold_time, 0.0, 1.0)
			
		if _time_held >= hold_time:
			_has_clicked = true
			_time_held = 0.0
			if _progress_bar:
				_progress_bar.visible = false
			emit_signal("pressed")
	else:
		if _progress_bar and not _is_hovered:
			_progress_bar.visible = false
			_progress_bar.value = 0.0

func _on_hover_started() -> void:
	_is_hovered = true
	_has_clicked = false
	_time_held = 0.0

func _on_hover_ended() -> void:
	_is_hovered = false
	_has_clicked = false
	_time_held = 0.0
	if _progress_bar:
		_progress_bar.visible = false
		_progress_bar.value = 0.0

func _on_pressed_manually() -> void:
	_has_clicked = true
	_time_held = 0.0
	if _progress_bar:
		_progress_bar.visible = false
