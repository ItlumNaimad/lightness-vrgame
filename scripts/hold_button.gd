extends Button
class_name HoldButton

## HoldButton — Przycisk interfejsu VR reagujący na kliknięcie spustu (trigger) kontrolera.
## Obsługuje zdarzenia InputEventMouseButton oraz InputEventScreenTouch z Viewport2Din3D.

@export var auto_click_on_hold: bool = false
@export var allow_repeat_on_hold: bool = false

var _is_hovered: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_hover_started)
	focus_entered.connect(_on_hover_started)
	mouse_exited.connect(_on_hover_ended)
	focus_exited.connect(_on_hover_ended)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		accept_event()
		emit_signal("pressed")

func _on_hover_started() -> void:
	_is_hovered = true

func _on_hover_ended() -> void:
	_is_hovered = false
