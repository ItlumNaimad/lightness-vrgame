extends CharacterBody3D

enum State { IDLE, LISTENING, PREPARING_CHARGE, CHARGING, JUMPSCARE }

## Próg hałasu wywołujący atak Foxy'ego
@export var noise_threshold: float = 10.0

## Szybkość opadania paska irytacji, gdy gracz milczy
@export var noise_decay_rate: float = 2.0

## Prędkość szarży Foxy'ego
@export var charge_speed: float = 12.0

## Czas "zamrożenia" i absolutnej ciszy przed szarżą
@export var prepare_time: float = 2.0

## Maksymalny czas szarży (failsafe)
@export var charge_max_duration: float = 4.0

## Czas odpoczynku (odnowienia) po wykonaniu szarży
@export var cooldown_time: float = 10.0

@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var run_sound: AudioStreamPlayer3D = $RunSound
@onready var mesh_instance = $MeshInstance3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger

var current_state: State = State.LISTENING
var current_noise: float = 0.0
var target_position: Vector3 = Vector3.ZERO
var state_timer: float = 0.0
var is_jumpscaring: bool = false

func _ready():
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	
	if ClassDB.class_exists("EventBus") or true:
		# Odwołanie do autoload EventBus
		var event_bus = get_node_or_null("/root/EventBus")
		if event_bus:
			event_bus.noise_emitted.connect(_on_noise_emitted)

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
	run_sound.stop()
	print("Foxy: Zapadła cisza. Przygotowuje szarżę na ", target_position)

func _enter_charging():
	current_state = State.CHARGING
	state_timer = charge_max_duration
	
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
	velocity = Vector3.ZERO
	if run_sound:
		run_sound.stop()
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
			velocity.x = 0
			velocity.z = 0
			
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
		print("Foxy: Jumpscare!")
		await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance])
