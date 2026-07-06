extends Node3D

enum State { HIDDEN, WHISPERING, JUMPSCARE }
var current_state: State = State.HIDDEN

## Włącz widoczny mesh debugowy (kula), żeby widzieć gdzie Marionette się pojawia
@export var debug_visible: bool = false

## Granice spawnu Marionette (do konfiguracji w edytorze)
@export var map_bounds_min: Vector3 = Vector3(-9.0, 0.0, -9.0)
@export var map_bounds_max: Vector3 = Vector3(9.0, 3.0, 9.0)

## Dystans spawnu od gracza
@export var spawn_distance_min: float = 1.0
@export var spawn_distance_max: float = 1.5

## Próg kąta patrzenia (cos 45 stopni = 0.707)
@export var look_threshold: float = 0.707

## Maksymalny dopuszczalny ruch poziomy gracza w metrach
@export var max_movement_allowed: float = 0.6

## Czas patrzenia na źródło dźwięku, po którym następuje Jumpscare
@export var look_fail_time: float = 1.5

## Czas przetrwania (bezruch + odwrócony wzrok) potrzebny do odparcia ataku
@export var survive_time: float = 1.5

## Maksymalny czas na reakcję przed Jumpscare'em (sekundy)
@export var attack_duration_limit: float = 3.0

## Czas łaski na zorientowanie się po pojawieniu szeptów (sekundy)
@export var grace_time: float = 2.5

## Minimalna / maksymalna liczba szeptów w jednej serii
@export var min_whisper_rounds: int = 2
@export var max_whisper_rounds: int = 4

## Przerwa między szeptami w serii (sekundy)
@export var series_pause_min: float = 3.0
@export var series_pause_max: float = 6.0

## Przerwa między seriami (sekundy)
@export var long_pause_min: float = 15.0
@export var long_pause_max: float = 30.0

@onready var whisper_sound: AudioStreamPlayer3D = $WhisperSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var player: Node3D
var camera: XRCamera3D

var state_timer: float = 0.0
var look_timer: float = 0.0
var survive_timer: float = 0.0
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
			attack_timer += delta
			if attack_timer > attack_duration_limit:
				_trigger_jumpscare("Czas na reakcję (3s) minął!")
				return
				
			# Przyczepienie do gracza: ciągłe podążanie za kamerą (głową) z wylosowanym offsetem
			var target_pos = camera.global_position + current_offset
			target_pos.x = clamp(target_pos.x, map_bounds_min.x, map_bounds_max.x)
			target_pos.y = clamp(target_pos.y, map_bounds_min.y, map_bounds_max.y)
			target_pos.z = clamp(target_pos.z, map_bounds_min.z, map_bounds_max.z)
			global_position = target_pos
			
			# 0. Okres łaski — gracz ma czas na zatrzymanie się
			if grace_timer > 0.0:
				grace_timer -= delta
				# Ciągle aktualizuj pozycję startową podczas grace period,
				# żeby nie karać za ruch sprzed "zamrożenia"
				initial_player_pos = camera.global_position
			else:
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
					_whisper_survived()

## Gracz odpędził jeden szept — sprawdź czy seria trwa dalej
func _whisper_survived():
	_rounds_remaining -= 1
	whisper_sound.stop()
	if _debug_mesh:
		_debug_mesh.visible = false
	
	if _rounds_remaining > 0:
		# Krótka przerwa, potem następny szept z INNEGO kierunku
		current_state = State.HIDDEN
		state_timer = randf_range(series_pause_min, series_pause_max)
		print("Marionette: Odpędzono szept, ale zostało jeszcze ", _rounds_remaining, " rund!")
	else:
		# Seria zakończona — długa przerwa
		_start_new_series()
		print("Marionette: Seria zakończona, odpoczynek.")

## Rozpoczyna nową serię z losową liczbą rund
func _start_new_series():
	current_state = State.HIDDEN
	_rounds_remaining = randi_range(min_whisper_rounds, max_whisper_rounds)
	state_timer = randf_range(long_pause_min, long_pause_max)

func _enter_whispering():
	current_state = State.WHISPERING
	look_timer = 0.0
	survive_timer = 0.0
	attack_timer = 0.0
	grace_timer = grace_time
	
	if camera:
		initial_player_pos = camera.global_position
		
		# Obliczenie stałego offsetu względem głowy gracza
		var angle = randf_range(0, TAU)
		var distance = randf_range(spawn_distance_min, spawn_distance_max)
		current_offset = Vector3(cos(angle) * distance, randf_range(-0.5, 0.5), sin(angle) * distance)
		
		# Ograniczenie pierwszej pozycji spawnu (będzie powtarzane co klatkę w _process)
		var spawn_pos = initial_player_pos + current_offset
		spawn_pos.x = clamp(spawn_pos.x, map_bounds_min.x, map_bounds_max.x)
		spawn_pos.y = clamp(spawn_pos.y, map_bounds_min.y, map_bounds_max.y)
		spawn_pos.z = clamp(spawn_pos.z, map_bounds_min.z, map_bounds_max.z)
		
		global_position = spawn_pos
		
	if _debug_mesh:
		_debug_mesh.visible = debug_visible
	whisper_sound.play()

func _trigger_jumpscare(reason: String):
	if current_state == State.JUMPSCARE:
		return
	current_state = State.JUMPSCARE
	print("Marionette Atak: ", reason)
	
	whisper_sound.stop()
	
	# Delegacja do wspólnego helpera (zatrzymanie timera, reparenting, haptyka, powrót do menu)
	await JumpscareHelper.execute(self, jumpscare_sound)
