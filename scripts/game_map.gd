@tool
extends XRToolsSceneBase

# Nadpisujemy funkcję z klasy bazowej, aby uniknąć szukania $XROrigin3D/XRCamera3D wewnątrz mapy.
# Gracz jest zarządzany globalnie przez Staging.
func scene_loaded(_user_data = null):
	# Zamiast szukać węzła wewnątrz mapy, nic nie robimy lub aktywujemy kamerę w Staging
	# Staging sam zajmie się kamerą, jeśli jest poprawnie skonfigurowany.
	pass
