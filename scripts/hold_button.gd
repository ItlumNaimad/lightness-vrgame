extends Button
class_name HoldButton

## HoldButton — Przycisk interfejsu VR reagujący natychmiast na kliknięcie spustu (trigger).
## Wykorzystuje połączenie sygnału gui_input (nie nadpisując wbudowanej implementacji C++ Button).

@export var auto_click_on_hold: bool = false
@export var allow_repeat_on_hold: bool = false

var _is_hovered: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_hover_started)
	focus_entered.connect(_on_hover_started)
	mouse_exited.connect(_on_hover_ended)
	focus_exited.connect(_on_hover_ended)
	gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	# Obsługa dotyku z Viewport2Din3D
	if event is InputEventScreenTouch and event.pressed:
		accept_event()
		emit_signal("pressed")
		return
	
	# Zabezpieczenie przed mikrodrżeniem ręki w VR:
	# Jeśli gracz najechał laserem na przycisk i puścił przycisk myszy/spust, wywołaj kliknięcie
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and _is_hovered:
			emit_signal("pressed")

func _on_hover_started() -> void:
	_is_hovered = true

func _on_hover_ended() -> void:
	_is_hovered = false
