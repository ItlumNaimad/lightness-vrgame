## Consola
```
  ERROR: scene/gui/text_edit.cpp:6981 - Index p_gutter = -1 is out of bounds (gutters.size() = 4).
  ERROR: scene/gui/text_edit.cpp:6981 - Index p_gutter = -1 is out of bounds (gutters.size() = 4).
  ERROR: scene/gui/text_edit.cpp:6981 - Index p_gutter = -1 is out of bounds (gutters.size() = 4).
Godot Engine v4.7.2.stable.steam.ed1daf0bf - https://godotengine.org
OpenXR: Created instance for OpenXR 1.0.54
OpenXR: Running on OpenXR runtime:  SteamVR/OpenXR   2.17.9
OpenXR: XrGraphicsRequirementsVulkan2KHR:
 - minApiVersionSupported:  1.0.0
 - maxApiVersionSupported:  1.2.0
Vulkan 1.4.325 - Forward Mobile - Using Device #0: NVIDIA - NVIDIA GeForce RTX 3070

[MainMenuUI] Switching to panel: main
OpenXR: Configuring interface
[MainMenu] Scene loaded. Connecting UI signals...
OpenXR: Session begun
StartXR: Refresh rate reported as 119.999992370605
StartXR: Target supports only one refresh rate
StartXR: Setting physics rate to 120
[MainMenu] Found UI instance: MainMenuUI
[MainMenu] start_pressed CONNECTED!
[MainMenu] exit_pressed CONNECTED!
OpenXR: XR started (focused_state)
[HoldButton] ACTIVATED: SettingsButton | text: settings
[MainMenuUI] Settings button pressed! Calling _show_panel('settings')
[MainMenuUI] Switching to panel: settings
[HoldButton] ACTIVATED: TTSToggleBtn | text: TTS Voice: OFF
[MainMenuUI] Switching to panel: main
[HoldButton] ACTIVATED: GuideButton | text: guide
[MainMenuUI] Switching to panel: guide
[HoldButton] ACTIVATED: BackFromGuideButton | text: ⮌ BACK TO MENU
[MainMenuUI] Switching to panel: main
[MainMenuUI] Start button pressed! Emitting start_pressed...
[MainMenu] _on_start_pressed called! Loading game map...
OpenXR: Configuring interface
Balora: Wznowiono patrol.
OpenXR: Configuring interface
OpenXR: failed to begin frame [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to end frame! [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to begin frame [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to end frame! [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to begin frame [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to end frame! [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to begin frame [ XR_ERROR_CALL_ORDER_INVALID ]
OpenXR: failed to end frame! [ XR_ERROR_CALL_ORDER_INVALID ]
```
## Debuger:
	Trying to assign value of type 'Node' to a variable of type 'Node3D'.
	
	W 0:00:05:627   GDScript::reload: The local variable "left_ctrl" is shadowing an already-declared variable at line 18 in the current class.
  <Błąd GDScript>SHADOWED_VARIABLE
  <Źródło GDScript>player_audio_manager.gd:128 @ GDScript::reload()
W 0:00:05:627   GDScript::reload: The local variable "right_ctrl" is shadowing an already-declared variable at line 19 in the current class.
  <Błąd GDScript>SHADOWED_VARIABLE
  <Źródło GDScript>player_audio_manager.gd:129 @ GDScript::reload()
W 0:00:06:341   _process_picking: Object picking can't be used when stereo rendering, this will be turned off!
  <Źródło C++>  scene/main/viewport.cpp:801 @ _process_picking()
E 0:00:39:900   GDScript::reload: Parse Error: Identifier "delta" not declared in the current scope.
  <Źródło GDScript>game_map.gd:130 @ GDScript::reload()
E 0:00:39:900   GDScript::reload: Parse Error: Identifier "delta" not declared in the current scope.
  <Źródło GDScript>game_map.gd:135 @ GDScript::reload()
E 0:00:39:901   load: Failed to load script "res://scripts/game_map.gd" with error "Parse error".
  <Źródło C++>  modules/gdscript/gdscript_resource_format.cpp:46 @ load()
W 0:00:40:049   load: res://scenes/phantom_grasp.tscn:3 - ext_resource, invalid UID: uid://phantom_grasp_script_01 - using text path instead: res://scripts/phantom_grasp.gd
  <Źródło C++>  scene/resources/resource_format_text.cpp:501 @ load()
W 0:00:40:054   load: res://scenes/pause_menu.tscn:3 - ext_resource, invalid UID: uid://pause_menu_controller_script_01 - using text path instead: res://scripts/pause_menu.gd
  <Źródło C++>  scene/resources/resource_format_text.cpp:501 @ load()
W 0:00:40:061   load: res://scenes/pause_menu_ui.tscn:3 - ext_resource, invalid UID: uid://pause_menu_ui_script_01 - using text path instead: res://scripts/pause_menu_ui.gd
  <Źródło C++>  scene/resources/resource_format_text.cpp:501 @ load()
W 0:00:40:064   load: res://scenes/pause_menu_ui.tscn:4 - ext_resource, invalid UID: uid://hold_button_script_01 - using text path instead: res://scripts/hold_button.gd
  <Źródło C++>  scene/resources/resource_format_text.cpp:501 @ load()
E 0:00:40:224   @implicit_ready: Trying to assign value of type 'Node' to a variable of type 'Node3D'.
  <Źródło GDScript>pause_menu.gd:3 @ @implicit_ready()
  <Ślad stosu>  pause_menu.gd:3 @ @implicit_ready()
