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
@onready var tts_toggle_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox/TTSToggleBtn

@onready var master_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterMinusBtn
@onready var master_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterPlusBtn
@onready var master_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterValueLabel
@onready var master_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterProgressBar

@onready var enemies_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesMinusBtn
@onready var enemies_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesPlusBtn
@onready var enemies_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesValueLabel
@onready var enemies_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesProgressBar

@onready var footsteps_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsMinusBtn
@onready var footsteps_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsPlusBtn
@onready var footsteps_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsValueLabel
@onready var footsteps_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsProgressBar

@onready var whoosh_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshCard/Margin/HBox/Controls/WhooshMinusBtn
@onready var whoosh_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshCard/Margin/HBox/Controls/WhooshPlusBtn
@onready var whoosh_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshCard/Margin/HBox/Controls/WhooshValueLabel
@onready var whoosh_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/WhooshCard/Margin/HBox/Controls/WhooshProgressBar

@onready var jumpscare_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareMinusBtn
@onready var jumpscare_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscarePlusBtn
@onready var jumpscare_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareValueLabel
@onready var jumpscare_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareProgressBar

@onready var back_from_settings_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/BackFromSettingsButton

# Kontrolki poradnika
@onready var back_from_guide_btn: Button = $CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/BackFromGuideButton

# Telemetria
@onready var last_time_label: Label = $CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/HBoxContainer/LastTimeValue

var _master_volume_percent: int = 80
var _enemies_volume_percent: int = 85
var _footsteps_volume_percent: int = 80
var _whoosh_volume_percent: int = 75
var _jumpscare_volume_percent: int = 90

func _ready() -> void:
	_show_panel("main")
	_update_telemetry()
	_apply_all_audio_buses()
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

func _apply_all_audio_buses() -> void:
	_apply_bus_volume("Master", _master_volume_percent)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_apply_bus_volume("Whoosh", _whoosh_volume_percent)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)

func _apply_bus_volume(bus_name: String, percent: int) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx >= 0:
		var linear = percent / 100.0
		var db = linear_to_db(linear) if linear > 0.01 else -80.0
		AudioServer.set_bus_volume_db(bus_idx, db)

func _update_settings_ui() -> void:
	if master_value_label: master_value_label.text = "%d%%" % _master_volume_percent
	if master_progress_bar: master_progress_bar.value = _master_volume_percent

	if enemies_value_label: enemies_value_label.text = "%d%%" % _enemies_volume_percent
	if enemies_progress_bar: enemies_progress_bar.value = _enemies_volume_percent

	if footsteps_value_label: footsteps_value_label.text = "%d%%" % _footsteps_volume_percent
	if footsteps_progress_bar: footsteps_progress_bar.value = _footsteps_volume_percent

	if whoosh_value_label: whoosh_value_label.text = "%d%%" % _whoosh_volume_percent
	if whoosh_progress_bar: whoosh_progress_bar.value = _whoosh_volume_percent

	if jumpscare_value_label: jumpscare_value_label.text = "%d%%" % _jumpscare_volume_percent
	if jumpscare_progress_bar: jumpscare_progress_bar.value = _jumpscare_volume_percent

	if tts_toggle_btn:
		var is_on = TTSManager.tts_enabled if TTSManager else true
		tts_toggle_btn.text = "TTS Voice: " + ("ON" if is_on else "OFF")

func _setup_accessibility() -> void:
	if Engine.is_editor_hint() or TTSManager == null:
		return
		
	TTSManager.setup_button(start_button, "Start Game")
	TTSManager.setup_button(settings_button, "Settings")
	TTSManager.setup_button(guide_button, "Controls and Survival Guide")
	TTSManager.setup_button(exit_button, "Exit Game")
	
	# Settings controls with dynamic speech
	TTSManager.setup_button(master_minus_btn, func(): return "Decrease master volume. Currently %d percent" % _master_volume_percent)
	TTSManager.setup_button(master_plus_btn, func(): return "Increase master volume. Currently %d percent" % _master_volume_percent)
	
	TTSManager.setup_button(enemies_minus_btn, func(): return "Decrease enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	TTSManager.setup_button(enemies_plus_btn, func(): return "Increase enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	
	TTSManager.setup_button(footsteps_minus_btn, func(): return "Decrease footstep volume. Currently %d percent" % _footsteps_volume_percent)
	TTSManager.setup_button(footsteps_plus_btn, func(): return "Increase footstep volume. Currently %d percent" % _footsteps_volume_percent)

	TTSManager.setup_button(whoosh_minus_btn, func(): return "Decrease turn sound volume. Currently %d percent" % _whoosh_volume_percent)
	TTSManager.setup_button(whoosh_plus_btn, func(): return "Increase turn sound volume. Currently %d percent" % _whoosh_volume_percent)

	TTSManager.setup_button(jumpscare_minus_btn, func(): return "Decrease jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)
	TTSManager.setup_button(jumpscare_plus_btn, func(): return "Increase jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)

	TTSManager.setup_button(tts_toggle_btn, func(): return "TTS Voice. Currently " + ("enabled" if (TTSManager and TTSManager.tts_enabled) else "disabled"))
	TTSManager.setup_button(back_from_settings_btn, "Back to Main Menu")
	TTSManager.setup_button(back_from_guide_btn, "Back to Main Menu")

func _show_panel(panel_name: String) -> void:
	print("[MainMenuUI] Switching to panel: ", panel_name)
	if main_panel:
		main_panel.visible = (panel_name == "main")
	if settings_panel:
		settings_panel.visible = (panel_name == "settings")
	if guide_panel:
		guide_panel.visible = (panel_name == "guide")

func _on_start_button_pressed() -> void:
	print("[MainMenuUI] Start button pressed! Emitting start_pressed...")
	start_pressed.emit()
	if start_pressed.get_connections().is_empty():
		SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_settings_button_pressed() -> void:
	print("[MainMenuUI] Settings button pressed! Calling _show_panel('settings')")
	_show_panel("settings")
	if TTSManager:
		TTSManager.announce_panel("Audio settings screen. Adjust master, enemies, footsteps, turn sound and jumpscares.")

func _on_guide_button_pressed() -> void:
	_show_panel("guide")
	if TTSManager:
		TTSManager.announce_panel("Controls and survival guide. Left controller: snap turn and sprint. Right controller: move and block charges.")

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
	if exit_pressed.get_connections().is_empty():
		get_tree().quit()

func _on_back_pressed() -> void:
	_show_panel("main")
	if TTSManager:
		TTSManager.announce_panel("Main Menu")

# Master volume
func _on_master_minus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent - 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

func _on_master_plus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent + 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

# Enemies volume
func _on_enemies_minus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent - 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

func _on_enemies_plus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent + 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

# Footsteps volume
func _on_footsteps_minus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent - 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

func _on_footsteps_plus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent + 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

# Whoosh turn sound
func _on_whoosh_minus_pressed() -> void:
	_whoosh_volume_percent = clamp(_whoosh_volume_percent - 10, 0, 100)
	_apply_bus_volume("Whoosh", _whoosh_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Turn sound volume: %d percent" % _whoosh_volume_percent, true)

func _on_whoosh_plus_pressed() -> void:
	_whoosh_volume_percent = clamp(_whoosh_volume_percent + 10, 0, 100)
	_apply_bus_volume("Whoosh", _whoosh_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Turn sound volume: %d percent" % _whoosh_volume_percent, true)

# Jumpscare volume
func _on_jumpscare_minus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent - 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

func _on_jumpscare_plus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent + 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

# Toggle buttons
func _on_tts_toggle_pressed() -> void:
	if TTSManager:
		TTSManager.tts_enabled = not TTSManager.tts_enabled
		_update_settings_ui()
		if TTSManager.tts_enabled:
			TTSManager.speak("TTS voice enabled", true)
