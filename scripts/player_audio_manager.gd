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
	var col_count: int = player_body.get_slide_collision_count() if player_body else 0
	var normals: Array[Vector3] = []
	var hit_points: Array[Vector3] = []
	for i in range(col_count):
		var col = player_body.get_slide_collision(i)
		var n = col.get_normal()
		if abs(n.y) < 0.7:
			normals.append(Vector3(n.x, 0.0, n.z).normalized())
			hit_points.append(col.get_position())

	# Detekcja uderzenia w róg (kąt między co najmniej dwoma ścianami)
	var is_corner := false
	if normals.size() >= 2:
		for i in range(normals.size()):
			for j in range(i + 1, normals.size()):
				var angle = normals[i].angle_to(normals[j])
				if angle > deg_to_rad(35.0) and angle < deg_to_rad(150.0):
					is_corner = true
					break
			if is_corner:
				break

	# Określanie kierunku względem głowy gracza
	var head = origin.get_node_or_null("XRCamera3D") if origin else null
	var head_basis = head.global_transform.basis if head else (origin.global_transform.basis if origin else Basis.IDENTITY)
	var fwd = -head_basis.z
	fwd.y = 0.0
	fwd = fwd.normalized()
	var right_vec = head_basis.x
	right_vec.y = 0.0
	right_vec = right_vec.normalized()

	var avg_normal := Vector3.ZERO
	if not normals.is_empty():
		for n in normals:
			avg_normal += n
		avg_normal = avg_normal.normalized()
	else:
		avg_normal = -fwd

	var into_wall = -avg_normal
	var dot_fwd = fwd.dot(into_wall)
	var dot_right = right_vec.dot(into_wall)

	var hit_kind := "FRONT"
	if is_corner:
		hit_kind = "CORNER"
	elif dot_right > 0.38:
		hit_kind = "RIGHT"
	elif dot_right < -0.38:
		hit_kind = "LEFT"
	elif dot_fwd > 0.3:
		hit_kind = "FRONT"
	else:
		hit_kind = "BACK"

	var player_pos = origin.global_position if origin else Vector3.ZERO
	var sound_offset := Vector3.ZERO
	match hit_kind:
		"FRONT":
			sound_offset = fwd * 0.9 + Vector3(0, 1.2, 0)
		"BACK":
			sound_offset = -fwd * 0.9 + Vector3(0, 1.2, 0)
		"LEFT":
			sound_offset = -right_vec * 0.9 + fwd * 0.2 + Vector3(0, 1.2, 0)
		"RIGHT":
			sound_offset = right_vec * 0.9 + fwd * 0.2 + Vector3(0, 1.2, 0)
		"CORNER":
			var corner_side = 1.0 if dot_right >= 0 else -1.0
			sound_offset = (fwd + right_vec * corner_side * 0.7).normalized() * 0.9 + Vector3(0, 1.2, 0)

	var hit_pos_3d = player_pos + sound_offset

	# Odtworzenie kierunkowego dźwięku 3D o podwyższonej donośności
	_play_wall_sound_3d(hit_pos_3d, hit_kind)
	if hit_kind == "CORNER":
		_play_secondary_corner_sound(hit_pos_3d)

	# Hałas uderzenia ostrzegający wrogów
	var noise_val = wall_noise_level * (1.35 if hit_kind == "CORNER" else 1.0)
	if EventBus:
		EventBus.noise_emitted.emit(hit_pos_3d, noise_val)

	# Kierunkowa haptyka na kontrolerach VR
	_trigger_directional_collision_rumble(hit_kind)

func _play_wall_sound_3d(pos: Vector3, hit_kind: String):
	var wall_sfx = AudioStreamPlayer3D.new()
	wall_sfx.stream = preload("res://assets/sounds/footstep_slow2.wav")
	wall_sfx.bus = &"Footsteps"
	wall_sfx.unit_size = 4.0
	wall_sfx.max_distance = 20.0
	wall_sfx.volume_db = 9.5
	
	match hit_kind:
		"FRONT":
			wall_sfx.pitch_scale = 0.72
		"BACK":
			wall_sfx.pitch_scale = 0.68
		"LEFT", "RIGHT":
			wall_sfx.pitch_scale = 0.88
		"CORNER":
			wall_sfx.pitch_scale = 0.62

	add_child(wall_sfx)
	wall_sfx.global_position = pos
	wall_sfx.play()
	wall_sfx.finished.connect(wall_sfx.queue_free)

func _play_secondary_corner_sound(pos: Vector3):
	await get_tree().create_timer(0.08).timeout
	if not is_inside_tree():
		return
	var echo_sfx = AudioStreamPlayer3D.new()
	echo_sfx.stream = preload("res://assets/sounds/footstep_slow2.wav")
	echo_sfx.bus = &"Footsteps"
	echo_sfx.unit_size = 3.5
	echo_sfx.max_distance = 18.0
	echo_sfx.volume_db = 7.5
	echo_sfx.pitch_scale = 0.78
	add_child(echo_sfx)
	echo_sfx.global_position = pos + Vector3(0.15, 0, 0.15)
	echo_sfx.play()
	echo_sfx.finished.connect(echo_sfx.queue_free)

func _trigger_directional_collision_rumble(hit_kind: String):
	if origin == null:
		return
	if left_ctrl == null:
		left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
	if right_ctrl == null:
		right_ctrl = origin.get_node_or_null("right_hand") as XRController3D

	match hit_kind:
		"LEFT":
			if left_ctrl:
				left_ctrl.trigger_haptic_pulse("haptic", 150.0, 0.95, 0.25, 0.0)
			if right_ctrl:
				right_ctrl.trigger_haptic_pulse("haptic", 60.0, 0.2, 0.08, 0.0)
		"RIGHT":
			if right_ctrl:
				right_ctrl.trigger_haptic_pulse("haptic", 150.0, 0.95, 0.25, 0.0)
			if left_ctrl:
				left_ctrl.trigger_haptic_pulse("haptic", 60.0, 0.2, 0.08, 0.0)
		"FRONT", "BACK":
			if left_ctrl:
				left_ctrl.trigger_haptic_pulse("haptic", 170.0, 1.0, 0.28, 0.0)
			if right_ctrl:
				right_ctrl.trigger_haptic_pulse("haptic", 170.0, 1.0, 0.28, 0.0)
		"CORNER":
			if left_ctrl:
				left_ctrl.trigger_haptic_pulse("haptic", 180.0, 1.0, 0.32, 0.0)
			if right_ctrl:
				right_ctrl.trigger_haptic_pulse("haptic", 180.0, 1.0, 0.32, 0.0)
			_trigger_delayed_corner_rumble()

func _trigger_delayed_corner_rumble():
	await get_tree().create_timer(0.09).timeout
	if not is_inside_tree():
		return
	if left_ctrl:
		left_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.8, 0.15, 0.0)
	if right_ctrl:
		right_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.8, 0.15, 0.0)


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
