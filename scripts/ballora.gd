extends Area3D

const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

@onready var mesh_instance = $MeshInstance3D
@onready var audio_player: AudioStreamPlayer3D = $BaloraTheme
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var is_jumpscaring: bool = false

func _ready():
	# Połączenie sygnału wejścia w obszar przeciwnika
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	# Sprawdzamy czy ciało to ciało gracza VR
	if "PlayerBody" in body.name or body.is_in_group("player"):
		is_jumpscaring = true
		_trigger_jumpscare(body)
		
func _trigger_jumpscare(player_body: Node3D):
	# 1. Zablokowanie wektora ruchu gracza
	if "enabled" in player_body:
		player_body.enabled = false
	
	# 2. Nawigacja w drzewie
	var xr_origin = player_body.get_parent()
	var camera = xr_origin.get_node_or_null("XRCamera3D")
	
	if camera:
		#3. Ekstracja macierzy transformacji przed zmianą struktury drzewa
		var mesh_global_trans = mesh_instance.global_transform
		var audio_global_trans = audio_player.global_transform
		
		# 4. Reparenting obiektów do kamery gracza
		remove_child(mesh_instance)
		remove_child(audio_player)
		camera.add_child(mesh_instance)
		camera.add_child(audio_player)
		
		# 5. Aplikacja pierwotnych kordynatów globalnych
		mesh_instance.global_transform = mesh_global_trans
		audio_player.global_transform = audio_global_trans
		
		# 6. Obiekt Tween
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		
		# Definicja punktu uderzenia ( 0 w osi X, lekkie obniżenie w Y, 0.5 metra z...)
		var target_transform = Transform3D()
		target_transform.origin = Vector3(0, -0.3, -0.5)
		
		# Aplikacja płynnego przejścia trwającego 0.2 sekundy
		
		tween.tween_property(mesh_instance, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
		tween.tween_property(audio_player, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
		
		audio_player.stop()
		jumpscare_sound.play()
	# 7. Asynchroniczne oczeikwanie na zakończenie sekwencji ataku
	await get_tree().create_timer(3.0).timeout
	_return_to_main_menu()
func _return_to_main_menu():
	var current_node = self
	
	# Szukamy w górę drzewa węzła, który zajmuje się zmienianiem scen (np. GameMap / Main)
	while current_node != null:
		if current_node.has_signal("request_load_scene"):
			current_node.request_load_scene.emit(MAIN_MENU_PATH)
			return
		current_node = current_node.get_parent()
	
	print("Błąd: Nie znaleziono węzła odpowiedzialnego za zmianę sceny.")
