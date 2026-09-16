@tool
extends XRToolsSceneBase

var time_survived: float = 0.0
var is_timer_running: bool = false
var next_milestone: int = 10
var target_night_duration: float = 60.0
var current_night: int = 1
var is_night_survived: bool = false

@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D
@onready var ambient_audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var balora: Node3D = get_node_or_null("Balora")
@onready var marionette: Node3D = get_node_or_null("Marionette")
@onready var foxy: Node3D = get_node_or_null("Foxy")
@onready var foxy2: Node3D = get_node_or_null("Foxy2")
@onready var phantom_grasp: Node3D = get_node_or_null("PhantomGrasp")

var _balora_boosted: bool = false
var _balora_boost_time: float = 0.0
var _player_head: Node3D
var _cached_enemies: Array[Node] = []
var _enemy_refresh_timer: float = 0.0

func _ready():
	if Engine.is_editor_hint():
		return
		
	if timer_label == null:
		push_warning("TimerLabel niedostępny — HUD wyłączony (gra działa dalej).")
	if milestone_audio == null:
		push_warning("MilestoneAudio niedostępny.")
	
	# Automatyczny bake NavMesh przy starcie mapy
	if nav_region and nav_region.navigation_mesh:
		call_deferred("_deferred_bake_navmesh")
	
	SceneLoader.reset_session_stats()
	time_survived = 0.0
	next_milestone = 10
	is_night_survived = false
	is_timer_running = true
	
	_setup_night_from_level_manager()
	_refresh_nodes()

func _setup_night_from_level_manager():
	var cfg = LevelManager.get_current_night_config()
	current_night = LevelManager.selected_night
	target_night_duration = cfg.get("duration", 60.0)
	_balora_boost_time = cfg.get("balora_boost_time", 0.0)
	
	var night_title = cfg.get("title", "Night 1")
	var has_balora = cfg.get("has_balora", false)
	var has_marionette = cfg.get("has_marionette", false)
	var foxy_count = cfg.get("foxy_count", 0)
	var foxy_threshold = cfg.get("foxy_threshold", 24.0)
	var has_phantom_grasp = cfg.get("has_phantom_grasp", false)
	
	print("[GameMap] Konfiguracja Nocy %d: %s | Czas: %.0fs" % [current_night, night_title, target_night_duration])
	
	# 1. Balora
	if balora:
		if has_balora:
			balora.process_mode = Node.PROCESS_MODE_INHERIT
			var b_speed = cfg.get("balora_speed", 1.2)
			if "patrol_speed" in balora:
				balora.patrol_speed = b_speed
			if balora.has_node("BaloraTheme"):
				(balora.get_node("BaloraTheme") as AudioStreamPlayer3D).play()
		else:
			balora.queue_free()
			
	# 2. Marionette
	if marionette:
		if has_marionette:
			marionette.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			marionette.queue_free()
			
	# 3. Foxy 1
	if foxy:
		if foxy_count >= 1:
			foxy.process_mode = Node.PROCESS_MODE_INHERIT
			if "noise_threshold" in foxy:
				foxy.noise_threshold = foxy_threshold
		else:
			foxy.queue_free()
			
	# 4. Foxy 2 (Finał Noc 5)
	if foxy2:
		if foxy_count >= 2:
			foxy2.process_mode = Node.PROCESS_MODE_INHERIT
			if "noise_threshold" in foxy2:
				foxy2.noise_threshold = foxy_threshold
		else:
			foxy2.queue_free()
			
	# 5. Phantom Grasp
	if phantom_grasp:
		if has_phantom_grasp:
			phantom_grasp.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			phantom_grasp.queue_free()
			
	# Komunikat startowy lektora TTS
	if TTSManager:
		if current_night == 0:
			TTSManager.speak("Night zero: Test Room. Safe exploration. Practice walking and sound localization.", true)
		else:
			TTSManager.speak("%s. Survive %d seconds." % [night_title, int(target_night_duration)], true)

func _refresh_nodes():
	_cached_enemies = get_tree().get_nodes_in_group("enemy")
	var head = get_tree().get_first_node_in_group("player_head")
	if head:
		_player_head = head
	else:
		var player_root = get_tree().get_first_node_in_group("player")
		if player_root:
			_player_head = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
			if _player_head == null:
				_player_head = player_root

func _deferred_bake_navmesh():
	if nav_region and nav_region.navigation_mesh:
		nav_region.bake_navigation_mesh()

func _process(delta: float):
	if Engine.is_editor_hint():
		return
		
	if not is_timer_running or is_night_survived:
		return
	
	time_survived += delta
	
	# Formatowanie zegara HUD
	var total_seconds: int = int(time_survived)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	if timer_label:
		timer_label.text = "%02d:%02d" % [minutes, seconds]

	# Balora boost pod koniec nocy (Noc 1)
	if _balora_boost_time > 0.0 and not _balora_boosted:
		if (target_night_duration - time_survived) <= _balora_boost_time:
			_balora_boosted = true
			if is_instance_valid(balora) and "patrol_speed" in balora:
				balora.patrol_speed = 2.4
				if balora.has_node("BaloraTheme"):
					var th = balora.get_node("BaloraTheme") as AudioStreamPlayer3D
					th.pitch_scale = 1.35
				print("[GameMap] Balora przyspiesza na koniec nocy!")

	# Warunek przetrwania nocy (6:00 AM)
	if target_night_duration > 0.0 and time_survived >= target_night_duration:
		_on_night_survived()
		return

	# Sygnały gongu co 10 sekund
	if time_survived >= next_milestone:
		_trigger_milestone_event()

	# Efekt Distortion
	_enemy_refresh_timer -= delta
	if _enemy_refresh_timer <= 0.0:
		_enemy_refresh_timer = 1.0
		_cached_enemies = get_tree().get_nodes_in_group("enemy")
		
	_update_distortion_effect(delta)

func _on_night_survived():
	is_night_survived = true
	is_timer_running = false
	print("[GameMap] 6:00 AM! Noc %d przetrwana!" % current_night)
	
	# Zatrzymanie wszystkich wrogów
	for e in get_tree().get_nodes_in_group("enemy"):
		if is_instance_valid(e):
			e.process_mode = Node.PROCESS_MODE_DISABLED
			
	# Sygnał 6:00 AM
	if milestone_audio:
		milestone_audio.pitch_scale = 1.2
		milestone_audio.play()
		
	SceneLoader.last_survival_time = time_survived
	LevelManager.unlock_next_night()
	
	if TTSManager:
		TTSManager.speak("Six A M! Night %d survived! Returning to menu." % current_night, true)
		
	# Odczekanie 3.5s i płynny powrót do Menu Głównego
	await get_tree().create_timer(3.5).timeout
	SceneLoader.load_scene("res://scenes/main_menu.tscn")

func _update_distortion_effect(delta: float):
	if ambient_audio == null:
		return
		
	if _player_head == null:
		_refresh_nodes()
		if _player_head == null:
			return
			
	var p_pos = _player_head.global_position
	var closest_dist = 999.0
	for e in _cached_enemies:
		if is_instance_valid(e) and e is Node3D:
			var d = (e as Node3D).global_position.distance_to(p_pos)
			if d < closest_dist:
				closest_dist = d
				
	var target_pitch = 1.0
	if closest_dist < 10.0:
		target_pitch = remap(closest_dist, 2.0, 10.0, 0.4, 1.0)
		target_pitch = clamp(target_pitch, 0.4, 1.0)
		
	ambient_audio.pitch_scale = lerp(ambient_audio.pitch_scale, target_pitch, delta * 3.0)

func _trigger_milestone_event():
	var current_reached_milestone = next_milestone
	next_milestone += 10
	
	if milestone_audio and not milestone_audio.playing:
		milestone_audio.pitch_scale = 1.0
		milestone_audio.play()
		
	if EventBus:
		EventBus.milestone_reached.emit(current_reached_milestone)

func stop_timer_and_save():
	is_timer_running = false
	SceneLoader.last_survival_time = time_survived
