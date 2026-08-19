extends Node

## TTSManager — Globalny menedżer lektora (Text-to-Speech) i dostępności UI
## Wykorzystuje natywne API DisplayServer w Godot 4.x oraz haptykę VR.

var tts_enabled: bool = true
var sound_compass_enabled: bool = true
var voice_rate: float = 1.0
var voice_volume: int = 80
var current_voice_id: String = ""

func _ready() -> void:
	_init_voices()

func _init_voices() -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		var voices = DisplayServer.tts_get_voices()
		if voices.size() > 0:
			# Domyślnie bierzemy pierwszy dostępny głos lub szukamy polskiego / angielskiego
			current_voice_id = voices[0]["id"]
			for v in voices:
				var lang = v.get("language", "").to_lower()
				if "pl" in lang or "pol" in lang:
					current_voice_id = v["id"]
					break

## Wypowiada dany tekst przez syntezator TTS
func speak(text: String, interrupt: bool = true) -> void:
	if not tts_enabled or text.is_empty():
		return
		
	if not DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		return
		
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

## Konfiguruje dostępność przycisku (odczyt po najechaniu/fokusie + dźwięk + wibracja)
func setup_button(button: Button, custom_text: String = "") -> void:
	if button == null:
		return
		
	var speech = custom_text if not custom_text.is_empty() else button.text
	
	# Usunięcie symboli dekoracyjnych z tekstu do odczytania (np. ⟳, ⌂, ▶, ⚙)
	speech = speech.replace("⟳", "").replace("⌂", "").replace("▶", "").replace("⚙", "").replace("✕", "").replace("🎮", "").replace("⮌", "").strip_edges()
	
	if not button.focus_entered.is_connected(_on_button_focused.bind(speech)):
		button.focus_entered.connect(_on_button_focused.bind(speech))
	if not button.mouse_entered.is_connected(_on_button_focused.bind(speech)):
		button.mouse_entered.connect(_on_button_focused.bind(speech))
	if not button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)

func _on_button_focused(speech_text: String) -> void:
	speak(speech_text, true)
	_trigger_ui_haptic(40.0, 0.3, 0.05)

func _on_button_pressed() -> void:
	_trigger_ui_haptic(100.0, 0.8, 0.1)

func _trigger_ui_haptic(frequency: float, amplitude: float, duration: float) -> void:
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
		var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
		if left_hand and left_hand is XRController3D:
			left_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
		if right_hand and right_hand is XRController3D:
			right_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
