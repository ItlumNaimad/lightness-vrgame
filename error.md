E 0:00:29:045   player_body.gd:263 @ _update_enabled(): Can't change this state while flushing queries. Use call_deferred() or set_deferred() to change monitoring state instead.
  <Błąd C++>    Condition "body->get_space() && flushing_queries" is true.
  <Źródło C++>  modules/godot_physics_3d/godot_physics_server_3d.cpp:540 @ body_set_shape_disabled()
  <Ślad stosu>  player_body.gd:263 @ _update_enabled()
                player_body.gd:258 @ set_enabled()
                ballora.gd:26 @ _trigger_jumpscare()
                ballora.gd:21 @ _on_body_entered()

W 0:00:06:115   _process_picking: Object picking can't be used when stereo rendering, this will be turned off!
  <Źródło C++>  scene/main/viewport.cpp:771 @ _process_picking()

W 0:00:23:699   GDScript::reload: Integer division. Decimal part will be discarded.
  <Błąd GDScript>INTEGER_DIVISION
  <Źródło GDScript>game_map.gd:29 @ GDScript::reload()
