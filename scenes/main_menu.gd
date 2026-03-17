@tool
extends XRToolsSceneBase


func _on_start_button_pressed():
	emit_signal("request_load_scene", "res://scenes/game_map.tscn")

func _on_exit_button_pressed():
	emit_signal("request_quit")
