Przeniesienie architektury z podejścia "Staging" (film drugi: StayAtHomeDev) na bezpośrednią podmianę całej sceny z ładowaniem w tle (film pierwszy: Queble) jest najwłaściwszym rozwiązaniem problemu. 

Architektura "Staging", gdzie gracz wisi globalnie w nadrzędnym węźle, a mapy są ładowane pod nim, powoduje krytyczne problemy w środowisku VR. Wtyczka Godot XR Tools w momencie wymuszonej teleportacji (`PlayerBody.teleport`) na dynamicznie ładowaną fizykę generuje błędy rozdzielczości kolizji (penetration resolution). Kolizja nie nadąża za trackingiem gogli, co kończy się wyrzuceniem gracza poza granice świata. 

Dodatkowo, podejście z wymianą całej sceny zdejmuje z Ciebie konieczność ręcznego resetowania modyfikatorów gracza (takich jak blokada ruchu po jumpscare). Załadowanie nowej sceny zresetuje całe drzewo postaci do stanu początkowego.

Przejdźmy przez całkowitą przebudowę systemu.

### Krok 1: Zmiana paradygmatu drzewa (Usunięcie węzła Main)

Scena `main.tscn` nie jest już potrzebna i należy z niej zrezygnować. Od teraz każda mapa to w pełni niezależne środowisko.

1. Otwórz `main_menu.tscn`.
2. Wrzuć bezpośrednio do niego węzły, które były w Main:
   * **`StartXR`** (z folderu `addons/godot-xr-tools/xr/start_xr.tscn`)
   * **`Player`** (Twoja zaktualizowana postać)
   * **`Fade`** (z folderu `addons/godot-xr-tools/effects/fade.tscn`)
3. **Usuń `Marker3D` (PlayerSpawn).** W modelu z pierwszego poradnika nie ma już teleportacji. Przesuń węzeł `Player` fizycznie w edytorze dokładnie w to miejsce na podłodze, gdzie gracz ma stać. Silnik zainicjuje jego fizykę naturalnie na podstawie fizycznej pozycji gogli względem ustawionego miejsca startowego.
4. Tę samą strukturę (StartXR, Player, Fade) zduplikuj dla `game_map.tscn`.

### Krok 2: Utworzenie menedżera `SceneLoader.gd` (Wzorowane na Queble)

Tworzymy globalny skrypt operujący na wątkach, który wygasza ekran w VR, wymienia całą scenę (`change_scene_to_packed`) i ponownie rozjaśnia ekran.

1. Utwórz nowy plik w folderze `scripts` o nazwie `scene_loader.gd`.
2. Wklej do niego poniższy kod (zaadaptowana logika z wideo pod wymogi VR):

```gdscript
extends Node

var scene_path: String

func load_scene(path: String):
	scene_path = path
	
	# 1. Wywołanie animacji ściemnienia na globalnym komponencie XR
	_set_fade(1.0, 0.5)
	await get_tree().create_timer(0.6).timeout
	
	# 2. Ładowanie w tle bez blokowania wątku głównego gogli (minimalizuje chorobę lokomocyjną)
	ResourceLoader.load_threaded_request(scene_path)
	set_process(true)

func _ready():
	set_process(false)

func _process(_delta):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		set_process(false)
		printerr("Błąd ładowania sceny: ", scene_path)
		
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		var loaded_resource = ResourceLoader.load_threaded_get(scene_path)
		
		# 3. Zastąpienie całego aktywnego środowiska (mechanika z Queble)
		get_tree().change_scene_to_packed(loaded_resource)
		
		# 4. Opóźnienie wywołania rozjaśnienia (czekamy na reinicjalizację nowej sceny)
		call_deferred("_fade_in")

func _fade_in():
	_set_fade(0.0, 0.5)

func _set_fade(target_alpha: float, duration: float):
	if ClassDB.class_exists("XRToolsFade"):
		# Ustalenie początkowej wartości alpha (0.0 to przezroczysty, 1.0 to czarny)
		var current_alpha = 1.0 if target_alpha == 0.0 else 0.0
		var tween = get_tree().create_tween()
		tween.tween_method(_apply_fade_color, Color(0, 0, 0, current_alpha), Color(0, 0, 0, target_alpha), duration)

func _apply_fade_color(color: Color):
	if ClassDB.class_exists("XRToolsFade"):
		XRToolsFade.set_fade("scene_transition", color)
```

3. Wejdź w ustawienia projektu: **Project -> Project Settings -> Autoload** i dodaj skrypt `scene_loader.gd`, nazywając węzeł globalny `SceneLoader`. 
4. W zakładce **Application -> Run** zmień "Main Scene" z `main.tscn` na `main_menu.tscn`.

### Krok 3: Sterowanie i wywoływanie ładowania

Z racji usunięcia nadrzędnego zarządcy, wywoływanie ładowania nowej sceny staje się jedno-linijkowe. Zaktualizuj plik `main_menu.gd`:

```gdscript
@tool
extends XRToolsSceneBase

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	# Zablokowanie ruchu kontrolerem specjalnie i tylko dla sceny menu
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		if "enabled" in p:
			p.enabled = false
			
	var viewport_2d = $Viewport2Din3D
	if viewport_2d:
		if not viewport_2d.is_node_ready():
			await viewport_2d.ready
		var ui = viewport_2d.get_scene_instance()
		if ui:
			ui.start_pressed.connect(_on_start_pressed)
			ui.exit_pressed.connect(_on_exit_pressed)
			ui.settings_pressed.connect(_on_settings_pressed)

func _on_start_pressed():
	# Nowe wezwanie do przeładowania sceny bez telemetrii i błędu spadania
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	print("Settings not implemented yet")
```

Po wejściu do `game_map.tscn` gracz zespawnuje się ze świeżo przeładowanymi obiektami `MovementDirect` i `MovementTurn`, które domyślnie mają ustawione `enabled = true`. Problem przenoszenia blokad i błędów fizyki pomiędzy scenami zostaje w ten sposób całkowicie odcięty.


http://googleusercontent.com/youtube_content/17
 

http://googleusercontent.com/youtube_content/18