extends CharacterBody3D

enum State { IDLE, LISTENING, PREPARING_CHARGE, CHARGING, JUMPSCARE }

## Próg hałasu wywołujący atak Foxy'ego
@export var noise_threshold: float = 10.0

## Krok obniżania progu hałasu co 10s (milestone)
@export var threshold_step: float = 1.5

## Minimalny dopuszczalny próg hałasu
@export var min_threshold: float = 7.0

## Szybkość opadania paska irytacji, gdy gracz milczy
@export var noise_decay_rate: float = 2.0

## Prędkość szarży Foxy'ego
@export var charge_speed: float = 12.0

## Czas "zamrożenia" i absolutnej ciszy przed szarżą
@export var prepare_time: float = 2.0

## Maksymalny czas szarży (failsafe)
@export var charge_max_duration: float = 4.0

## Czas odpoczynku (odnowienia) po wykonaniu szarży
@export var cooldown_time: float = 4.0

## Czas cyklu stąpnięcia Foxy'ego (krok + pauza na nasłuch)
@export var step_interval: float = 2.5

## Czas trwania ruchu w ramach jednego kroku
@export var step_move_duration: float = 0.65

## Prędkość podczas stąpnięcia Foxy'ego
@export var step_speed: float = 2.4

@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var run_sound: AudioStreamPlayer3D = $RunSound
@onready var walk_sound: AudioStreamPlayer3D = $WalkSound
@onready var mesh_instance = $MeshInstance3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger
@onready var block_trigger: Area3D = $BlockTrigger

var current_state: State = State.IDLE
var current_noise: float = 0.0
var target_position: Vector3 = Vector3.ZERO
var state_timer: float = 4.0
var is_jumpscaring: bool = false
var _step_cycle_timer: float = 0.0

var player_head: Node3D


func _ready():
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	if block_trigger:
		block_trigger.body_entered.connect(_on_block_entered)
	
	if EventBus:
		EventBus.noise_emitted.connect(_on_noise_emitted)
		if not EventBus.milestone_reached.is_connected(_on_milestone_reached):
			EventBus.milestone_reached.connect(_on_milestone_reached)
		
	_find_player()

func _on_milestone_reached(milestone: int) -> void:
	if is_jumpscaring:
		return
	noise_threshold = maxf(noise_threshold - threshold_step, min_threshold)
	cooldown_time = maxf(cooldown_time - 0.25, 2.0)
	print("[Foxy] Eskalacja (milestone %ds): noise_threshold=%.1f, cooldown=%.2f" % [milestone, noise_threshold, cooldown_time])

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

func _on_noise_emitted(pos: Vector3, noise_level: float):
	if current_state == State.LISTENING:
		current_noise += noise_level
		target_position = pos
		# Debug print
		# print("Foxy usłyszał hałas! Obecna irytacja: ", current_noise)
		
		if current_noise >= noise_threshold:
			_enter_preparing_charge()

func _enter_preparing_charge():
	current_state = State.PREPARING_CHARGE
	state_timer = prepare_time
	current_noise = 0.0
	_step_cycle_timer = 0.0
	if run_sound:
		run_sound.stop()
	if walk_sound:
		walk_sound.stop()
		
	var warning_player = AudioStreamPlayer3D.new()
	# Dedykowana próbka ostrzeżenia - niski, złowrogi sygnał zagrożenia
	warning_player.stream = preload("res://assets/sounds/danger.wav")
	warning_player.volume_db = 6.0
	warning_player.pitch_scale = 0.8
	add_child(warning_player)
	warning_player.play()
	warning_player.finished.connect(warning_player.queue_free)
	
	print("Foxy: Zapadła cisza. Przygotowuje szarżę.")

func _enter_charging():
	current_state = State.CHARGING
	state_timer = charge_max_duration
	_step_cycle_timer = 0.0
	
	if player_head == null:
		_find_player()
	if player_head:
		target_position = player_head.global_position
	
	# Obrót w stronę targetu
	var direction = (target_position - global_position)
	direction.y = 0
	if direction.length_squared() > 0.01:
		look_at(global_position + direction, Vector3.UP)
	
	if run_sound:
		run_sound.play()
	print("Foxy: Szarżuje!")

func _enter_idle():
	current_state = State.IDLE
	state_timer = cooldown_time
	_step_cycle_timer = 0.0
	velocity = Vector3.ZERO
	if run_sound:
		run_sound.stop()
	if walk_sound:
		walk_sound.stop()
	print("Foxy: Odpoczynek po szarży. Przestaje nasłuchiwać na ", cooldown_time, "s.")


func _physics_process(delta: float):
	if is_jumpscaring:
		return
		
	# Grawitacja
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		if current_state != State.CHARGING:
			velocity.y = 0.0
			
	match current_state:
		State.LISTENING:
			if current_noise > 0:
				current_noise -= noise_decay_rate * delta
				current_noise = max(current_noise, 0)
			
			if player_head == null:
				_find_player()
				
			if player_head:
				var p_pos = player_head.global_position
				var dir = (p_pos - global_position)
				dir.y = 0
				var dist = dir.length()
				
				if dist > 2.0:
					dir = dir.normalized()
					_step_cycle_timer -= delta
					
					# Nowy krok Foxy'ego co step_interval (2.5s)
					if _step_cycle_timer <= 0.0:
						_step_cycle_timer = step_interval
						if walk_sound:
							walk_sound.play(0.0)
					
					# Faza ruchu stąpnięcia (pierwsze 0.65s cyklu)
					var time_in_step = step_interval - _step_cycle_timer
					if time_in_step <= step_move_duration:
						velocity.x = dir.x * step_speed
						velocity.z = dir.z * step_speed
					else:
						# Faza bezruchu i nasłuchiwania (pozostałe ~1.85s cyklu)
						velocity.x = 0.0
						velocity.z = 0.0
					
					# Płynny obrót w stronę gracza
					var look_pos = global_position + dir
					if look_pos.distance_squared_to(global_position) > 0.01:
						var current_transform = global_transform
						var target_transform = current_transform.looking_at(look_pos, Vector3.UP)
						global_transform = current_transform.interpolate_with(target_transform, 6.0 * delta)
				else:
					velocity.x = 0.0
					velocity.z = 0.0
					_step_cycle_timer = 0.0
					if walk_sound:
						walk_sound.stop()
			else:
				velocity.x = 0.0
				velocity.z = 0.0
				_step_cycle_timer = 0.0
				if walk_sound:
					walk_sound.stop()

			
		State.PREPARING_CHARGE:
			state_timer -= delta
			velocity.x = 0
			velocity.z = 0
			if state_timer <= 0:
				_enter_charging()
				
		State.CHARGING:
			state_timer -= delta
			var direction = (target_position - global_position)
			direction.y = 0
			
			# Jeśli jesteśmy blisko celu lub minął czas szarży
			if direction.length() < 1.0 or state_timer <= 0:
				_enter_idle()
			else:
				direction = direction.normalized()
				velocity.x = direction.x * charge_speed
				velocity.z = direction.z * charge_speed
				
				# Ślizganie / odrzucenie szarży po wpadnięciu w ścianę
				if is_on_wall():
					print("Foxy: Uderzył w ścianę!")
					_enter_idle()

		State.IDLE:
			state_timer -= delta
			velocity.x = 0
			velocity.z = 0
			if state_timer <= 0:
				current_state = State.LISTENING
				_step_cycle_timer = 0.0
				print("Foxy: Znów nasłuchuje.")

				
	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player"):
		is_jumpscaring = true
		if jumpscare_trigger:
			jumpscare_trigger.set_deferred("monitoring", false)
		current_state = State.JUMPSCARE
		velocity = Vector3.ZERO
		if run_sound:
			run_sound.stop()
		if walk_sound:
			walk_sound.stop()
		print("Foxy: Jumpscare!")
		await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance], "Foxy — Niezablokowana szarża")

func _on_block_entered(body: Node3D):
	if is_jumpscaring:
		return
	if current_state == State.CHARGING:
		print("Foxy: Zablokowany przez rękę (", body.name, ")!")
		SceneLoader.foxy_charges_blocked += 1
		
		# Haptyka obronna na kontrolerze dłoni
		var controller = body as XRController3D
		if controller == null and body.get_parent() is XRController3D:
			controller = body.get_parent() as XRController3D
		elif controller == null and body.get_parent() and body.get_parent().get_parent() is XRController3D:
			controller = body.get_parent().get_parent() as XRController3D
		if controller:
			controller.trigger_haptic_pulse("haptic", 120.0, 1.0, 0.35, 0.0)
		
		var success_player = AudioStreamPlayer.new()
		success_player.stream = preload("res://assets/sounds/nice-sfx.mp3")
		success_player.volume_db = -5.0
		add_child(success_player)
		success_player.play()
		success_player.finished.connect(success_player.queue_free)
		
		_enter_idle()
