extends Node
class_name PlayerAudioManager

@export var rotation_threshold_degrees: float = 8.0

@onready var origin: XROrigin3D = get_node_or_null("../XROrigin3D")
@onready var turn_audio_player: AudioStreamPlayer = $TurnAudioPlayer
@onready var footstep_provider = get_node_or_null("../XROrigin3D/MovementFootstep")

var _last_rotation_y: float = 0.0
var _accumulated_turn: float = 0.0

func _ready():
	if origin == null and get_parent():
		origin = get_parent().get_node_or_null("XROrigin3D")
		
	if footstep_provider == null and origin:
		footstep_provider = origin.get_node_or_null("MovementFootstep")
		
	if footstep_provider and not footstep_provider.footstep.is_connected(_on_footstep):
		footstep_provider.footstep.connect(_on_footstep)
		
	if origin:
		_last_rotation_y = origin.global_transform.basis.get_euler().y

func _physics_process(delta: float):
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
				if TTSManager == null or TTSManager.sound_compass_enabled:
					var compass_pitch = remap(abs(current_rotation_y), 0.0, PI, 1.5, 0.5)
					_trigger_compass_ping(compass_pitch)
				
		_last_rotation_y = current_rotation_y

func _trigger_compass_ping(pitch: float):
	# Dźwięk pingu jest opóźniony względem whoosha
	await get_tree().create_timer(0.18).timeout
	var compass_player = AudioStreamPlayer.new()
	compass_player.stream = preload("res://assets/sounds/nice-sfx.mp3")
	compass_player.volume_db = -6.0
	compass_player.pitch_scale = pitch
	add_child(compass_player)
	compass_player.play()
	compass_player.finished.connect(compass_player.queue_free)

func _on_footstep(surface_name: String):
	# Zarejestrowano krok. Zliczamy statystykę w SceneLoader.
	SceneLoader.steps_taken += 1
	var noise_level = 1.0
	
	if origin:
		var player_body = origin.get_node_or_null("PlayerBody")
		if player_body:
			if player_body.ground_control_velocity.length() > 2.0:
				noise_level = 2.5 # Bieg jest dużo głośniejszy
	
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position if origin else Vector3.ZERO, noise_level)
