extends CharacterBody3D

enum State { PATROL, ALERT, CHASE, COOLDOWN }

@export var patrol_speed: float = 0.9
@export var alert_speed: float = 1.2
@export var chase_speed: float = 2.4

## Zasięg strefy Alertu (Balora zauważa obecność gracza)
@export var alert_distance: float = 7.5

## Zasięg strefy Krytycznej (natychmiastowy pościg)
@export var critical_distance: float = 3.5

## Czas obecności w strefie alertu wywołujący pościg (sekundy)
@export var max_alert_duration: float = 3.5

## Odległość ucieczki przerywająca pościg
@export var escape_distance: float = 9.5

## Czas utrzymania dystansu ucieczki potrzebny do zgubienia pościgu
@export var escape_time_required: float = 2.5

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var audio_player: AudioStreamPlayer3D = $BaloraTheme
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger

var current_state: State = State.PATROL
var player_head: Node3D
var is_jumpscaring: bool = false

var _alert_timer: float = 0.0
var _escape_timer: float = 0.0
var _cooldown_timer: float = 0.0
var _target_pitch: float = 1.0

# Węzły trasy patrolowej wokół mapy
var _patrol_points: Array[Vector3] = [
	Vector3(-10.0, 0.0, -10.0),
	Vector3(10.0, 0.0, -10.0),
	Vector3(10.0, 0.0, 10.0),
	Vector3(-10.0, 0.0, 10.0),
	Vector3(0.0, 0.0, 0.0)
]
var _current_patrol_idx: int = 0

func _ready():
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	
	_find_player()
	
	if nav_agent:
		nav_agent.path_desired_distance = 1.5
		nav_agent.target_desired_distance = 1.5

	_enter_patrol()

func _find_player():
	var head = get_tree().get_first_node_in_group("player_head")
	if head:
		player_head = head
	else:
		var player_root = get_tree().get_first_node_in_group("player")
		if player_root:
			player_head = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
			if player_head == null:
				player_head = player_root

func _enter_patrol():
	current_state = State.PATROL
	_target_pitch = 1.0
	_alert_timer = 0.0
	_escape_timer = 0.0
	if nav_agent:
		nav_agent.target_position = _patrol_points[_current_patrol_idx]
	print("Balora: Wznowiono patrol.")

func _enter_alert():
	current_state = State.ALERT
	_target_pitch = 1.35 # Przyspieszenie pozytywki - kluczowy sygnał dla gracza
	_alert_timer = 0.0
	print("Balora: ALERT — gracz w strefie bliskości! Pozytywka przyspiesza.")

func _enter_chase():
	current_state = State.CHASE
	_target_pitch = 1.7 # Pościg — bardzo szybka pozytywka
	_escape_timer = 0.0
	print("Balora: POŚCIG!")

func _enter_cooldown():
	current_state = State.COOLDOWN
	_target_pitch = 1.0
	_cooldown_timer = 3.0
	velocity.x = 0.0
	velocity.z = 0.0
	print("Balora: Gracz uciekł. Odpoczynek przed powrotem do patrolu.")

func _physics_process(delta: float):
	if is_jumpscaring:
		return
		
	if player_head == null:
		_find_player()
		if player_head == null:
			return

	# Płynna zmiana tempa pozytywki
	if audio_player:
		audio_player.pitch_scale = lerp(audio_player.pitch_scale, _target_pitch, delta * 3.0)

	var dist_to_player = global_position.distance_to(player_head.global_position)
	var active_speed = patrol_speed

	match current_state:
		State.PATROL:
			active_speed = patrol_speed
			var current_patrol_dest = _patrol_points[_current_patrol_idx]
			if global_position.distance_to(current_patrol_dest) < 2.0:
				_current_patrol_idx = (_current_patrol_idx + 1) % _patrol_points.size()
				nav_agent.target_position = _patrol_points[_current_patrol_idx]
			else:
				nav_agent.target_position = current_patrol_dest
				
			# Sprawdzenie wejścia gracza w strefy
			if dist_to_player <= critical_distance:
				_enter_chase()
			elif dist_to_player <= alert_distance:
				_enter_alert()

		State.ALERT:
			active_speed = alert_speed
			nav_agent.target_position = player_head.global_position
			_alert_timer += delta
			
			if dist_to_player <= critical_distance or _alert_timer >= max_alert_duration:
				_enter_chase()
			elif dist_to_player > alert_distance + 1.5:
				_enter_patrol()

		State.CHASE:
			active_speed = chase_speed
			nav_agent.target_position = player_head.global_position
			
			if dist_to_player > escape_distance:
				_escape_timer += delta
				if _escape_timer >= escape_time_required:
					_enter_cooldown()
			else:
				_escape_timer = 0.0

		State.COOLDOWN:
			_cooldown_timer -= delta
			if _cooldown_timer <= 0.0:
				_enter_patrol()
			active_speed = 0.0

	# Ruch po NavMesh
	if active_speed > 0.0 and nav_agent:
		var next_path_pos = nav_agent.get_next_path_position()
		var dir = (next_path_pos - global_position)
		dir.y = 0.0
		if dir.length_squared() > 0.01:
			dir = dir.normalized()
			velocity.x = dir.x * active_speed
			velocity.z = dir.z * active_speed
			
			# Obrót w stronę ruchu
			var look_pos = global_position + dir
			if look_pos.distance_squared_to(global_position) > 0.01:
				var current_transform = global_transform
				var target_transform = current_transform.looking_at(look_pos, Vector3.UP)
				global_transform = current_transform.interpolate_with(target_transform, 6.0 * delta)
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	# Grawitacja
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		velocity.y = 0.0

	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player") or body.is_in_group("player_head"):
		is_jumpscaring = true
		if jumpscare_trigger:
			jumpscare_trigger.set_deferred("monitoring", false)
		_trigger_jumpscare()

func _trigger_jumpscare():
	velocity = Vector3.ZERO
	if audio_player:
		audio_player.stop()
	
	await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance, audio_player], "Balora — Złapanie w strefie krytycznej")
