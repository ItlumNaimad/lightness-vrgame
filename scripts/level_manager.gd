extends Node

## LevelManager — Autoload zarządzający poziomami (nocami w stylu FNaF),
## progresją gry oraz trwałym zapisem/odczytem ustawień do plików JSON.

signal night_selected(night_index: int)
signal night_unlocked(night_index: int)

const SAVE_PATH := "user://save_data.json"
const SETTINGS_PATH := "user://settings.json"

var selected_night: int = 1
var unlocked_night: int = 1 # Noc 0 i 1 są zawsze dostępne na start

var nights: Dictionary = {
	0: {
		"title": "Night 0: Test Room",
		"desc": "Safe exploration training. No enemies. Practice walking, wall collisions and sound direction.",
		"duration": 60.0,
		"has_balora": false,
		"balora_speed": 0.0,
		"balora_boost_time": 0.0,
		"has_marionette": false,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	1: {
		"title": "Night 1: First Contact",
		"desc": "Survive 30 seconds. Slow Balora patrols the maze, speeding up in the final seconds.",
		"duration": 30.0,
		"has_balora": true,
		"balora_speed": 1.2,
		"balora_boost_time": 6.0, # Przyspieszenie w ostatnich 6 sekundach
		"has_marionette": false,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	2: {
		"title": "Night 2: Whispering Shadows",
		"desc": "Survive 60 seconds. Balora accelerates every 10s. Marionette whispers from the dark.",
		"duration": 60.0,
		"has_balora": true,
		"balora_speed": 1.5,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	3: {
		"title": "Night 3: Silence and Charge",
		"desc": "Survive 90 seconds. Foxy joins the hunt, reacting to accumulated movement noise.",
		"duration": 90.0,
		"has_balora": true,
		"balora_speed": 1.6,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 1,
		"foxy_threshold": 24.0, # Bardzo cierpliwy na hałas
		"has_phantom_grasp": false
	},
	4: {
		"title": "Night 4: The Deep Dark",
		"desc": "Survive 120 seconds. Aggressive Foxy, frequent Marionette whispers, and Phantom Grasp tentacles.",
		"duration": 120.0,
		"has_balora": true,
		"balora_speed": 1.8,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 1,
		"foxy_threshold": 14.0, # Aktywny łowca
		"has_phantom_grasp": true
	},
	5: {
		"title": "Night 5: Nightmare Finale",
		"desc": "Survive 150 seconds. Full speed Balora, TWO independent Foxies, Marionette and Phantom Grasp.",
		"duration": 150.0,
		"has_balora": true,
		"balora_speed": 2.2,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 2, # Dwóch łowców!
		"foxy_threshold": 12.0,
		"has_phantom_grasp": true
	}
}

func _ready() -> void:
	load_game()
	load_and_apply_settings()

func get_current_night_config() -> Dictionary:
	if nights.has(selected_night):
		return nights[selected_night]
	return nights[1]

func select_night(night_idx: int) -> bool:
	if night_idx < 0 or night_idx > 5:
		return false
	if night_idx > unlocked_night and night_idx != 0:
		return false # Zablokowana noc
	selected_night = night_idx
	night_selected.emit(selected_night)
	save_game()
	return true

func unlock_next_night() -> void:
	var next_night = selected_night + 1
	if next_night <= 5 and next_night > unlocked_night:
		unlocked_night = next_night
		night_unlocked.emit(unlocked_night)
		save_game()
		print("[LevelManager] Odblokowano Noc: ", unlocked_night)

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
			unlocked_night = clamp(int(parsed.get("unlocked_night", 1)), 1, 5)
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
