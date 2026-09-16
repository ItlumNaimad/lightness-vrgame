extends Node
class_name PlayerAudioManager

@export var rotation_threshold_degrees: float = 8.0
@export var walk_noise_level: float = 1.0
@export var sprint_noise_level: float = 2.8
@export var wall_noise_level: float = 3.5
@export var wall_cooldown: float = 0.4
@export var echolocation_noise_level: float = 4.5
@export var echolocation_cooldown: float = 2.0

@onready var origin: XROrigin3D = get_node_or_null("../XROrigin3D")
@onready var turn_audio_player: AudioStreamPlayer = $TurnAudioPlayer
@onready var footstep_provider = get_node_or_null("../XROrigin3D/MovementFootstep")
@onready var sprint_provider = get_node_or_null("../XROrigin3D/MovementSprint")
@onready var player_body: CharacterBody3D = get_node_or_null("../XROrigin3D/PlayerBody")

var left_ctrl: XRController3D
var right_ctrl: XRController3D

var _last_rotation_y: float = 0.0
var _accumulated_turn: float = 0.0
var _wall_hit_timer: float = 0.0
var _compass_cooldown_timer: float = 0.0
var _echolocation_timer: float = 0.0

func _ready():
	if origin == null and get_parent():
		origin = get_parent().get_node_or_null("XROrigin3D")
		
	if origin:
		if footstep_provider == null:
			footstep_provider = origin.get_node_or_null("MovementFootstep")
		if sprint_provider == null:
			sprint_provider = origin.get_node_or_null("MovementSprint")
		if player_body == null:
			player_body = origin.get_node_or_null("PlayerBody")
		left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
		right_ctrl = origin.get_node_or_null("right_hand") as XRController3D
		_last_rotation_y = origin.global_transform.basis.get_euler().y
		
	if footstep_provider and not footstep_provider.footstep.is_connected(_on_footstep):
		footstep_provider.footstep.connect(_on_footstep)

func _physics_process(delta: float):
	if _wall_hit_timer > 0.0:
		_wall_hit_timer -= delta
	if _compass_cooldown_timer > 0.0:
		_compass_cooldown_timer -= delta
	if _echolocation_timer > 0.0:
		_echolocation_timer -= delta

	# 1. Wykrywanie kolizji ze ścianami (hałas, dźwięk uderzenia, haptyka)
	if player_body and player_body.is_on_wall() and _wall_hit_timer <= 0.0:
		var moving := false
		if "ground_control_velocity" in player_body:
			moving = (player_body.ground_control_velocity as Vector3).length() > 0.4
		elif player_body.velocity.length() > 0.4:
			moving = true
			
		if moving:
			_wall_hit_timer = wall_cooldown
			_trigger_wall_collision()

	# 2. Obsługa pulsu echolokacji (przycisk ax_button na kontrolerze VR)
	var ax_pressed := false
	if left_ctrl and left_ctrl.is_button_pressed("ax_button"):
		ax_pressed = true
	elif right_ctrl and right_ctrl.is_button_pressed("ax_button"):
		ax_pressed = true
		
	if ax_pressed and _echolocation_timer <= 0.0:
		_echolocation_timer = echolocation_cooldown
		_trigger_echolocation()

	# 2. Wykrywanie obrotu i dźwięk Whoosh / Kompas
	if origin:
		var current_rotation_y = origin.global_transform.basis.get_euler().y
		var angle_diff = angle_difference(_last_rotation_y, current_rotation_y)
		var diff = abs(rad_to_deg(angle_diff))
		
		_accumulated_turn += diff
		
		# Wykrywanie obrotu skokowego (duży skok w 1 klatce) lub płynnego (nagromadzony obrót)
		if diff >= rotation_threshold_degrees or _accumulated_turn >= 20.0:
			_accumulated_turn = 0.0
			if turn_audio_player:
				if TTSManager:
					turn_audio_player.volume_db = TTSManager.whoosh_volume_db
				else:
					turn_audio_player.volume_db = 3.0
					
				if angle_diff > 0:
					turn_audio_player.pitch_scale = 0.85 # Obrót w lewo (niższy ton)
				else:
					turn_audio_player.pitch_scale = 1.15 # Obrót w prawo (wyższy ton)
				
				turn_audio_player.play()
				
				# Kompas dźwiękowy: Północ (0) -> wysoki ton, Południe (+/- PI) -> niski ton
				if (TTSManager == null or TTSManager.sound_compass_enabled) and _compass_cooldown_timer <= 0.0:
					_compass_cooldown_timer = 0.25
					var compass_pitch = remap(abs(current_rotation_y), 0.0, PI, 1.4, 0.6)
					_trigger_compass_ping(compass_pitch)
				
		_last_rotation_y = current_rotation_y

func _trigger_wall_collision():
	# Dźwięk głuchego uderzenia w ścianę
	var wall_sfx = AudioStreamPlayer.new()
	wall_sfx.stream = preload("res://assets/sounds/footstep_slow2.wav")
	wall_sfx.volume_db = 4.0
	wall_sfx.pitch_scale = 0.6
	add_child(wall_sfx)
	wall_sfx.play()
	wall_sfx.finished.connect(wall_sfx.queue_free)
	
	# Hałas uderzenia ostrzegający wrogów (np. Foxy)
	var hit_pos = player_body.global_position if player_body else (origin.global_position if origin else Vector3.ZERO)
	if EventBus:
		EventBus.noise_emitted.emit(hit_pos, wall_noise_level)
		
	# Fizyczna haptyka uderzenia na obu kontrolerach
	_trigger_collision_rumble()

func _trigger_collision_rumble():
	if origin:
		var left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
		var right_ctrl = origin.get_node_or_null("right_hand") as XRController3D
		if left_ctrl:
			left_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)
		if right_ctrl:
			right_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)

func _trigger_compass_ping(pitch: float):
	await get_tree().create_timer(0.18).timeout
	if not is_inside_tree():
		return
	var compass_player = AudioStreamPlayer.new()
	# Dedykowany dzwon kompasu zamiast wieloznacznego nice-sfx
	compass_player.stream = preload("res://assets/sounds/Broken bell.ogg")
	compass_player.volume_db = -12.0
	compass_player.pitch_scale = pitch
	add_child(compass_player)
	compass_player.play()
	compass_player.finished.connect(compass_player.queue_free)

func _on_footstep(_surface_name: String):
	# Zarejestrowano krok. Zliczamy statystykę w SceneLoader.
	SceneLoader.steps_taken += 1
	
	var is_sprinting := false
	if sprint_provider and "is_active" in sprint_provider:
		is_sprinting = sprint_provider.is_active
	elif player_body and "ground_control_velocity" in player_body:
		is_sprinting = player_body.ground_control_velocity.length() > 2.0
	
	var current_noise = sprint_noise_level if is_sprinting else walk_noise_level
	
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position if origin else Vector3.ZERO, current_noise)

func _trigger_echolocation():
	if origin == null:
		return
		
	var space_state = origin.get_world_3d().direct_space_state
	var start_pos = origin.global_position + Vector3(0, 1.2, 0)
	
	# Startowy impuls dźwiękowy
	var pulse_player = AudioStreamPlayer.new()
	pulse_player.stream = preload("res://assets/sounds/Broken bell.ogg")
	pulse_player.volume_db = -4.0
	pulse_player.pitch_scale = 1.65
	add_child(pulse_player)
	pulse_player.play()
	pulse_player.finished.connect(pulse_player.queue_free)
	
	# Hałas sonaru ostrzegający wrogów (ryzyko ściągnięcia Foxy'ego!)
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position, echolocation_noise_level)
		
	# Haptyka impulsu na kontrolerach
	if left_ctrl:
		left_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.7, 0.12, 0.0)
	if right_ctrl:
		right_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.7, 0.12, 0.0)
		
	# Wypuszczenie 8 promieni echolokacyjnych (równomiernie w 8 stron świata)
	for i in range(8):
		var angle = (float(i) / 8.0) * TAU
		var dir = Vector3(cos(angle), 0, sin(angle))
		var end_pos = start_pos + dir * 35.0
		var query = PhysicsRayQueryParameters3D.create(start_pos, end_pos, 1)
		var result = space_state.intersect_ray(query)
		if result:
			var hit_pos: Vector3 = result.position
			var dist = start_pos.distance_to(hit_pos)
			var delay = clamp(dist / 28.0, 0.06, 1.1)
			_spawn_delayed_echo(hit_pos, dist, delay)

func _spawn_delayed_echo(hit_pos: Vector3, dist: float, delay: float):
	await get_tree().create_timer(delay).timeout
	if not is_inside_tree():
		return
	var echo = AudioStreamPlayer3D.new()
	echo.stream = preload("res://assets/sounds/Broken bell.ogg")
	echo.unit_size = 10.0
	echo.max_distance = 40.0
	echo.volume_db = clamp(remap(dist, 2.0, 30.0, 0.0, -16.0), -16.0, 0.0)
	echo.pitch_scale = clamp(remap(dist, 2.0, 30.0, 1.1, 0.55), 0.55, 1.1)
	add_child(echo)
	echo.global_position = hit_pos
	echo.play()
	echo.finished.connect(echo.queue_free)
