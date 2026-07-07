@tool
extends XRToolsSceneBase

var time_survived: float = 0.0
var is_timer_running: bool = false
var next_milestone: int = 10

@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D
@onready var ambient_audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	if Engine.is_editor_hint():
		return

	if timer_label == null or milestone_audio == null:
		printerr("HUD nie został zainicjowany. Sprawdzić \"Editable Children\".")
		return
	
	# Automatyczny bake NavMesh przy starcie mapy, odroczony by nie blokować klatki
	if nav_region and nav_region.navigation_mesh:
		call_deferred("_deferred_bake_navmesh")
	
	# Reset stanu przy starcie mapy (każda scena jest samowystarczalna).
	time_survived = 0.0
	next_milestone = 10
	is_timer_running = true

func _deferred_bake_navmesh():
	nav_region.bake_navigation_mesh()
	
func _process(delta: float):
	if Engine.is_editor_hint() or not is_timer_running:
		return
	
	# 1. Akumulacja czasu
	time_survived += delta
	
	#2. Formatowanie matematyczne (minuty:sekundy)
	var total_seconds: int = int(time_survived)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	if timer_label:
		timer_label.text = "%02d:%02d" % [minutes, seconds]

	# 3. Sprawdzanie progów 10 sekundowych
	if time_survived >= next_milestone:
		_trigger_milestone_event()
		
	# 4. Efekt Distortion (zbliżające się zagrożenie = obniżony, mroczny ton ambientu)
	_update_distortion_effect(delta)

func _update_distortion_effect(delta: float):
	if ambient_audio == null:
		return
		
	var closest_dist = 999.0
	var enemies = get_tree().get_nodes_in_group("enemy")
	var player_root = get_tree().get_first_node_in_group("player")
	
	if player_root:
		var p_pos = player_root.global_position
		for e in enemies:
			if e is Node3D:
				var d = e.global_position.distance_to(p_pos)
				if d < closest_dist:
					closest_dist = d
					
		# Mapowanie dystansu: < 2 metry -> silny pitch (0.5), > 10 metrów -> normalny (1.0)
		var target_pitch = 1.0
		if closest_dist < 10.0:
			target_pitch = remap(closest_dist, 2.0, 10.0, 0.4, 1.0)
			target_pitch = clamp(target_pitch, 0.4, 1.0)
			
		ambient_audio.pitch_scale = lerp(ambient_audio.pitch_scale, target_pitch, delta * 3.0)
		
func _trigger_milestone_event():
	# Przesuwamy próg o kolejne 10 sekund
	next_milestone += 10
	# Odtworzenie sygnału dźwiękowego bezpośrednio przy uchu gracza
	if milestone_audio and not milestone_audio.playing:
		milestone_audio.play()
		
	# W tym miejscu w przyszłości możesz dodać wywołanie zmian w logice AI
	print("Osiągnięto próg! Aktualny próg uciekł na: ", next_milestone)
	
func stop_timer_and_save():
	is_timer_running = false
	# Zapisanie wyniku do pamięci
	SceneLoader.last_survival_time = time_survived
