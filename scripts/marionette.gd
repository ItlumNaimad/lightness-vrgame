extends Node3D

enum State { HIDDEN, WHISPERING, JUMPSCARE }
var current_state: State = State.HIDDEN

## Granice spawnu Marionette (do konfiguracji w edytorze)
@export var map_bounds_min: Vector3 = Vector3(-9.0, 0.0, -9.0)
@export var map_bounds_max: Vector3 = Vector3(9.0, 3.0, 9.0)

## Dystans spawnu od gracza
@export var spawn_distance_min: float = 7.0
@export var spawn_distance_max: float = 9.0

## Próg kąta patrzenia (cos 45 stopni = 0.707)
@export var look_threshold: float = 0.707

## Maksymalny dopuszczalny ruch poziomy gracza w metrach
@export var max_movement_allowed: float = 0.6

## Czas patrzenia na źródło dźwięku, po którym następuje Jumpscare
@export var look_fail_time: float = 1.5

## Czas przetrwania (bezruch + odwrócony wzrok) potrzebny do odparcia ataku
@export var survive_time: float = 3.0

@onready var whisper_sound: AudioStreamPlayer3D = $WhisperSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var player: Node3D
var camera: XRCamera3D

var state_timer: float = 0.0
var look_timer: float = 0.0
var survive_timer: float = 0.0

var initial_player_pos: Vector3 = Vector3.ZERO

func _ready():
	_find_player()
	_enter_hidden()

func _find_player():
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		player = player_root
		camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")

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
			# 1. Weryfikacja ruchu gracza (tylko dystans poziomy — schylanie dozwolone)
			var current_player_pos = camera.global_position
			var pos_2d_start = Vector2(initial_player_pos.x, initial_player_pos.z)
			var pos_2d_current = Vector2(current_player_pos.x, current_player_pos.z)
			
			if pos_2d_current.distance_to(pos_2d_start) > max_movement_allowed:
				_trigger_jumpscare("Ruszyłeś się podczas szeptów!")
				return
			
			# 2. Weryfikacja wzroku gracza (dot product)
			var camera_forward = -camera.global_transform.basis.z.normalized()
			var direction_to_enemy = (global_position - camera.global_position).normalized()
			
			var dot = camera_forward.dot(direction_to_enemy)
			
			if dot > look_threshold:
				look_timer += delta
				survive_timer = 0.0
				if look_timer > look_fail_time:
					_trigger_jumpscare("Spojrzałeś na źródło szeptów!")
			else:
				survive_timer += delta
				look_timer = 0.0
				if survive_timer > survive_time:
					_enter_hidden()

func _enter_hidden():
	current_state = State.HIDDEN
	whisper_sound.stop()
	state_timer = randf_range(20.0, 35.0)

func _enter_whispering():
	current_state = State.WHISPERING
	look_timer = 0.0
	survive_timer = 0.0
	
	if camera:
		initial_player_pos = camera.global_position
		
		# Losowa pozycja na okręgu wokół gracza
		var angle = randf_range(0, TAU)
		var distance = randf_range(spawn_distance_min, spawn_distance_max)
		var spawn_pos = initial_player_pos + Vector3(cos(angle) * distance, 0, sin(angle) * distance)
		
		# Wysokość obok głowy gracza (z lekkim offsetem)
		spawn_pos.y = initial_player_pos.y + randf_range(-0.5, 0.5)
		
		# Ograniczenie do granic mapy (konfigurowalnych z edytora)
		spawn_pos.x = clamp(spawn_pos.x, map_bounds_min.x, map_bounds_max.x)
		spawn_pos.y = clamp(spawn_pos.y, map_bounds_min.y, map_bounds_max.y)
		spawn_pos.z = clamp(spawn_pos.z, map_bounds_min.z, map_bounds_max.z)
		
		global_position = spawn_pos
		
	whisper_sound.play()

func _trigger_jumpscare(reason: String):
	if current_state == State.JUMPSCARE:
		return
	current_state = State.JUMPSCARE
	print("Marionette Atak: ", reason)
	
	whisper_sound.stop()
	
	# Delegacja do wspólnego helpera (zatrzymanie timera, reparenting, haptyka, powrót do menu)
	await JumpscareHelper.execute(self, jumpscare_sound)
