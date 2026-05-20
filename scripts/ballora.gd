extends CharacterBody3D

const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"
const SPEED = 1.5 # Prędkość poruszania się przeciwnika

@onready var mesh_instance = $MeshInstance3D
@onready var audio_player: AudioStreamPlayer3D = $BaloraTheme
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger

var player: Node3D
var is_jumpscaring: bool = false

func _ready():
	# Podpięcie sygnału łapania z nowego węzła Area3D
	jumpscare_trigger.body_entered.connect(_on_body_entered)
	
	# Znalezienie gracza za pomocą przypisanej grupy
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float):
	if is_jumpscaring or player == null:
		return

	# 1. Przekazanie agentowi nawigacji aktualnej pozycji gracza
	nav_agent.target_position = player.global_position

	# 2. Obliczanie wektora ruchu w stronę następnego punktu na ścieżce NavMesh
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	
	var direction = (next_location - current_location)
	direction.y = 0
	direction = direction.normalized()
	
	var current_y_velocity = velocity.y
	velocity = direction * SPEED
	
	# 3. Dodanie grawitacji, aby postać nie unosiła się w powietrzu
	if not is_on_floor():
		current_y_velocity -= 9.8 * delta
		
	velocity.y = current_y_velocity

	# 4. Wykonanie ruchu z automatycznym ślizganiem się po przeszkodach
	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player"):
		is_jumpscaring = true
		_trigger_jumpscare(body)

func _trigger_jumpscare(player_body: Node3D):
	# Zatrzymanie ruchu przeciwnika
	velocity = Vector3.ZERO
	
	if "enabled" in player_body:
		player_body.set_deferred("enabled", false)
	
	var current_node = self
	while current_node != null:
		if current_node.has_method("stop_timer_and_save"):
			current_node.stop_timer_and_save()
			break
		current_node = current_node.get_parent()
	
	var xr_origin = player_body.get_parent()
	var camera = xr_origin.get_node_or_null("XRCamera3D")
	
	if camera:
		var mesh_global_trans = mesh_instance.global_transform
		var audio_global_trans = audio_player.global_transform
		
		remove_child(mesh_instance)
		remove_child(audio_player)
		camera.add_child(mesh_instance)
		camera.add_child(audio_player)
		
		mesh_instance.global_transform = mesh_global_trans
		audio_player.global_transform = audio_global_trans
		
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		
		var target_transform = Transform3D()
		target_transform.origin = Vector3(0, -0.3, -0.5)
		
		tween.tween_property(mesh_instance, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
		tween.tween_property(audio_player, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
		
		audio_player.stop()
		jumpscare_sound.play()

	await get_tree().create_timer(2.0).timeout
	SceneLoader.load_scene(MAIN_MENU_PATH)
