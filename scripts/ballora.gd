extends Area3D

const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

func _ready():
	# Połączenie sygnału wejścia w obszar przeciwnika
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	# Sprawdzamy czy ciało to ciało gracza VR
	if "PlayerBody" in body.name or body.is_in_group("player"):
		print("Balora złapała gracza! Wyrzucanie do menu...")
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
