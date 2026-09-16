extends Node3D

enum State { DORMANT, STALKING, GRABBED }

@export var min_dormant_time: float = 25.0
@export var max_dormant_time: float = 45.0
@export var stalk_duration: float = 3.0
@export var escape_time_limit: float = 3.5
@export var required_shake: float = 16.0
@export var shake_accel_threshold: float = 6.0

@onready var crawl_sound: AudioStreamPlayer3D = $CrawlSound
@onready var grab_sound: AudioStreamPlayer3D = $GrabSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var current_state: State = State.DORMANT
var _state_timer: float = 0.0
var _shake_progress: float = 0.0

var player_root: Node3D
var left_hand: XRController3D
var right_hand: XRController3D
var target_hand: XRController3D

var _last_hand_pos: Vector3 = Vector3.ZERO
var _last_vel: Vector3 = Vector3.ZERO
var _haptic_loop_timer: float = 0.0

func _ready():
	_find_player()
	_enter_dormant()

func _find_player():
	var root = get_tree().get_first_node_in_group("player")
	if root:
		player_root = root
		var origin = root.get_node_or_null("XROrigin3D")
		if origin:
			left_hand = origin.get_node_or_null("left_hand")
			right_hand = origin.get_node_or_null("right_hand")

func _enter_dormant():
	current_state = State.DORMANT
	_state_timer = randf_range(min_dormant_time, max_dormant_time)
	target_hand = null
	if crawl_sound:
		crawl_sound.stop()
	if grab_sound:
		grab_sound.stop()

func _enter_stalking():
	if left_hand == null or right_hand == null:
		_find_player()
		if left_hand == null and right_hand == null:
			_enter_dormant()
			return

	# Losowanie zaatakowanej ręki
	var hands: Array[XRController3D] = []
	if left_hand: hands.append(left_hand)
	if right_hand: hands.append(right_hand)
	target_hand = hands.pick_random()

	current_state = State.STALKING
	_state_timer = stalk_duration
	
	# Start dźwięku pełzania poniżej ręki
	global_position = target_hand.global_position + Vector3(0, -0.6, 0)
	if crawl_sound:
		crawl_sound.play()
	print("Phantom Grasp: Pełznie w stronę dłoni: ", target_hand.name)

func _enter_grabbed():
	current_state = State.GRABBED
	_state_timer = escape_time_limit
	_shake_progress = 0.0
	_haptic_loop_timer = 0.0
	
	if crawl_sound:
		crawl_sound.stop()
	if grab_sound:
		grab_sound.play()
		
	if target_hand:
		_last_hand_pos = target_hand.global_position
		_last_vel = Vector3.ZERO
	print("Phantom Grasp: CHWYT za dłoń! Potrząsaj kontrolerem, by się wyrwać!")

func _process(delta: float):
	match current_state:
		State.DORMANT:
			_state_timer -= delta
			if _state_timer <= 0.0:
				_enter_stalking()

		State.STALKING:
			_state_timer -= delta
			if target_hand:
				# Pełzanie zbliża się wprost do dłoni
				var t = 1.0 - (_state_timer / stalk_duration)
				global_position = target_hand.global_position + Vector3(0, lerp(-0.6, 0.0, t), 0)
				
			if _state_timer <= 0.0:
				_enter_grabbed()

		State.GRABBED:
			_state_timer -= delta
			if target_hand:
				global_position = target_hand.global_position
				
				# Ciągła silna wibracja pochwyconego kontrolera
				_haptic_loop_timer -= delta
				if _haptic_loop_timer <= 0.0:
					_haptic_loop_timer = 0.08
					target_hand.trigger_haptic_pulse("haptic", 150.0, 1.0, 0.08, 0.0)

				# Detekcja wyszarpywania (gwałtowne potrząsanie)
				var cur_pos = target_hand.global_position
				var vel = (cur_pos - _last_hand_pos) / max(delta, 0.001)
				var accel = (vel - _last_vel).length()
				_last_hand_pos = cur_pos
				_last_vel = vel
				
				if accel >= shake_accel_threshold:
					_shake_progress += accel * delta * 1.8
					
				if _shake_progress >= required_shake:
					_break_free()
					return

			if _state_timer <= 0.0:
				_trigger_jumpscare()

func _break_free():
	print("Phantom Grasp: Wyrwano się z uścisku macek!")
	if grab_sound:
		grab_sound.stop()
		
	# Dźwięk sukcesu i impuls haptyczny
	if target_hand:
		target_hand.trigger_haptic_pulse("haptic", 80.0, 0.5, 0.2, 0.0)
		
	var break_sfx = AudioStreamPlayer.new()
	break_sfx.stream = preload("res://assets/sounds/whoosh2.mp3")
	break_sfx.volume_db = 2.0
	break_sfx.pitch_scale = 0.85
	add_child(break_sfx)
	break_sfx.play()
	break_sfx.finished.connect(break_sfx.queue_free)
	
	_enter_dormant()

func _trigger_jumpscare():
	if current_state == State.DORMANT:
		return
	print("Phantom Grasp: Jumpscare!")
	if grab_sound:
		grab_sound.stop()
	await JumpscareHelper.execute(self, jumpscare_sound, [], "Phantom Grasp — Zmiażdżenie uściskiem macek")
