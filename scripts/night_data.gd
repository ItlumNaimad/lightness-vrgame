class_name NightData
extends Resource

## NightData — Zasób konfiguracji pojedynczego poziomu / nocy.
## Umożliwia w pełni modularne tworzenie i strojenie parametrów nocy
## w Inspektorze silnika Godot oraz łatwe dodawanie nowych trybów (np. Endless).

@export var night_index: int = 1
@export var title: String = "Night 1: First Contact"
@export_multiline var description: String = "Survive 30 seconds."
@export var duration: float = 30.0 # Sekundy. Jeśli <= 0.0 lub is_endless to tryb bez limitu czasu.
@export var is_endless: bool = false

@export_group("Balora")
@export var has_balora: bool = true
@export var balora_base_speed: float = 1.2
@export var balora_speed_step: float = 0.08 # Przyrost prędkości patrolu/alertu co 10s (milestone)
@export var balora_max_speed: float = 2.8
@export var balora_alert_distance: float = 7.5
@export var balora_critical_distance: float = 3.5
@export var balora_detection_step: float = 0.4 # Zwiększenie obszaru wykrywania co 10s

@export_group("Marionette")
@export var has_marionette: bool = false
@export var marionette_interval_min: float = 14.0
@export var marionette_interval_max: float = 22.0
@export var marionette_interval_step: float = 1.0 # Skracanie przerw między szeptami co 10s
@export var allow_sequential_whispers: bool = false # Czy pod koniec nocy mogą występować serie szeptów

@export_group("Foxy")
@export var has_foxy: bool = false
@export var foxy_count: int = 1 # 1 lub 2 łowców
@export var foxy_initial_threshold: float = 24.0 # Wyjściowy próg hałasu
@export var foxy_threshold_step: float = 1.5 # Obniżanie progu co 10s (coraz większa wrażliwość na hałas)
@export var foxy_min_threshold: float = 8.0 # Minimalny próg
@export var foxy_charge_speed: float = 12.0

@export_group("Phantom Grasp")
@export var has_phantom_grasp: bool = false
@export var phantom_grasp_interval_min: float = 25.0
@export var phantom_grasp_interval_max: float = 40.0
@export var phantom_grasp_interval_step: float = 1.5
