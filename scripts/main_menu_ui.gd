@tool
extends Control

signal start_pressed
signal settings_pressed
signal exit_pressed

func _on_start_button_pressed():
	start_pressed.emit()

func _on_settings_button_pressed():
	settings_pressed.emit()

func _on_exit_button_pressed():
	exit_pressed.emit()
