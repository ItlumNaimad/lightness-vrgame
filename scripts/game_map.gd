@tool
extends XRToolsSceneBase

var time_survived: float = 0.0
var is_timer_running: bool = false
var next_milestone: int = 10

@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D


func _ready():
	if Engine.is_editor_hint():
		return

	if timer_label == null or milestone_audio == null:
		printerr("HUD nie został zainicjowany. Sprawdzić \"Editable Children\".")
		return
	
	# Automatyczny bake NavMesh przy starcie mapy, jeśli nie został zbudowany wcześniej.
	# Zapewnia to poprawną nawigację AI (Balora) nawet po modyfikacji geometrii sceny.
	if nav_region and nav_region.navigation_mesh:
		nav_region.bake_navigation_mesh()
	
	# Reset stanu przy starcie mapy (każda scena jest samowystarczalna).
	time_survived = 0.0
	next_milestone = 10
	is_timer_running = true
	
func _process(delta: float):
	if Engine.is_editor_hint() or not is_timer_running:
		return
	
	# 1. Akumulacja czasu
	time_survived += delta
	
	#2. Formatowanie matematyczne (minuty:sekundy)
	var total_seconds: int = int(time_survived)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	if timer_label:
		timer_label.text = "%02d:%02d" % [minutes, seconds]

	# 3. Sprawdzanie progów 10 sekundowych
	if time_survived >= next_milestone:
		_trigger_milestone_event()
		
func _trigger_milestone_event():
	# Przesuwamy próg o kolejne 10 sekund
	next_milestone += 10
	# Odtworzenie sygnału dźwiękowego bezpośrednio przy uchu gracza
	if milestone_audio and not milestone_audio.playing:
		milestone_audio.play()
		
	# W tym miejscu w przyszłości możesz dodać wywołanie zmian w logice AI
	print("Osiągnięto próg! Aktualny próg uciekł na: ", next_milestone)
	
func stop_timer_and_save():
	is_timer_running = false
	# Zapisanie wyniku do pamięci
	SceneLoader.last_survival_time = time_survived
