extends Node

## TTSManager — Globalny menedżer lektora (Text-to-Speech) i dostępności UI
## Wykorzystuje natywne API DisplayServer w Godot 4.x oraz haptykę VR.

var tts_enabled: bool = true
var sound_compass_enabled: bool = true
var whoosh_volume_db: float = 3.0
var voice_rate: float = 1.0
var voice_volume: int = 80
var current_voice_id: String = ""

var _last_spoken_text: String = ""
var _last_spoken_time: float = 0.0
var _currently_hovered_control: Control = null
var _transition_lock_timer: float = 0.0

func _ready() -> void:
	_init_voices()
	# Warmup TTS w tle
	call_deferred("_warmup_tts")

func _process(delta: float) -> void:
	if _transition_lock_timer > 0.0:
		_transition_lock_timer -= delta

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
		# Cicha inicjalizacja silnika syntezy mowy, by uniknąć zacięcia przy 1. naciśnięciu
		DisplayServer.tts_speak(" ", current_voice_id, 0, 1.0, 1.0)
		DisplayServer.tts_stop()

## Wypowiada dany tekst przez syntezator TTS z zabezpieczeniem przed spamem
func speak(text: String, interrupt: bool = true) -> void:
	if not tts_enabled or text.is_empty():
		return
		
	if not DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		return
		
	var now = Time.get_ticks_msec() / 1000.0
	if text == _last_spoken_text and (now - _last_spoken_time) < 0.4:
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
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH) and DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()

## Blokuje najeżdżanie przycisków na chwilę po zmianie widoku (np. przełączenie na panel ustawień)
func announce_panel(panel_text: String) -> void:
	_transition_lock_timer = 0.5
	_currently_hovered_control = null
	speak(panel_text, true)

## Konfiguruje dostępność przycisku (odczyt po najechaniu/fokusie + dźwięk + wibracja)
func setup_button(button: Button, text_or_callable = "") -> void:
	if button == null:
		return
		
	# Bezpieczne podpięcie bez duplikowania wywołań
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
	if _transition_lock_timer > 0.0:
		return
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
	speak(speech_text, true)
	_trigger_ui_haptic(40.0, 0.3, 0.05)

func _on_control_unhovered(control: Control) -> void:
	if _currently_hovered_control == control:
		_currently_hovered_control = null

func _on_button_pressed() -> void:
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
