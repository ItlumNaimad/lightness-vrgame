extends Node

var last_survival_time: float = 0.0
var last_death_reason: String = "Nieznane zagrożenie"
var steps_taken: int = 0
var marionettes_defended: int = 0
var foxy_charges_blocked: int = 0
var scene_path: String
var is_loading: bool = false

func reset_session_stats():
	last_survival_time = 0.0
	last_death_reason = "Nieznane zagrożenie"
	steps_taken = 0
	marionettes_defended = 0
	foxy_charges_blocked = 0

func load_scene(path: String):
	# Blokada wielokrotnego wywołania (zapobiega podwójnemu ładowaniu)
	if is_loading:
		return
	is_loading = true
	
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
		
		# 3. Zastąpienie całego aktywnego środowiska
		get_tree().change_scene_to_packed(loaded_resource)
		
		# Reset flagi — nowa scena może z powrotem ładować inne sceny
		is_loading = false
		if ClassDB.class_exists("JumpscareHelper") or true:
			# Klasy GDScript są globalnie widoczne, po prostu ustawiamy
			JumpscareHelper.is_jumpscaring_global = false
		
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
