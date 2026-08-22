@tool
extends Control

signal start_pressed
signal exit_pressed

@onready var main_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/MainPanel
@onready var settings_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel
@onready var guide_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/GuidePanel

# Przyciski główne
@onready var start_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/StartButton
@onready var settings_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SettingsButton
@onready var guide_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/GuideButton
@onready var exit_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/ExitButton

# Kontrolki ustawień
@onready var master_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterRow/MasterMinusBtn
@onready var master_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterRow/MasterPlusBtn
@onready var master_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterRow/MasterValueLabel

@onready var whoosh_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshRow/WhooshMinusBtn
@onready var whoosh_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshRow/WhooshPlusBtn
@onready var whoosh_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshRow/WhooshValueLabel

@onready var compass_toggle_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/CompassToggleBtn
@onready var tts_toggle_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSToggleBtn
@onready var back_from_settings_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/BackFromSettingsButton

# Kontrolki poradnika
@onready var back_from_guide_btn: Button = $CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/BackFromGuideButton

# Telemetria
@onready var last_time_label: Label = $CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/HBoxContainer/LastTimeValue

var _master_volume_percent: int = 80
var _whoosh_volume_db: float = 3.0

func _ready() -> void:
	_show_panel("main")
	_update_telemetry()
	_update_settings_ui()
	_setup_accessibility()

func _update_telemetry() -> void:
	if last_time_label:
		if SceneLoader and SceneLoader.last_survival_time > 0.0:
			var total_seconds: int = int(SceneLoader.last_survival_time)
			var minutes: int = int(total_seconds / 60.0)
			var seconds: int = total_seconds % 60
			last_time_label.text = "%02d:%02d" % [minutes, seconds]
		else:
			last_time_label.text = "--:--"

func _update_settings_ui() -> void:
	if master_value_label:
		master_value_label.text = "%d%%" % _master_volume_percent
	if whoosh_value_label:
		whoosh_value_label.text = "%+.1f dB" % _whoosh_volume_db
	if compass_toggle_btn:
		var is_on = TTSManager.sound_compass_enabled if TTSManager else true
		compass_toggle_btn.text = "Sound Compass: " + ("ON" if is_on else "OFF")
	if tts_toggle_btn:
		var is_on = TTSManager.tts_enabled if TTSManager else true
		tts_toggle_btn.text = "TTS Voice: " + ("ON" if is_on else "OFF")

func _setup_accessibility() -> void:
	if Engine.is_editor_hint() or TTSManager == null:
		return
		
	TTSManager.setup_button(start_button, "Start game - Rozpocznij grę")
	TTSManager.setup_button(settings_button, "Settings - Ustawienia")
	TTSManager.setup_button(guide_button, "Guide - Sterowanie i poradnik")
	TTSManager.setup_button(exit_button, "Exit - Wyjście z gry")
	
	# Ustawienia z dynamicznym odczytem
	TTSManager.setup_button(master_minus_btn, func(): return "Zmniejsz głośność główną. Aktualnie %d procent" % _master_volume_percent)
	TTSManager.setup_button(master_plus_btn, func(): return "Zwiększ głośność główną. Aktualnie %d procent" % _master_volume_percent)
	TTSManager.setup_button(whoosh_minus_btn, func(): return "Zmniejsz głośność obrotu. Aktualnie %.1f decybeli" % _whoosh_volume_db)
	TTSManager.setup_button(whoosh_plus_btn, func(): return "Zwiększ głośność obrotu. Aktualnie %.1f decybeli" % _whoosh_volume_db)
	TTSManager.setup_button(compass_toggle_btn, func(): return "Kompas dźwiękowy. Aktualnie " + ("włączony" if (TTSManager and TTSManager.sound_compass_enabled) else "wyłączony"))
	TTSManager.setup_button(tts_toggle_btn, func(): return "Lektor syntezatora. Aktualnie " + ("włączony" if (TTSManager and TTSManager.tts_enabled) else "wyłączony"))
	TTSManager.setup_button(back_from_settings_btn, "Powrót do menu głównego")
	TTSManager.setup_button(back_from_guide_btn, "Powrót do menu głównego")

func _show_panel(panel_name: String) -> void:
	if main_panel:
		main_panel.visible = (panel_name == "main")
	if settings_panel:
		settings_panel.visible = (panel_name == "settings")
	if guide_panel:
		guide_panel.visible = (panel_name == "guide")

func _on_start_button_pressed() -> void:
	start_pressed.emit()

func _on_settings_button_pressed() -> void:
	_show_panel("settings")
	if TTSManager:
		TTSManager.announce_panel("Ekran ustawień. Użyj przycisków plus i minus aby dostosować głośność.")

func _on_guide_button_pressed() -> void:
	_show_panel("guide")
	if TTSManager:
		TTSManager.announce_panel("Sterowanie i poradnik. Lewy kontroler: obrót i sprint. Prawy kontroler: ruch i blokowanie szarży dłonią.")

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()

func _on_back_pressed() -> void:
	_show_panel("main")
	if TTSManager:
		TTSManager.announce_panel("Menu główne")

# Obsługa przycisków głośności głównej
func _on_master_minus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent - 10, 0, 100)
	_apply_master_volume()
	_update_settings_ui()
	if TTSManager:
		TTSManager.speak("Głośność główna: %d procent" % _master_volume_percent, true)

func _on_master_plus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent + 10, 0, 100)
	_apply_master_volume()
	_update_settings_ui()
	if TTSManager:
		TTSManager.speak("Głośność główna: %d procent" % _master_volume_percent, true)

func _apply_master_volume() -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	if bus_idx >= 0:
		var linear = _master_volume_percent / 100.0
		var db = linear_to_db(linear) if linear > 0.01 else -80.0
		AudioServer.set_bus_volume_db(bus_idx, db)

# Obsługa przycisków głośności whoosh
func _on_whoosh_minus_pressed() -> void:
	_whoosh_volume_db = clamp(_whoosh_volume_db - 2.0, -10.0, 15.0)
	if TTSManager:
		TTSManager.whoosh_volume_db = _whoosh_volume_db
		TTSManager.speak("Głośność obrotu: %.0f decybeli" % _whoosh_volume_db, true)
	_update_settings_ui()

func _on_whoosh_plus_pressed() -> void:
	_whoosh_volume_db = clamp(_whoosh_volume_db + 2.0, -10.0, 15.0)
	if TTSManager:
		TTSManager.whoosh_volume_db = _whoosh_volume_db
		TTSManager.speak("Głośność obrotu: %.0f decybeli" % _whoosh_volume_db, true)
	_update_settings_ui()

# Obsługa przełączników
func _on_compass_toggle_pressed() -> void:
	if TTSManager:
		TTSManager.sound_compass_enabled = not TTSManager.sound_compass_enabled
		_update_settings_ui()
		TTSManager.speak("Kompas dźwiękowy " + ("włączony" if TTSManager.sound_compass_enabled else "wyłączony"), true)

func _on_tts_toggle_pressed() -> void:
	if TTSManager:
		TTSManager.tts_enabled = not TTSManager.tts_enabled
		_update_settings_ui()
		if TTSManager.tts_enabled:
			TTSManager.speak("Lektor włączony", true)
