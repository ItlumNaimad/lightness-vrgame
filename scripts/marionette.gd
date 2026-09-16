extends Node3D

enum State { HIDDEN, WHISPERING, JUMPSCARE }
var current_state: State = State.HIDDEN

## Włącz widoczny mesh debugowy (kula), żeby widzieć gdzie Marionette się pojawia
@export var debug_visible: bool = false

## Granice spawnu Marionette (do konfiguracji w edytorze)
@export var map_bounds_min: Vector3 = Vector3(-9.0, 0.0, -9.0)
@export var map_bounds_max: Vector3 = Vector3(9.0, 3.0, 9.0)

## Dystans spawnu od gracza
@export var spawn_distance_min: float = 1.8
@export var spawn_distance_max: float = 2.4

## Prędkość zamachu kontrolera (m/s) wymagana do odpędzenia szeptu
@export var swing_speed_threshold: float = 1.1

## Dystans uderzenia dłonią w szept
@export var swing_proximity_distance: float = 0.65

## Maksymalny czas na reakcję przed Jumpscare'em (sekundy)
@export var attack_duration_limit: float = 5.5

## Czas łaski na zorientowanie się po pojawieniu szeptów (sekundy)
@export var grace_time: float = 1.0

## Minimalna / maksymalna liczba szeptów w jednej serii
@export var min_whisper_rounds: int = 1
@export var max_whisper_rounds: int = 3

## Przerwa między szeptami w serii (sekundy)
@export var series_pause_min: float = 1.0
@export var series_pause_max: float = 2.5

## Przerwa między seriami (sekundy)
@export var long_pause_min: float = 8.0
@export var long_pause_max: float = 18.0

@onready var whisper_sound: AudioStreamPlayer3D = $WhisperSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var player: Node3D
var camera: XRCamera3D
var left_hand: XRController3D
var right_hand: XRController3D

var _last_left_pos: Vector3 = Vector3.ZERO
var _last_right_pos: Vector3 = Vector3.ZERO
var _haptic_warning_timer: float = 0.0

var state_timer: float = 0.0
var grace_timer: float = 0.0
var attack_timer: float = 0.0

var initial_player_pos: Vector3 = Vector3.ZERO
var current_offset: Vector3 = Vector3.ZERO

## Ile rund szeptów zostało w bieżącej serii
var _rounds_remaining: int = 0

# Debug mesh (kula do wizualizacji pozycji)
var _debug_mesh: MeshInstance3D

func _ready():
	# Tworzenie kuli debugowej
	_debug_mesh = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 0.6
	_debug_mesh.mesh = sphere
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(1.0, 0.0, 0.5, 0.7)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.0, 0.5)
	mat.emission_energy_multiplier = 2.0
	_debug_mesh.material_override = mat
	_debug_mesh.visible = false
	add_child(_debug_mesh)

	_find_player()
	_start_new_series()

	if EventBus:
		EventBus.milestone_reached.connect(_on_milestone_reached)

func _find_player():
	var player_head = get_tree().get_first_node_in_group("player_head")
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		player = player_root
		camera = player_head if player_head is XRCamera3D else player_root.get_node_or_null("XROrigin3D/XRCamera3D")
		var origin = player_root.get_node_or_null("XROrigin3D")
		if origin:
			left_hand = origin.get_node_or_null("left_hand")
			right_hand = origin.get_node_or_null("right_hand")
			if left_hand:
				_last_left_pos = left_hand.global_position
			if right_hand:
				_last_right_pos = right_hand.global_position

func _on_milestone_reached(milestone: int):
	# Eskalacja trudności Marionetki wraz z czasem przetrwania
	attack_duration_limit = max(3.0, 5.5 - float(milestone) / 60.0 * 1.5)
	if milestone >= 30:
		min_whisper_rounds = 2
		max_whisper_rounds = 4
	if milestone >= 60:
		min_whisper_rounds = 3
		max_whisper_rounds = 5
	print("Marionette eskalacja! Czas reakcji: ", attack_duration_limit, "s, serie: ", min_whisper_rounds, "-", max_whisper_rounds)

func _process(delta: float):
	if camera == null:
		_find_player()
		if camera == null:
			return

	match current_state:
		State.HIDDEN:
			state_timer -= delta
			if state_timer <= 0.0:
				_enter_whispering()
		
		State.WHISPERING:
			attack_timer += delta

			if attack_timer > attack_duration_limit:
				_trigger_jumpscare("Czas na reakcję (%.1fs) minął!" % attack_duration_limit)
				return
				
			# Przyczepienie do gracza: ciągłe podążanie za głową gracza z wylosowanym kątem
			# Efekt crescendo: dystans z czasem maleje o max 50% potęgując wrażenie zbliżania szeptu do ucha
			var crescendo_mult = 1.0 - (attack_timer / attack_duration_limit) * 0.5
			var target_pos = camera.global_position + (current_offset * crescendo_mult)
			target_pos.x = clamp(target_pos.x, map_bounds_min.x, map_bounds_max.x)
			target_pos.y = clamp(target_pos.y, map_bounds_min.y, map_bounds_max.y)
			target_pos.z = clamp(target_pos.z, map_bounds_min.z, map_bounds_max.z)
			global_position = target_pos
			
			# Haptyka bliskiego zagrożenia (AGENTS.md:28) - gdy szept jest krytycznie blisko ucha
			var remaining_time = attack_duration_limit - attack_timer
			if remaining_time <= 1.8:
				_haptic_warning_timer -= delta
				if _haptic_warning_timer <= 0.0:
					_haptic_warning_timer = 0.15
					var intensity = clamp(remap(remaining_time, 1.8, 0.0, 0.3, 1.0), 0.3, 1.0)
					if left_hand:
						left_hand.trigger_haptic_pulse("haptic", 100.0, intensity, 0.1, 0.0)
					if right_hand:
						right_hand.trigger_haptic_pulse("haptic", 100.0, intensity, 0.1, 0.0)
			
			# Sprawdzenie zamachu kontrolera (aktywne odpędzenie machnięciem w stronę szeptu)
			_check_controller_defense(delta)

func _check_controller_defense(delta: float):
	if delta <= 0.0001 or camera == null:
		return

	var to_whisper = (global_position - camera.global_position).normalized()
	
	for ctrl in [left_hand, right_hand]:
		if ctrl == null:
			continue
			
		var cur_pos = ctrl.global_position
		var last_pos = _last_left_pos if ctrl == left_hand else _last_right_pos
		var vel = (cur_pos - last_pos) / delta
		var speed = vel.length()
		var dist = cur_pos.distance_to(global_position)
		
		if ctrl == left_hand:
			_last_left_pos = cur_pos
		else:
			_last_right_pos = cur_pos
			
		# 1. Ręka musi być uniesiona powyżej pasa
		var is_hand_raised = cur_pos.y > (camera.global_position.y - 0.45)
		
		# 2. Ręka musi być wysunięta w stronę szeptu
		var hand_vector = cur_pos - camera.global_position
		var is_hand_facing = hand_vector.normalized().dot(to_whisper) > 0.2
		
		if is_hand_raised and is_hand_facing:
			var swing_dir = vel.normalized()
			var is_swing_towards = swing_dir.dot(to_whisper) > 0.25
			
			# Odparcie szeptu: energiczny zamach w stronę szeptu LUB przybliżenie ręki blisko szeptu
			if (speed >= swing_speed_threshold and is_swing_towards) or (dist < swing_proximity_distance and speed >= 0.7):
				_whisper_survived(ctrl)
				return

## Gracz odpędził jeden szept machnięciem dłoni
func _whisper_survived(controller: XRController3D = null):
	_rounds_remaining -= 1
	SceneLoader.marionettes_defended += 1
	whisper_sound.stop()
	if _debug_mesh:
		_debug_mesh.visible = false
		
	# Haptyka potwierdzenia na kontrolerze, którym wykonano udany zamach
	if controller:
		controller.trigger_haptic_pulse("haptic", 140.0, 1.0, 0.35, 0.0)
		
	# Dedykowany dźwięk sukcesu: satysfakcjonujący świst rozproszenia (whoosh2.mp3)
	var success_player = AudioStreamPlayer.new()
	success_player.stream = preload("res://assets/sounds/whoosh2.mp3")
	success_player.volume_db = -2.0
	add_child(success_player)
	success_player.play()
	success_player.finished.connect(success_player.queue_free)
	
	if _rounds_remaining > 0:
		# Krótka przerwa, potem następny szept z INNEGO kierunku
		current_state = State.HIDDEN
		state_timer = randf_range(series_pause_min, series_pause_max)
		print("Marionette: Odpędzono szept machnięciem! Zostało jeszcze ", _rounds_remaining, " rund.")
	else:
		# Seria zakończona — długa przerwa
		_start_new_series()
		print("Marionette: Seria szeptów zakończona sukcesem. Odpoczynek.")

## Rozpoczyna nową serię z losową liczbą rund
func _start_new_series():
	current_state = State.HIDDEN
	if whisper_sound:
		whisper_sound.stop()
	_rounds_remaining = randi_range(min_whisper_rounds, max_whisper_rounds)
	state_timer = randf_range(long_pause_min, long_pause_max)

func _enter_whispering():
	current_state = State.WHISPERING
	attack_timer = 0.0
	grace_timer = grace_time
	_haptic_warning_timer = 0.0
	
	if camera:
		initial_player_pos = camera.global_position
		
		# Obliczenie losowego kąta wokół głowy gracza
		var angle = randf_range(0, TAU)
		var distance = randf_range(spawn_distance_min, spawn_distance_max)
		current_offset = Vector3(cos(angle) * distance, randf_range(0.05, 0.35), sin(angle) * distance)
		
		var spawn_pos = initial_player_pos + current_offset
		spawn_pos.x = clamp(spawn_pos.x, map_bounds_min.x, map_bounds_max.x)
		spawn_pos.y = clamp(spawn_pos.y, map_bounds_min.y, map_bounds_max.y)
		spawn_pos.z = clamp(spawn_pos.z, map_bounds_min.z, map_bounds_max.z)
		
		global_position = spawn_pos
		
	if left_hand:
		_last_left_pos = left_hand.global_position
	if right_hand:
		_last_right_pos = right_hand.global_position
		
	if _debug_mesh:
		_debug_mesh.visible = debug_visible
	whisper_sound.play()

func _trigger_jumpscare(reason: String):
	if current_state == State.JUMPSCARE:
		return
	current_state = State.JUMPSCARE
	print("Marionette Atak: ", reason)
	
	whisper_sound.stop()
	
	# Delegacja do wspólnego helpera (zatrzymanie timera, reparenting, haptyka, ekran Game Over)
	await JumpscareHelper.execute(self, jumpscare_sound, [], "Marionette — " + reason)
