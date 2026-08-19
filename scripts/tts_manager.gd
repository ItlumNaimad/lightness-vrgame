extends Node

## TTSManager — Globalny menedżer lektora (Text-to-Speech) i dostępności UI
## Wykorzystuje natywne API DisplayServer w Godot 4.x z buforowaniem i odrzucaniem spamu (Dwell Debounce).

var tts_enabled: bool = true
var sound_compass_enabled: bool = true
var whoosh_volume_db: float = 3.0
var voice_rate: float = 1.0
var voice_volume: int = 80
var current_voice_id: String = ""

var _last_spoken_text: String = ""
var _last_spoken_time: float = 0.0
var _currently_hovered_control: Control = null

# Dwell Debounce — zapobiega zacinaniu wątku SAPI Windows przy szybkim przesuwaniu lasera
var _pending_speech_text: String = ""
var _pending_dwell_time: float = 0.0
const DWELL_THRESHOLD: float = 0.08 # 80ms pauzy na przycisku zanim lektor zacznie mówić

func _ready() -> void:
	_init_voices()
	call_deferred("_warmup_tts")

func _process(delta: float) -> void:
	if _pending_dwell_time > 0.0:
		_pending_dwell_time -= delta
		if _pending_dwell_time <= 0.0 and not _pending_speech_text.is_empty():
			_execute_speak(_pending_speech_text)
			_pending_speech_text = ""

func _init_voices() -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		var voices = DisplayServer.tts_get_voices()
		if voices.size() > 0:
			current_voice_id = voices[0]["id"]
			for v in voices:
				var lang = v.get("language", "").to_lower()
				if "pl" in lang or "pol" in lang:
					current_voice_id = v["id"]
					break

func _warmup_tts() -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH) and not current_voice_id.is_empty():
		DisplayServer.tts_speak(" ", current_voice_id, 0, 1.0, 1.0)
		DisplayServer.tts_stop()

## Wypowiada dany tekst natychmiast lub z opóźnieniem dwell
func speak(text: String, interrupt: bool = true) -> void:
	if not tts_enabled or text.is_empty():
		return
		
	if not DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		return
		
	# Bezpośrednie wywołanie dla kliknięć / akcji
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	_execute_speak(text, interrupt)

func _execute_speak(text: String, interrupt: bool = true) -> void:
	var now = Time.get_ticks_msec() / 1000.0
	if text == _last_spoken_text and (now - _last_spoken_time) < 0.35:
		return
		
	_last_spoken_text = text
	_last_spoken_time = now
	
	if interrupt and DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()
		
	if not current_voice_id.is_empty():
		DisplayServer.tts_speak(text, current_voice_id, voice_volume, 1.0, voice_rate)
	else:
		var voices = DisplayServer.tts_get_voices()
		if voices.size() > 0:
			current_voice_id = voices[0]["id"]
			DisplayServer.tts_speak(text, current_voice_id, voice_volume, 1.0, voice_rate)

## Zatrzymuje aktualną mowę
func stop() -> void:
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH) and DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()

## Zapowiedź otwartego panelu
func announce_panel(panel_text: String) -> void:
	_currently_hovered_control = null
	speak(panel_text, true)

## Konfiguruje dostępność przycisku
func setup_button(button: Button, text_or_callable = "") -> void:
	if button == null:
		return
		
	if not button.focus_entered.is_connected(_on_control_hovered.bind(button, text_or_callable)):
		button.focus_entered.connect(_on_control_hovered.bind(button, text_or_callable))
	if not button.mouse_entered.is_connected(_on_control_hovered.bind(button, text_or_callable)):
		button.mouse_entered.connect(_on_control_hovered.bind(button, text_or_callable))
	if not button.mouse_exited.is_connected(_on_control_unhovered.bind(button)):
		button.mouse_exited.connect(_on_control_unhovered.bind(button))
	if not button.focus_exited.is_connected(_on_control_unhovered.bind(button)):
		button.focus_exited.connect(_on_control_unhovered.bind(button))
	if not button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)

func _on_control_hovered(control: Control, text_or_callable) -> void:
	if _currently_hovered_control == control:
		return
	_currently_hovered_control = control
	
	var speech_text = ""
	if text_or_callable is Callable:
		speech_text = str(text_or_callable.call())
	elif text_or_callable is String and not text_or_callable.is_empty():
		speech_text = text_or_callable
	elif control is Button:
		speech_text = control.text
		
	speech_text = _clean_symbols(speech_text)
	
	# Kolejkujemy z dwell threshold, by nie blokować wątku SAPI przy przesuwaniu lasera
	_pending_speech_text = speech_text
	_pending_dwell_time = DWELL_THRESHOLD
	_trigger_ui_haptic(35.0, 0.25, 0.04)

func _on_control_unhovered(control: Control) -> void:
	if _currently_hovered_control == control:
		_currently_hovered_control = null
		_pending_speech_text = ""
		_pending_dwell_time = 0.0

func _on_button_pressed() -> void:
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	_trigger_ui_haptic(100.0, 0.8, 0.1)

func _clean_symbols(text: String) -> String:
	return text.replace("⟳", "").replace("⌂", "").replace("▶", "").replace("⚙", "").replace("✕", "").replace("🎮", "").replace("⮌", "").replace("•", "").replace("—", "-").strip_edges()

func _trigger_ui_haptic(frequency: float, amplitude: float, duration: float) -> void:
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
		var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
		if left_hand and left_hand is XRController3D:
			left_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
		if right_hand and right_hand is XRController3D:
			right_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
