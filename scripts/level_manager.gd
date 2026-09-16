extends Node

## LevelManager — Autoload zarządzający poziomami (nocami w stylu FNaF),
## progresją gry oraz trwałym zapisem/odczytem ustawień do plików JSON.

signal night_selected(night_index: int)
signal night_unlocked(night_index: int)

const SAVE_PATH := "user://save_data.json"
const SETTINGS_PATH := "user://settings.json"

var selected_night: int = 1
var unlocked_night: int = 1 # Noc 0 i 1 są zawsze dostępne na start

const MAX_NIGHT := 6

const NIGHT_RESOURCE_PATHS := {
	0: "res://resources/nights/night_0.tres",
	1: "res://resources/nights/night_1.tres",
	2: "res://resources/nights/night_2.tres",
	3: "res://resources/nights/night_3.tres",
	4: "res://resources/nights/night_4.tres",
	5: "res://resources/nights/night_5.tres",
	6: "res://resources/nights/night_6_endless.tres"
}

var night_data_cache: Dictionary = {}

func _ready() -> void:
	_load_night_resources()
	load_game()
	load_and_apply_settings()

func _load_night_resources() -> void:
	for idx in NIGHT_RESOURCE_PATHS.keys():
		var path = NIGHT_RESOURCE_PATHS[idx]
		if ResourceLoader.exists(path):
			var res = load(path)
			if res is NightData:
				night_data_cache[idx] = res
			else:
				push_warning("[LevelManager] Resource at %s is not NightData" % path)
		else:
			push_warning("[LevelManager] Missing NightData resource: %s" % path)

func get_current_night_data() -> NightData:
	if night_data_cache.has(selected_night):
		return night_data_cache[selected_night]
	if night_data_cache.has(1):
		return night_data_cache[1]
	return null

func get_night_data(idx: int) -> NightData:
	return night_data_cache.get(idx, null)

func get_night_title(idx: int) -> String:
	var data = get_night_data(idx)
	if data:
		return data.title
	return "Night %d" % idx

## Zgodność wsteczna ze słownikiem konfiguracji
func get_current_night_config() -> Dictionary:
	var data = get_current_night_data()
	if not data:
		return {
			"title": "Night 1",
			"desc": "Survive.",
			"duration": 30.0,
			"has_balora": true,
			"balora_speed": 1.2,
			"balora_boost_time": 0.0,
			"has_marionette": false,
			"has_foxy": false,
			"foxy_count": 0,
			"foxy_threshold": 999.0,
			"has_phantom_grasp": false
		}
	return {
		"title": data.title,
		"desc": data.description,
		"duration": data.duration,
		"is_endless": data.is_endless,
		"has_balora": data.has_balora,
		"balora_speed": data.balora_base_speed,
		"balora_boost_time": 0.0,
		"has_marionette": data.has_marionette,
		"has_foxy": data.has_foxy,
		"foxy_count": data.foxy_count,
		"foxy_threshold": data.foxy_initial_threshold,
		"has_phantom_grasp": data.has_phantom_grasp
	}

func select_night(night_idx: int) -> bool:
	if night_idx < 0 or night_idx > MAX_NIGHT:
		return false
	if night_idx > unlocked_night and night_idx != 0:
		return false # Zablokowana noc
	selected_night = night_idx
	night_selected.emit(selected_night)
	save_game()
	return true

## Po ukończeniu nocy odblokowujemy kolejną i automatycznie ustawiamy ją jako wybraną
func unlock_next_night(completed_night: int = -1) -> void:
	var target = selected_night if completed_night < 0 else completed_night
	var next_night = target + 1
	if next_night <= MAX_NIGHT:
		if next_night > unlocked_night:
			unlocked_night = next_night
			night_unlocked.emit(unlocked_night)
		# Automatyczna podmiana na nowo odblokowaną noc
		selected_night = unlocked_night
		night_selected.emit(selected_night)
		save_game()
		print("[LevelManager] Odblokowano i automatycznie wybrano Noc: ", selected_night)

func save_game() -> void:
	var data := {
		"unlocked_night": unlocked_night,
		"selected_night": selected_night,
		"last_saved": Time.get_datetime_string_from_system()
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(json_text)
		if parsed is Dictionary:
			unlocked_night = clamp(int(parsed.get("unlocked_night", 1)), 1, MAX_NIGHT)
			selected_night = clamp(int(parsed.get("selected_night", 1)), 0, unlocked_night)

# --- TRWAŁY ZAPIS I ODCZYT USTAWIEŃ ---

func save_settings(settings_dict: Dictionary) -> void:
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings_dict, "\t"))
		file.close()
		print("[LevelManager] Ustawienia zapisane do: ", SETTINGS_PATH)

func load_settings() -> Dictionary:
	var defaults := {
		"master_volume": 80,
		"enemies_volume": 85,
		"footsteps_volume": 80,
		"jumpscare_volume": 90,
		"tts_enabled": true
	}
	if not FileAccess.file_exists(SETTINGS_PATH):
		return defaults
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(json_text)
		if parsed is Dictionary:
			for k in defaults.keys():
				if not parsed.has(k):
					parsed[k] = defaults[k]
			return parsed
	return defaults

func load_and_apply_settings() -> void:
	var s = load_settings()
	_apply_bus_volume("Master", int(s.get("master_volume", 80)))
	_apply_bus_volume("Enemies", int(s.get("enemies_volume", 85)))
	_apply_bus_volume("Footsteps", int(s.get("footsteps_volume", 80)))
	_apply_bus_volume("Jumpscare", int(s.get("jumpscare_volume", 90)))
	if TTSManager:
		TTSManager.tts_enabled = bool(s.get("tts_enabled", true))

func _apply_bus_volume(bus_name: String, volume_percent: int) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx >= 0:
		if volume_percent <= 0:
			AudioServer.set_bus_mute(bus_idx, true)
		else:
			AudioServer.set_bus_mute(bus_idx, false)
			var db = linear_to_db(float(volume_percent) / 100.0)
			AudioServer.set_bus_volume_db(bus_idx, db)
