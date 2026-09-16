extends Node
class_name PlayerAudioManager

@export var walk_noise_level: float = 1.0
@export var sprint_noise_level: float = 2.8
@export var wall_noise_level: float = 3.5
@export var wall_cooldown: float = 0.4

@onready var origin: XROrigin3D = get_node_or_null("../XROrigin3D")
@onready var footstep_provider = get_node_or_null("../XROrigin3D/MovementFootstep")
@onready var sprint_provider = get_node_or_null("../XROrigin3D/MovementSprint")
@onready var player_body: CharacterBody3D = get_node_or_null("../XROrigin3D/PlayerBody")

var left_ctrl: XRController3D
var right_ctrl: XRController3D

var _wall_hit_timer: float = 0.0

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
		
	if footstep_provider and not footstep_provider.footstep.is_connected(_on_footstep):
		footstep_provider.footstep.connect(_on_footstep)

func _physics_process(delta: float):
	if _wall_hit_timer > 0.0:
		_wall_hit_timer -= delta

	# 1. Wykrywanie kolizji ze ścianami (hałas, dźwięk uderzenia, haptyka)
	if player_body and player_body.is_on_wall() and _wall_hit_timer <= 0.0:
		var moving := false
		if "ground_control_velocity" in player_body:
			var gcv = player_body.ground_control_velocity
			if gcv is Vector2 or gcv is Vector3:
				moving = gcv.length() > 0.4
		elif "velocity" in player_body and player_body.velocity is Vector3:
			moving = player_body.velocity.length() > 0.4
			
		if moving:
			_wall_hit_timer = wall_cooldown
			_trigger_wall_collision()


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
		if left_ctrl == null:
			left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
		if right_ctrl == null:
			right_ctrl = origin.get_node_or_null("right_hand") as XRController3D
		if left_ctrl:
			left_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)
		if right_ctrl:
			right_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)

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

