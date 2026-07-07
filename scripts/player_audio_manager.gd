extends Node
class_name PlayerAudioManager

@export var rotation_threshold_degrees: float = 10.0

@onready var origin: XROrigin3D = $"../XROrigin3D"
@onready var turn_audio_player: AudioStreamPlayer = $TurnAudioPlayer
@onready var footstep_provider = $"../XROrigin3D/MovementFootstep"

var _last_rotation_y: float = 0.0

func _ready():
	# Podłącz sygnały jeśli komponenty istnieją
	if footstep_provider:
		footstep_provider.footstep.connect(_on_footstep)
		
	if origin:
		_last_rotation_y = origin.global_transform.basis.get_euler().y

func _physics_process(delta: float):
	if origin:
		var current_rotation_y = origin.global_transform.basis.get_euler().y
		var diff = abs(rad_to_deg(angle_difference(_last_rotation_y, current_rotation_y)))
		
		# Sprawdzamy czy zmiana kąta w jednej klatce jest większa niż próg (skokowy obrót)
		# Snap turning działa poprzez nagłą zmianę rotacji
		if diff >= rotation_threshold_degrees:
			if turn_audio_player and not turn_audio_player.playing:
				turn_audio_player.play()
				
		_last_rotation_y = current_rotation_y

func _on_footstep(surface_name: String):
	# Zarejestrowano krok. W tym miejscu możemy dodać powiadomienie dla Foxy'ego o hałasie.
	var noise_level = 1.0
	
	# Szukamy PlayerBody by sprawdzić prędkość
	var player_body = origin.get_node_or_null("PlayerBody")
	if player_body:
		if player_body.ground_control_velocity.length() > 2.0:
			noise_level = 2.5 # Bieg jest dużo głośniejszy
	
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position, noise_level)
