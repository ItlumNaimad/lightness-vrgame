## Wspólne narzędzia dla przeciwników w Lightness VR
## Wydzielony helper do obsługi sekwencji Jumpscare.
class_name JumpscareHelper

const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

static var is_jumpscaring_global: bool = false

## Wywołuje pełną sekwencję Jumpscare:
## 1. Zatrzymuje timer przetrwania (jeśli istnieje).
## 2. Reparentuje dźwięk jumpscare'a do kamery gracza.
## 3. Wibruje kontrolerami (jeśli XRToolsRumbleManager jest dostępny).
## 4. Odtwarza dźwięk i czeka, po czym ładuje Menu Główne.
static func execute(
	caller: Node,
	jumpscare_sound: AudioStreamPlayer3D,
	extra_nodes_to_reparent: Array[Node3D] = []
) -> void:
	if is_jumpscaring_global:
		return
	is_jumpscaring_global = true
	
	# 1. Zatrzymanie timera
	var game_map = caller.get_tree().current_scene
	if game_map and game_map.has_method("stop_timer_and_save"):
		game_map.stop_timer_and_save()

	# 2. Znalezienie kamery gracza
	var player_root = caller.get_tree().get_first_node_in_group("player")
	if player_root == null:
		# Fallback — nie znaleziono gracza, ale kontynuujemy
		await caller.get_tree().create_timer(2.0).timeout
		SceneLoader.load_scene(MAIN_MENU_PATH)
		return
		
	var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
	if camera == null:
		await caller.get_tree().create_timer(2.0).timeout
		SceneLoader.load_scene(MAIN_MENU_PATH)
		return

	# 3. Reparenting dźwięku jumpscare'a do kamery
	var target_transform = Transform3D()
	target_transform.origin = Vector3(0, -0.3, -0.5)
	
	if jumpscare_sound and jumpscare_sound.get_parent():
		var audio_trans = jumpscare_sound.global_transform
		jumpscare_sound.get_parent().remove_child(jumpscare_sound)
		camera.add_child(jumpscare_sound)
		jumpscare_sound.global_transform = audio_trans
		
		var tween = caller.get_tree().create_tween()
		tween.tween_property(jumpscare_sound, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)

	# 4. Reparenting dodatkowych węzłów (np. MeshInstance3D Balory)
	for node in extra_nodes_to_reparent:
		if node and node.get_parent():
			var node_trans = node.global_transform
			node.get_parent().remove_child(node)
			camera.add_child(node)
			node.global_transform = node_trans
			
			var tween2 = caller.get_tree().create_tween()
			tween2.tween_property(node, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
	
	# 5. Wibracje haptyczne obu kontrolerów
	_trigger_rumble(caller)

	# 6. Odtworzenie dźwięku
	if jumpscare_sound:
		jumpscare_sound.play()

	# 7. Czekamy na zakończenie sekwencji i wracamy do menu
	await caller.get_tree().create_timer(2.0).timeout
	SceneLoader.load_scene(MAIN_MENU_PATH)


static func _trigger_rumble(caller: Node) -> void:
	# Próba użycia XRToolsRumbleManager (jest w Autoload)
	var left = caller.get_viewport().find_world_3d()
	# Szukamy kontrolerów XR
	var controllers = caller.get_tree().get_nodes_in_group("player")
	if controllers.size() == 0:
		return
	var player_root = controllers[0]
	var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
	var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
	
	if left_hand and left_hand is XRController3D:
		XRServer.get_tracker(left_hand.tracker).set_input("haptic", Vector2(1.0, 0.5))
	if right_hand and right_hand is XRController3D:
		XRServer.get_tracker(right_hand.tracker).set_input("haptic", Vector2(1.0, 0.5))
