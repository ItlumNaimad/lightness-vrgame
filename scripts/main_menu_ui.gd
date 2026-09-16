extends Control

signal start_pressed
signal exit_pressed

@onready var main_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/MainPanel
@onready var settings_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel
@onready var guide_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/GuidePanel
@onready var nights_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/NightsPanel

# Przyciski główne
@onready var start_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/StartButton
@onready var select_night_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SelectNightButton
@onready var settings_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SettingsButton
@onready var guide_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/GuideButton
@onready var exit_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/ExitButton

# Kontrolki wyboru nocy
@onready var night_0_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night0Btn
@onready var night_1_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night1Btn
@onready var night_2_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night2Btn
@onready var night_3_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night3Btn
@onready var night_4_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night4Btn
@onready var night_5_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night5Btn
@onready var night_6_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night6Btn
@onready var back_from_nights_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/BackFromNightsButton

# Kontrolki ustawień
@onready var tts_toggle_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox/TTSToggleBtn

@onready var master_row_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/MasterRowBtn
@onready var master_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterMinusBtn
@onready var master_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterPlusBtn
@onready var master_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterValueLabel
@onready var master_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterProgressBar

@onready var enemies_row_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/EnemiesRowBtn
@onready var enemies_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesMinusBtn
@onready var enemies_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesPlusBtn
@onready var enemies_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesValueLabel
@onready var enemies_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesProgressBar

@onready var footsteps_row_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/FootstepsRowBtn
@onready var footsteps_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsMinusBtn
@onready var footsteps_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsPlusBtn
@onready var footsteps_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsValueLabel
@onready var footsteps_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsProgressBar

@onready var jumpscare_row_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/JumpscareRowBtn
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
var _jumpscare_volume_percent: int = 90

var _vr_navigator: VRUINavigator = null

func _ready() -> void:
	# Inicjalizacja komponentu nawigacji joystickiem VR
	_vr_navigator = VRUINavigator.new()
	_vr_navigator.name = "VRUINavigator"
	_vr_navigator.root_control = self
	_vr_navigator.horizontal_navigated.connect(_on_navigator_horizontal)
	add_child(_vr_navigator)

	if LevelManager:
		if not LevelManager.night_selected.is_connected(_on_night_changed):
			LevelManager.night_selected.connect(_on_night_changed)
		if not LevelManager.night_unlocked.is_connected(_on_night_changed):
			LevelManager.night_unlocked.connect(_on_night_changed)

	_load_saved_settings()
	_update_telemetry()
	_update_nights_ui()
	_update_settings_ui()
	_setup_accessibility()
	_show_panel("main")

func _on_night_changed(_idx: int) -> void:
	_update_nights_ui()

func _load_saved_settings() -> void:
	if LevelManager:
		var s: Dictionary = LevelManager.load_settings()
		_master_volume_percent = int(s.get("master_volume", 80))
		_enemies_volume_percent = int(s.get("enemies_volume", 85))
		_footsteps_volume_percent = int(s.get("footsteps_volume", 80))
		_jumpscare_volume_percent = int(s.get("jumpscare_volume", 90))
		if TTSManager:
			TTSManager.tts_enabled = bool(s.get("tts_enabled", true))
		_apply_all_audio_buses()

func _save_current_settings() -> void:
	if LevelManager:
		var s: Dictionary = {
			"master_volume": _master_volume_percent,
			"enemies_volume": _enemies_volume_percent,
			"footsteps_volume": _footsteps_volume_percent,
			"jumpscare_volume": _jumpscare_volume_percent,
			"tts_enabled": TTSManager.tts_enabled if TTSManager else true
		}
		LevelManager.save_settings(s)

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
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)

func _apply_bus_volume(bus_name: String, percent: int) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx >= 0:
		if percent <= 0:
			AudioServer.set_bus_mute(bus_idx, true)
		else:
			AudioServer.set_bus_mute(bus_idx, false)
			var linear = percent / 100.0
			var db = linear_to_db(linear)
			AudioServer.set_bus_volume_db(bus_idx, db)

func _update_settings_ui() -> void:
	if master_value_label: master_value_label.text = "%d%%" % _master_volume_percent
	if master_progress_bar: master_progress_bar.value = _master_volume_percent

	if enemies_value_label: enemies_value_label.text = "%d%%" % _enemies_volume_percent
	if enemies_progress_bar: enemies_progress_bar.value = _enemies_volume_percent

	if footsteps_value_label: footsteps_value_label.text = "%d%%" % _footsteps_volume_percent
	if footsteps_progress_bar: footsteps_progress_bar.value = _footsteps_volume_percent

	if jumpscare_value_label: jumpscare_value_label.text = "%d%%" % _jumpscare_volume_percent
	if jumpscare_progress_bar: jumpscare_progress_bar.value = _jumpscare_volume_percent

	if tts_toggle_btn:
		var is_on = TTSManager.tts_enabled if TTSManager else true
		tts_toggle_btn.text = "TTS Voice: " + ("ON" if is_on else "OFF")

func _update_nights_ui() -> void:
	var sel_night: int = LevelManager.selected_night if LevelManager else 1
	var unl_night: int = LevelManager.unlocked_night if LevelManager else 1

	# Aktualizacja napisu na głównym przycisku Start
	if start_button:
		if sel_night == 0:
			start_button.text = "START TUTORIAL (NIGHT 0)"
		elif sel_night == 6:
			start_button.text = "START ENDLESS NIGHT"
		else:
			start_button.text = "START NIGHT %d" % sel_night

	# Konfiguracja przycisków nocy
	var btns: Array[Button] = [night_0_btn, night_1_btn, night_2_btn, night_3_btn, night_4_btn, night_5_btn, night_6_btn]

	for i in range(btns.size()):
		var btn: Button = btns[i]
		if btn == null:
			continue
		var is_unlocked: bool = (i <= unl_night)
		btn.disabled = not is_unlocked
		
		var title: String = LevelManager.get_night_title(i) if LevelManager else ("Night %d" % i)
		if not is_unlocked:
			btn.text = "🔒 %s (LOCKED)" % title
			btn.modulate = Color(0.6, 0.6, 0.6, 0.5)
		else:
			var prefix: String = "▶ " if (i == sel_night) else ""
			btn.text = prefix + title
			if i == sel_night:
				btn.modulate = Color(0, 1, 0.64, 1.0)
			else:
				btn.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _setup_accessibility() -> void:
	if Engine.is_editor_hint() or TTSManager == null:
		return
		
	TTSManager.setup_button(start_button, func():
		var sel_night: int = LevelManager.selected_night if LevelManager else 1
		if sel_night == 0:
			return "Start Tutorial"
		elif sel_night == 6:
			return "Start Endless Night"
		return "Start Night %d" % sel_night
	)
	TTSManager.setup_button(select_night_button, func():
		var sel_night: int = LevelManager.selected_night if LevelManager else 1
		var title = LevelManager.get_night_title(sel_night) if LevelManager else ("Night %d" % sel_night)
		return "Select Night. Currently %s is selected" % title
	)
	TTSManager.setup_button(settings_button, "Settings")
	TTSManager.setup_button(guide_button, "Controls and Survival Guide")
	TTSManager.setup_button(exit_button, "Exit Game")
	
	# Przyciski nocy
	var btns: Array[Button] = [night_0_btn, night_1_btn, night_2_btn, night_3_btn, night_4_btn, night_5_btn, night_6_btn]
	for i in range(btns.size()):
		var idx = i
		var btn = btns[idx]
		if btn:
			TTSManager.setup_button(btn, func():
				var unl = LevelManager.unlocked_night if LevelManager else 1
				if idx > unl:
					return "Night %d is locked. Complete previous night to unlock." % idx
				var is_selected = (idx == LevelManager.selected_night) if LevelManager else false
				var sel_str = " Currently selected. " if is_selected else " "
				var night_data = LevelManager.get_night_data(idx) if LevelManager else null
				var desc = night_data.description if (night_data and not night_data.description.is_empty()) else ("Night %d" % idx)
				return desc + sel_str
			)

	TTSManager.setup_button(back_from_nights_btn, "Back to Main Menu")

	# Settings controls with dynamic speech
	TTSManager.setup_button(tts_toggle_btn, func(): return "TTS Voice: " + ("enabled" if (TTSManager and TTSManager.tts_enabled) else "disabled") + ". Press A or tilt stick left or right to toggle.")

	TTSManager.setup_button(master_row_btn, func(): return "Master volume: %d percent. Tilt stick left or right to adjust." % _master_volume_percent)
	TTSManager.setup_button(master_minus_btn, func(): return "Decrease master volume. Currently %d percent" % _master_volume_percent)
	TTSManager.setup_button(master_plus_btn, func(): return "Increase master volume. Currently %d percent" % _master_volume_percent)
	
	TTSManager.setup_button(enemies_row_btn, func(): return "Enemy sounds volume: %d percent. Tilt stick left or right to adjust." % _enemies_volume_percent)
	TTSManager.setup_button(enemies_minus_btn, func(): return "Decrease enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	TTSManager.setup_button(enemies_plus_btn, func(): return "Increase enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	
	TTSManager.setup_button(footsteps_row_btn, func(): return "Footsteps volume: %d percent. Tilt stick left or right to adjust." % _footsteps_volume_percent)
	TTSManager.setup_button(footsteps_minus_btn, func(): return "Decrease footstep volume. Currently %d percent" % _footsteps_volume_percent)
	TTSManager.setup_button(footsteps_plus_btn, func(): return "Increase footstep volume. Currently %d percent" % _footsteps_volume_percent)

	TTSManager.setup_button(jumpscare_row_btn, func(): return "Jumpscare volume: %d percent. Tilt stick left or right to adjust." % _jumpscare_volume_percent)
	TTSManager.setup_button(jumpscare_minus_btn, func(): return "Decrease jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)
	TTSManager.setup_button(jumpscare_plus_btn, func(): return "Increase jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)

	TTSManager.setup_button(back_from_settings_btn, "Back to Main Menu")
	TTSManager.setup_button(back_from_guide_btn, "Back to Main Menu")


func _show_panel(panel_name: String) -> void:
	print("[MainMenuUI] Switching to panel: ", panel_name)
	if main_panel:
		main_panel.visible = (panel_name == "main")
	if nights_panel:
		nights_panel.visible = (panel_name == "nights")
	if settings_panel:
		settings_panel.visible = (panel_name == "settings")
	if guide_panel:
		guide_panel.visible = (panel_name == "guide")

	# Odświeżamy listę przycisków nawigatora dla aktywnego widoku
	if _vr_navigator:
		# Opóźniamy o jedną ramkę, aby silnik zaktualizował widoczność w drzewie sceny
		call_deferred("_refresh_navigator")

func _refresh_navigator() -> void:
	if _vr_navigator:
		_vr_navigator.refresh_buttons()

func _on_start_button_pressed() -> void:
	print("[MainMenuUI] Start button pressed! Emitting start_pressed...")
	start_pressed.emit()
	if start_pressed.get_connections().is_empty():
		SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_select_night_button_pressed() -> void:
	_update_nights_ui()
	_show_panel("nights")
	if TTSManager:
		var unl = LevelManager.unlocked_night if LevelManager else 1
		TTSManager.announce_panel("Night selection screen. Select a night from 0 to %d." % unl)

func _on_settings_button_pressed() -> void:
	_show_panel("settings")
	if TTSManager:
		TTSManager.announce_panel("Audio settings screen. Adjust master, enemies, footsteps, and jumpscares.")

func _on_guide_button_pressed() -> void:
	_show_panel("guide")
	if TTSManager:
		TTSManager.announce_panel("Controls and survival guide. Navigate menu with stick up down. Move with right stick and turn with physical body.")

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
	if exit_pressed.get_connections().is_empty():
		get_tree().quit()

func _on_back_pressed() -> void:
	_update_nights_ui()
	_show_panel("main")
	if TTSManager:
		TTSManager.announce_panel("Main Menu")

# Wybór konkretnej nocy
func _select_night_idx(night_idx: int) -> void:
	if LevelManager:
		if LevelManager.select_night(night_idx):
			_update_nights_ui()
			var title = LevelManager.get_night_title(night_idx)
			if TTSManager:
				TTSManager.speak("Starting %s" % title, true)
			print("[MainMenuUI] Night %d selected. Loading game map immediately..." % night_idx)
			SceneLoader.load_scene("res://scenes/game_map.tscn")
		else:
			if TTSManager:
				TTSManager.speak("Night %d is locked. Complete previous night to unlock." % night_idx, true)

func _on_night_0_btn_pressed() -> void: _select_night_idx(0)
func _on_night_1_btn_pressed() -> void: _select_night_idx(1)
func _on_night_2_btn_pressed() -> void: _select_night_idx(2)
func _on_night_3_btn_pressed() -> void: _select_night_idx(3)
func _on_night_4_btn_pressed() -> void: _select_night_idx(4)
func _on_night_5_btn_pressed() -> void: _select_night_idx(5)
func _on_night_6_btn_pressed() -> void: _select_night_idx(6)

# Nawigacja pozioma joystickiem (regulacja suwaków lewo/prawo w ustawieniach)
func _on_navigator_horizontal(dir: int) -> void:
	if settings_panel == null or not settings_panel.visible:
		return
	if master_row_btn and master_row_btn.has_focus():
		if dir < 0: _on_master_minus_pressed()
		else: _on_master_plus_pressed()
	elif enemies_row_btn and enemies_row_btn.has_focus():
		if dir < 0: _on_enemies_minus_pressed()
		else: _on_enemies_plus_pressed()
	elif footsteps_row_btn and footsteps_row_btn.has_focus():
		if dir < 0: _on_footsteps_minus_pressed()
		else: _on_footsteps_plus_pressed()
	elif jumpscare_row_btn and jumpscare_row_btn.has_focus():
		if dir < 0: _on_jumpscare_minus_pressed()
		else: _on_jumpscare_plus_pressed()
	elif tts_toggle_btn and tts_toggle_btn.has_focus():
		_on_tts_toggle_pressed()

# Kliknięcie / zatwierdzenie wierszy ustawień
func _on_master_row_pressed() -> void:
	if TTSManager: TTSManager.speak("Master volume is %d percent. Tilt stick left to decrease, right to increase." % _master_volume_percent, true)

func _on_enemies_row_pressed() -> void:
	if TTSManager: TTSManager.speak("Enemy sounds volume is %d percent. Tilt stick left to decrease, right to increase." % _enemies_volume_percent, true)

func _on_footsteps_row_pressed() -> void:
	if TTSManager: TTSManager.speak("Footsteps volume is %d percent. Tilt stick left to decrease, right to increase." % _footsteps_volume_percent, true)

func _on_jumpscare_row_pressed() -> void:
	if TTSManager: TTSManager.speak("Jumpscare volume is %d percent. Tilt stick left to decrease, right to increase." % _jumpscare_volume_percent, true)


# Master volume
func _on_master_minus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent - 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

func _on_master_plus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent + 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

# Enemies volume
func _on_enemies_minus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent - 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

func _on_enemies_plus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent + 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

# Footsteps volume
func _on_footsteps_minus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent - 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

func _on_footsteps_plus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent + 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

# Jumpscare volume
func _on_jumpscare_minus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent - 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

func _on_jumpscare_plus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent + 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

# Toggle TTS
func _on_tts_toggle_pressed() -> void:
	if TTSManager:
		TTSManager.tts_enabled = not TTSManager.tts_enabled
		_save_current_settings()
		_update_settings_ui()
		if TTSManager.tts_enabled:
			TTSManager.speak("TTS voice enabled", true)
