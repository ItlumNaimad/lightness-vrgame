extends CharacterBody3D

const SPEED = 1.0 # Prędkość poruszania się przeciwnika

@onready var mesh_instance = $MeshInstance3D
@onready var audio_player: AudioStreamPlayer3D = $BaloraTheme
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger

var player: Node3D
var is_jumpscaring: bool = false

func _ready():
	# Podpięcie sygnału łapania z nowego węzła Area3D
	# ![ASK] Czy to jest podpięty sygnał do Area3D który jest odpowiedzialny za jumpscare trigger?
	jumpscare_trigger.body_entered.connect(_on_body_entered)
	
	# Znalezienie aktywnej pozycji głowy gracza
	var player_root = get_tree().get_first_node_in_group("player")
	# ![ASK] Czy potrzeba w sumie podzielenia zmiennych na player i player_root? Bo chyba jedyny sens mają te zmienne jak będą typowane
	if player_root:
		player = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
		if player == null:
			player = player_root
			
	# Zwiększenie pożądanego dystansu, by wysoka postać nie blokowała się na punktach nawigacji na podłodze
	if nav_agent:
		nav_agent.path_desired_distance = 2.0
		nav_agent.target_desired_distance = 2.0

func _physics_process(delta: float):
	# ![ASK] Po co ta linijka? Do czego w ogóle służy? Sprawdza tylko czy ballora jumspcaruje lub czy player jest nullem a i tak zwraca tylko returna
	if is_jumpscaring or player == null:
		return

	# 1. Przekazanie agentowi nawigacji aktualnej pozycji gracza
	nav_agent.target_position = player.global_position

	# 2. Obliczanie wektora ruchu w stronę następnego punktu na ścieżce NavMesh
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	# ![ASK] czy cały algorytm poruszania (po za tym że ma sens i maa get_next_path_position() które omija przeszkody) to czy jest optymalnie zaprojektowanym algorytmem?
	var direction = (next_location - current_location)
	direction.y = 0
	direction = direction.normalized()
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	# 3. Dodanie grawitacji, aby postać nie unosiła się w powietrzu
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		velocity.y = 0.0

	# 4. Wykonanie ruchu z automatycznym ślizganiem się po przeszkodach
	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player"):
		is_jumpscaring = true
		# Natychmiast wyłącz detekcję, żeby nie odpalić jumpscare'a dwa razy
		jumpscare_trigger.set_deferred("monitoring", false)
		_trigger_jumpscare(body)

func _trigger_jumpscare(_player_body: Node3D):
	# Zatrzymanie ruchu przeciwnika
	velocity = Vector3.ZERO
	audio_player.stop()
	
	# Delegacja do wspólnego helpera (reparenting, haptyka, powrót do menu)
	# ![ASK] Co to JumpspcareHelper i jak działa await w Godocie i co w ogóle robi linijka poniżej
	await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance, audio_player])
