extends XRToolsSceneBase

var time_survived: float = 0.0
var is_timer_running: bool = false
var next_milestone: int = 10

@export var balora_start_time: float = 15.0
@export var marionette_start_time: float = 40.0
@export var foxy_start_time: float = 75.0
@export var phantom_grasp_start_time: float = 110.0

@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D
@onready var ambient_audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var balora: Node3D = get_node_or_null("Balora")
@onready var marionette: Node3D = get_node_or_null("Marionette")
@onready var foxy: Node3D = get_node_or_null("Foxy")
@onready var phantom_grasp: Node3D = get_node_or_null("PhantomGrasp")

var _balora_active: bool = false
var _marionette_active: bool = false
var _foxy_active: bool = false
var _phantom_grasp_active: bool = false

var _player_head: Node3D
var _cached_enemies: Array[Node] = []
var _enemy_refresh_timer: float = 0.0

func _ready():
	if timer_label == null:
		push_warning("TimerLabel niedostępny — HUD wyłączony (gra działa dalej).")
	if milestone_audio == null:
		push_warning("MilestoneAudio niedostępny.")
	
	# Automatyczny bake NavMesh przy starcie mapy, odroczony by nie blokować klatki
	if nav_region and nav_region.navigation_mesh:
		call_deferred("_deferred_bake_navmesh")
	
	# Reset stanu przy starcie mapy (każda scena jest samowystarczalna).
	SceneLoader.reset_session_stats()
	time_survived = 0.0
	next_milestone = 10
	is_timer_running = true
	_init_threat_director()
	_refresh_nodes()

func _init_threat_director():
	# Stopniowe wprowadzanie zagrożeń (pacing)
	if balora:
		balora.process_mode = Node.PROCESS_MODE_DISABLED
		if balora.has_node("BaloraTheme"):
			(balora.get_node("BaloraTheme") as AudioStreamPlayer3D).stop()
	if marionette:
		marionette.process_mode = Node.PROCESS_MODE_DISABLED
		if marionette.has_node("WhisperSound"):
			(marionette.get_node("WhisperSound") as AudioStreamPlayer3D).stop()
	if foxy:
		foxy.process_mode = Node.PROCESS_MODE_DISABLED
	if phantom_grasp:
		phantom_grasp.process_mode = Node.PROCESS_MODE_DISABLED

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
	nav_region.bake_navigation_mesh()
	
func _process(delta: float):
	if not is_timer_running:
		return
	
	# 1. Akumulacja czasu
	time_survived += delta
	
	# 2. Formatowanie matematyczne (minuty:sekundy)
	var total_seconds: int = int(time_survived)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	if timer_label:
		timer_label.text = "%02d:%02d" % [minutes, seconds]

	# 3. Pacing zagrożeń (Threat Director)
	_update_threat_pacing()

	# 4. Sprawdzanie progów 10 sekundowych
	if time_survived >= next_milestone:
		_trigger_milestone_event()

func _update_threat_pacing():
	if not _balora_active and time_survived >= balora_start_time:
		_balora_active = true
		if balora:
			balora.process_mode = Node.PROCESS_MODE_INHERIT
			if balora.has_node("BaloraTheme"):
				(balora.get_node("BaloraTheme") as AudioStreamPlayer3D).play()
			print("Threat Director: Balora aktywowana (", int(time_survived), "s)")
			
	if not _marionette_active and time_survived >= marionette_start_time:
		_marionette_active = true
		if marionette:
			marionette.process_mode = Node.PROCESS_MODE_INHERIT
			if marionette.has_method("_start_new_series"):
				marionette._start_new_series()
			print("Threat Director: Marionette aktywowana (", int(time_survived), "s)")
			
	if not _foxy_active and time_survived >= foxy_start_time:
		_foxy_active = true
		if foxy:
			foxy.process_mode = Node.PROCESS_MODE_INHERIT
			print("Threat Director: Foxy aktywowany (", int(time_survived), "s)")
			
	if not _phantom_grasp_active and time_survived >= phantom_grasp_start_time:
		_phantom_grasp_active = true
		if phantom_grasp:
			phantom_grasp.process_mode = Node.PROCESS_MODE_INHERIT
			print("Threat Director: Phantom Grasp aktywowany (", int(time_survived), "s)")
		
	# 4. Efekt Distortion (zbliżające się zagrożenie = obniżony, mroczny ton ambientu)
	_enemy_refresh_timer -= delta
	if _enemy_refresh_timer <= 0.0:
		_enemy_refresh_timer = 1.0
		_cached_enemies = get_tree().get_nodes_in_group("enemy")
		
	_update_distortion_effect(delta)

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
				
	# Mapowanie dystansu: < 2 metry -> silny pitch (0.4), > 10 metrów -> normalny (1.0)
	var target_pitch = 1.0
	if closest_dist < 10.0:
		target_pitch = remap(closest_dist, 2.0, 10.0, 0.4, 1.0)
		target_pitch = clamp(target_pitch, 0.4, 1.0)
		
	ambient_audio.pitch_scale = lerp(ambient_audio.pitch_scale, target_pitch, delta * 3.0)
		
func _trigger_milestone_event():
	# Przesuwamy próg o kolejne 10 sekund
	var current_reached_milestone = next_milestone
	next_milestone += 10
	
	# Odtworzenie sygnału dźwiękowego bezpośrednio przy uchu gracza
	if milestone_audio and not milestone_audio.playing:
		milestone_audio.play()
		
	# Eskalacja poziomu trudności dla wrogów podłączonych do EventBus
	if EventBus:
		EventBus.milestone_reached.emit(current_reached_milestone)
		
	print("Osiągnięto próg! Aktualny próg: ", current_reached_milestone, ", następny: ", next_milestone)
	
func stop_timer_and_save():
	is_timer_running = false
	# Zapisanie wyniku do pamięci
	SceneLoader.last_survival_time = time_survived
