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

---

## Rozwiązanie (Status: Naprawione 2026-09-16)

1. **Crash OpenXR (`XR_ERROR_CALL_ORDER_INVALID`) & `Trying to assign value of type 'Node' to 'Node3D'`:**
   - **Przyczyna:** W pliku `scenes/pause_menu.tscn` zasób `Viewport2Din3D` miał przypisany błędny UID `uid://clc5dre31iskm`, który faktycznie należał do sceny `res://addons/godot-xr-tools/xr/start_xr.tscn`. W efekcie zamiast trójwymiarowego panelu UI (`Node3D`) zainstancjonował się węzeł `StartXR` (typ `Node`), co wywołało błąd rzutowania na `Node3D` oraz podwójną, równoległą konfigurację OpenXR (`OpenXR: Configuring interface` x 2), łamiąc pętlę renderowania klatek VR.
   - **Rozwiązanie:** W `scenes/pause_menu.tscn` wstawiono poprawny UID `uid://clujaf3u776a3` dla `viewport_2d_in_3d.tscn` oraz właściwy UID dla `scripts/pause_menu.gd` (`uid://bcr15wxo5bwsm`).

2. **Błąd parsowania `Identifier "delta" not declared in current scope` w `game_map.gd`:**
   - **Przyczyna:** W `game_map.gd:94` funkcja `_update_threat_pacing()` była wywoływana i zdefiniowana bez parametru `delta`, podczas gdy wewnątrz używano zmiennej `delta`. Uniemożliwiło to załadowanie skryptu mapy.
   - **Rozwiązanie:** Dodano parametr `delta: float` do deklaracji `_update_threat_pacing(delta: float)` oraz przekazano `delta` z pętli `_process(delta)`.

3. **Ostrzeżenie `SHADOWED_VARIABLE` w `player_audio_manager.gd`:**
   - **Przyczyna:** W funkcji `_trigger_collision_rumble()` zadeklarowano lokalne zmienne `var left_ctrl` i `var right_ctrl`, które przesłaniały istniejące pola klasy.
   - **Rozwiązanie:** Usunięto lokalną redeklarację `var` i wykorzystano istniejące zmienne instancyjne klasy.

4. **Nieprawidłowe UID-y (`invalid UID: uid://..._01`):**
   - **Rozwiązanie:** Podmieniono fikcyjne identyfikatory UID w `scenes/pause_menu.tscn`, `scenes/pause_menu_ui.tscn`, `scenes/phantom_grasp.tscn` i `scenes/game_map.tscn` na rzeczywiste UID skryptów.


Błędy po naprawie:
## Debuger:
	E 0:02:34:166   PlayerAudioManager._physics_process: Invalid cast: could not convert value to 'Vector3'.
  <Źródło GDScript>player_audio_manager.gd:57 @ PlayerAudioManager._physics_process()
  <Ślad stosu>  player_audio_manager.gd:57 @ _physics_process()
W 0:02:33:757   movement_footstep.gd:222 @ _play_sound(): XRToolsMovementFootstep idle audio pool empty
  <Źródło C++>  core/variant/variant_utility.cpp:1033 @ push_warning()
  <Ślad stosu>  movement_footstep.gd:222 @ _play_sound()
                movement_footstep.gd:204 @ _play_step_sound()
                movement_footstep.gd:129 @ physics_movement()
                player_body.gd:348 @ _physics_process()
W 0:00:29:305   set_navigation_mesh: A navigation mesh that uses a `cell_height` of 0.15000000596046 was assigned to a navigation map set to a larger `cell_height` of 0.25.
This mismatch in cell height can cause rasterization errors with navigation mesh edges on the navigation map.
The cell height for navigation maps can be changed by using the NavigationServer map_set_cell_height() function.
The cell height for default navigation maps can also be changed in the project settings.
This warning can be toggled under 'navigation/3d/warnings/navmesh_cell_size_mismatch' in the project settings.
  <Źródło C++>  modules/navigation_3d/nav_region_3d.cpp:113 @ set_navigation_mesh()
W 0:00:29:305   set_navigation_mesh: A navigation mesh that uses a `cell_size` of 0.15000000596046 was assigned to a navigation map set to a larger `cell_size` of 0.25.
This mismatch in cell size can cause rasterization errors with navigation mesh edges on the navigation map.
The cell size for navigation maps can be changed by using the NavigationServer map_set_cell_size() function.
The cell size for default navigation maps can also be changed in the project settings.
This warning can be toggled under 'navigation/3d/warnings/navmesh_cell_size_mismatch' in the project settings.
  <Źródło C++>  modules/navigation_3d/nav_region_3d.cpp:110 @ set_navigation_mesh()
W 0:00:29:258   generator_bake_from_source_geometry_data: Property agent_radius is ceiled to cell_size voxel units and loses precision.
  <Źródło C++>  modules/navigation_3d/3d/nav_mesh_generator_3d.cpp:373 @ generator_bake_from_source_geometry_data()
W 0:00:29:258   generator_bake_from_source_geometry_data: Property agent_max_climb is floored to cell_height voxel units and loses precision.
  <Źródło C++>  modules/navigation_3d/3d/nav_mesh_generator_3d.cpp:370 @ generator_bake_from_source_geometry_data()
W 0:00:29:258   generator_bake_from_source_geometry_data: Property agent_height is ceiled to cell_height voxel units and loses precision.
  <Źródło C++>  modules/navigation_3d/3d/nav_mesh_generator_3d.cpp:367 @ generator_bake_from_source_geometry_data()
W 0:00:29:253   game_map.gd:77 @ _deferred_bake_navmesh(): Source geometry parsing for navigation mesh baking had to parse RenderingServer meshes at runtime.
		This poses a significant performance issues as visual meshes store geometry data on the GPU and transferring this data back to the CPU blocks the rendering.
		For runtime (re)baking navigation meshes use and parse collision shapes as source geometry or create geometry data procedurally in scripts.
  <Źródło C++>  scene/resources/3d/navigation_mesh_source_geometry_data_3d.cpp:205 @ add_mesh()
  <Ślad stosu>  game_map.gd:77 @ _deferred_bake_navmesh()
W 0:00:28:970   GDScript::reload: The base class script has the "@tool" annotation, but this script does not have it.
  <Błąd GDScript>MISSING_TOOL
  <Źródło GDScript>game_map.gd:1 @ GDScript::reload()

---

## Rozwiązanie (Status: Naprawione 2026-09-16 - Sesja 2)

1. **Crash przy kontakcie ze ścianą (`Invalid cast: could not convert value to 'Vector3'` w `player_audio_manager.gd:57`):**
   - **Przyczyna:** W skrypcie `XRToolsPlayerBody` (`addons/godot-xr-tools/player/player_body.gd`) właściwość `ground_control_velocity` jest wektorem dwuwymiarowym (`Vector2`), reprezentującym wejście gałki/ruchu w płaszczyźnie poziomej. W `player_audio_manager.gd:57` zastosowano jawne rzutowanie `(player_body.ground_control_velocity as Vector3)`, co przy kontakcie ze ścianą rzucało wyjątek silnika i natychmiast crashowało grę.
   - **Rozwiązanie:** Zastąpiono sztywne rzutowanie bezpiecznym sprawdzeniem typu wektora (`if gcv is Vector2 or gcv is Vector3`) i bezpośrednim odczytem `.length() > 0.4`, co całkowicie zapobiega rzucaniu wyjątków typowania.

2. **Ostrzeżenie `MISSING_TOOL` w `game_map.gd:1`:**
   - **Przyczyna:** Klasa bazowa `XRToolsSceneBase` posiada adnotację `@tool`. W Godot 4 dziedziczenie ze skryptu tool wymaga, aby klasa potomna również posiadała adnotację `@tool`.
   - **Rozwiązanie:** Dodano `@tool` na początku `scripts/game_map.gd` wraz ze strażnikiem `if Engine.is_editor_hint(): return` w metodach `_ready()` oraz `_process()`, co zabezpiecza przed przypadkowym wykonywaniem logiki gry w widoku edytora.

3. **Ostrzeżenia NavMesh (`cell_size`/`cell_height` mismatch, precision loss i parsowanie siatek GPU):**
   - **Przyczyna:** `NavigationMesh` w `scenes/game_map.tscn` miało `cell_size = 0.15` i `cell_height = 0.15` (niezgodne z domyślną mapą `0.25`), nieoptymalne wymiary agenta oraz domyślne parsowanie siatek renderera (`PARSED_GEOMETRY_MESH_INSTANCES`), co przy pieczeniu w runtime (`bake_navigation_mesh()`) blokowało transfer danych z GPU na CPU.
   - **Rozwiązanie:** W `scenes/game_map.tscn` zmieniono `cell_size` i `cell_height` na `0.25`, wymiary agenta na wielokrotności siatki (`agent_radius = 0.75`, `agent_height = 2.75`) oraz włączono `geometry_parsed_geometry_type = 1` (`PARSED_GEOMETRY_STATIC_COLLIDERS`), dzięki czemu NavMesh parsuje kształty kolizyjne `StaticBody3D` bezpośrednio na CPU bez angażowania GPU.

4. **Ostrzeżenie `XRToolsMovementFootstep idle audio pool empty`:**
   - **Przyczyna:** Pula odtwarzaczy kroków w `movement_footstep.gd` miała rozmiar zaledwie 3 (`AUDIO_POOL_SIZE = 3`). Przy szybszym marszu lub biegu wszystkie 3 instancje wciąż odtwarzały próbkę, wyczerpując pulę i pomijając odtwarzanie kolejnych kroków.
   - **Rozwiązanie:** Zwiększono `AUDIO_POOL_SIZE` do 8 oraz dodano płynny recykling najstarszego grającego odtwarzacza w razie chwilowego wyczerpania puli, co gwarantuje ciągłość kroków audio.

## Nowy Error z Debuga
E 0:00:04:747   VRUINavigator._gather_buttons: Invalid call. Nonexistent function 'is_visible_in_tree' in base 'Node (VRUINavigator)'.
  <Źródło GDScript>vr_ui_navigator.gd:54 @ VRUINavigator._gather_buttons()
  <Ślad stosu>  vr_ui_navigator.gd:54 @ _gather_buttons()
                vr_ui_navigator.gd:59 @ _gather_buttons()
                vr_ui_navigator.gd:39 @ refresh_buttons()
                vr_ui_navigator.gd:26 @ _ready()
                main_menu_ui.gd:70 @ _ready()
                viewport_2d_in_3d.gd:549 @ _update_render()
                viewport_2d_in_3d.gd:146 @ _ready()

---

## Rozwiązanie (Status: Naprawione 2026-09-16 - Sesja 3)

1. **Błąd wywołania `Invalid call. Nonexistent function 'is_visible_in_tree' in base 'Node (VRUINavigator)'` w `vr_ui_navigator.gd:54`:**
   - **Przyczyna:** Komponent `VRUINavigator` dziedziczy bezpośrednio po klasie bazowej `Node` i został dodany jako dziecko węzła UI (`main_menu_ui.gd`). Funkcja `_gather_buttons()` rekurencyjnie przeszukuje drzewo kontrolek w poszukiwaniu przycisków i wywoływała `node.is_visible_in_tree()`. Metoda ta istnieje wyłącznie w klasach dziedziczących po `CanvasItem` (elementy 2D/UI) oraz `Node3D` (elementy 3D), a nie istnieje w bazowym typie `Node`. Wejście pętli w węzeł `VRUINavigator` rzucało błąd w runtime.
   - **Rozwiązanie:** W `scripts/vr_ui_navigator.gd` dodano warunki sprawdzające typ węzła przed odpytaniem o widoczność (`if node is CanvasItem`, `elif node is Node3D`). Węzły bazowe `Node` są bezpiecznie pomijane, a przyciski `Button` są dodawane do nawigacji wyłącznie, jeśli są widoczne w drzewie.

