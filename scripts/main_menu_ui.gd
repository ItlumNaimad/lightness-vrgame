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
@onready var master_slider: HSlider = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/MasterVolumeContainer/MasterSlider
@onready var whoosh_slider: HSlider = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/WhooshVolumeContainer/WhooshSlider
@onready var compass_toggle: CheckButton = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/TogglesContainer/CompassToggle
@onready var tts_toggle: CheckButton = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/TogglesContainer/TTSToggle
@onready var back_from_settings_button: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/BackFromSettingsButton

# Kontrolki poradnika
@onready var back_from_guide_button: Button = $CenterContainer/PanelContainer/MarginContainer/GuidePanel/BackFromGuideButton

# Telemetria
@onready var last_time_label: Label = $CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/LastTimeValue

func _ready() -> void:
	_show_panel("main")
	_update_telemetry()
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

func _setup_accessibility() -> void:
	if Engine.is_editor_hint() or TTSManager == null:
		return
		
	TTSManager.setup_button(start_button, "Rozpocznij grę")
	TTSManager.setup_button(settings_button, "Ustawienia")
	TTSManager.setup_button(guide_button, "Sterowanie i poradnik")
	TTSManager.setup_button(exit_button, "Wyjście z gry")
	TTSManager.setup_button(back_from_settings_button, "Powrót do menu")
	TTSManager.setup_button(back_from_guide_button, "Powrót do menu")

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
		TTSManager.speak("Panel ustawień", true)

func _on_guide_button_pressed() -> void:
	_show_panel("guide")
	if TTSManager:
		TTSManager.speak("Sterowanie i poradnik. Lewy kontroler: obrót i sprint. Prawy kontroler: ruch i blokowanie szarży dłonią.", true)

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()

func _on_back_pressed() -> void:
	_show_panel("main")
	if TTSManager:
		TTSManager.speak("Menu główne", true)

func _on_master_slider_value_changed(value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("Master")
	if bus_idx >= 0:
		# Mapowanie suwaka (0.0 - 1.0) na dB (-40 dB do 0 dB)
		var db = linear_to_db(value)
		AudioServer.set_bus_volume_db(bus_idx, db)

func _on_compass_toggle_toggled(toggled_on: bool) -> void:
	if TTSManager:
		TTSManager.sound_compass_enabled = toggled_on
		TTSManager.speak("Kompas dźwiękowy " + ("włączony" if toggled_on else "wyłączony"), true)

func _on_tts_toggle_toggled(toggled_on: bool) -> void:
	if TTSManager:
		TTSManager.tts_enabled = toggled_on
		if toggled_on:
			TTSManager.speak("Lektor włączony", true)
