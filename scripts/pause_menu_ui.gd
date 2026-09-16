extends Control

signal resume_requested
signal restart_requested
signal main_menu_requested

@onready var resume_btn: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeBtn
@onready var restart_btn: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RestartBtn
@onready var menu_btn: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/MenuBtn

var _navigator: VRUINavigator

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_setup_accessibility()
	_navigator = VRUINavigator.new()
	_navigator.name = "VRUINavigator"
	_navigator.root_control = self
	_navigator.enabled = false
	add_child(_navigator)
	visible = false

func set_active(active: bool) -> void:
	visible = active
	if _navigator:
		_navigator.enabled = active
		if active:
			_navigator.refresh_buttons()

func _setup_accessibility() -> void:
	if TTSManager:
		TTSManager.setup_button(resume_btn, "Resume Game")
		TTSManager.setup_button(restart_btn, "Restart Map")
		TTSManager.setup_button(menu_btn, "Return to Main Menu")

func _on_resume_pressed() -> void:
	resume_requested.emit()

func _on_restart_pressed() -> void:
	restart_requested.emit()

func _on_menu_pressed() -> void:
	main_menu_requested.emit()
