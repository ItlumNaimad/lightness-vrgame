@tool
extends Control

signal restart_pressed
signal menu_pressed

@onready var time_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TimeBadge/TimeSurvivedValue
@onready var steps_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/StepsValue
@onready var marionettes_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/MarionetteValue
@onready var foxy_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/FoxyValue
@onready var reason_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ReasonBadge/DeathReasonValue

func _ready() -> void:
	_update_stats()

func _update_stats() -> void:
	var total_seconds: int = int(SceneLoader.last_survival_time)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	
	if time_label:
		time_label.text = "%02d:%02d" % [minutes, seconds]
	if steps_label:
		steps_label.text = "%d" % SceneLoader.steps_taken
	if marionettes_label:
		marionettes_label.text = "%d" % SceneLoader.marionettes_defended
	if foxy_label:
		foxy_label.text = "%d" % SceneLoader.foxy_charges_blocked
	if reason_label:
		reason_label.text = SceneLoader.last_death_reason

func _on_restart_button_pressed() -> void:
	restart_pressed.emit()

func _on_menu_button_pressed() -> void:
	menu_pressed.emit()
