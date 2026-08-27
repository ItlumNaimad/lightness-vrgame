---
name: godot-xr-vr-development
description: >-
  Kompendium wiedzy i wzorców wynikających z wielomiesięcznego rozwoju gry VR
  w Godot 4.x z użyciem XR Tools i GDScript. Zawiera sprawdzone rozwiązania
  problemów z fizyką XR, zarządzaniem scenami, audio 3D, haptycznym feedbackiem,
  kolizjami, nawigacją AI oraz edycją plików .tscn z poziomu agenta AI.
  Aktywuj ten skill przy KAŻDYM zadaniu dotyczącym: Godot 4.x, XR/VR, GDScript,
  XR Tools, plików .tscn, audio 3D, nawigacji NavMesh, AI przeciwników.
---

# Godot 4.x + XR Tools — Podręcznik Wzorców i Pułapek

> Ten skill powstał na bazie rzeczywistych problemów napotkanych podczas rozwoju
> gry **Lightness VR** (survival horror w pełni dostępny dla osób niewidomych).
> Każda reguła odwołuje się do konkretnego incydentu i jego rozwiązania.

---

## 1. ZARZĄDZANIE SCENAMI W VR (KRYTYCZNE)

### 1.1 Samowystarczalne sceny — jedyny bezpieczny wzorzec

**Problem (napotkany):** Podejście "Staging" (persistentny gracz w `main.tscn`
z dynamicznym ładowaniem podscen) powodowało błędy fizyki XR i niestabilne
kolizje po przeładowaniu mapy.

**Rozwiązanie:** Każda scena (`main_menu.tscn`, `game_map.tscn`) MUSI zawierać
kompletne, własne instancje:
- `StartXR` (inicjalizacja OpenXR)
- `Player` (z kamerą i kontrolerami)
- `Fade` (efekt przejścia)

```gdscript
# DOBRZE — pełna podmiana scen
SceneLoader.load_scene("res://scenes/game_map.tscn")
# → wewnętrznie: get_tree().change_scene_to_packed(loaded_resource)

# ŹLE — ładowanie podsceny do istniejącej
# var sub = load("res://scenes/game_map.tscn").instantiate()
# main_node.add_child(sub)  # ← fizyka XR się rozjedzie!
```

### 1.2 Asynchroniczne ładowanie scen (obowiązkowe w VR)

Godot musi renderować klatki 72-120 FPS bez przerwy. Synchroniczne ładowanie
zamraża obraz w goglach, powodując chorobę lokomocyjną.

```gdscript
# Wzorzec z SceneLoader.gd (Autoload):
ResourceLoader.load_threaded_request(scene_path)
# ...poll w _process()...
var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
if status == ResourceLoader.THREAD_LOAD_LOADED:
    var res = ResourceLoader.load_threaded_get(scene_path)
    get_tree().change_scene_to_packed(res)
```

### 1.3 Ściemnianie (Fade) przy przejściach

Użyj `XRToolsFade.set_fade("scene_transition", Color(0,0,0, alpha))`.
Wywołaj fade-out PRZED ładowaniem i fade-in AFTER z `call_deferred("_fade_in")`.

---

## 2. POBIERANIE GRACZA I KAMERY (WZORZEC REFERENCYJNY)

**Problem (napotkany wielokrotnie):** Różne skrypty wrogów szukały gracza
na różne sposoby, co prowadziło do null reference crashes.

**Jedyny akceptowalny wzorzec:**

```gdscript
# W _ready() lub dedykowanej funkcji:
var player_root = get_tree().get_first_node_in_group("player")
var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")

# Zawsze z null-guardem:
if player_root == null:
    return
if camera == null:
    return
```

**Wymagane:** Węzeł `Player` MUSI być w grupie `"player"`. Sprawdź w `.tscn`:
```
[node name="Player" type="Node3D" groups=["player"]]
```

### 2.1 Ścieżki do kontrolerów

```gdscript
var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
```

---

## 3. EDYCJA PLIKÓW .tscn (NAJCZĘSTSZY BŁĄD AGENTA AI)

> [!CAUTION]
> Pliki `.tscn` to format tekstowy Godota z surową składnią. Jeden błąd
> parsowania = cała scena odmawia otwarcia. To był najczęstszy powód
> konieczności cofania zmian w tym projekcie.

### 3.1 Zasady edycji .tscn

1. **NIE dodawaj nowych `[ext_resource]` bez UID** — jeśli nie znasz UID zasobu,
   pomiń go, a Godot sam go wygeneruje przy następnym otwarciu.
   ```
   # DOBRZE (bez UID, Godot uzupełni):
   [ext_resource type="AudioStream" path="res://assets/sounds/whoosh2.mp3" id="13_whoosh"]

   # ŹLE (zmyślony UID):
   [ext_resource type="AudioStream" uid="uid://FAKE123" path="res://..." id="13"]
   ```

2. **Identyfikatory `id` w `[ext_resource]` muszą być unikalne** w obrębie pliku.
   Sprawdź istniejące ID zanim dodasz nowe.

3. **Rozszerzenia plików audio:** Zawsze weryfikuj RZECZYWISTE rozszerzenie pliku
   na dysku (`ls`, `Get-ChildItem`). Problem napotkany: plik nazywał się
   `foxy_walking.wav`, ale agent wpisał `.mp3` w `.tscn` → parse error.

4. **Nie usuwaj linii `[sub_resource]` ani `[node]`** bez pełnego zrozumienia
   hierarchii. Węzły potomne odwołują się do parentów po nazwie.

5. **Wartości `collision_layer` i `collision_mask`** są liczbami całkowitymi
   (bitmask). Warstwy to potęgi 2:
   - Layer 1 = `1`, Layer 2 = `2`, Layer 3 = `4`, Layer 18 = `131072`, Layer 20 = `524288`
   - Kombinacje: Layer 1+20 = `524289`, Layer 1+2 = `3`

### 3.2 Weryfikacja po edycji .tscn

Po każdej edycji pliku `.tscn` wykonaj:
```powershell
# Szybka walidacja — szukaj oczywistych problemów:
Select-String -Path "scenes/player.tscn" -Pattern 'ext_resource.*path="res://' | 
  ForEach-Object { $_.Line -match 'path="(.*?)"'; Test-Path $Matches[1] }
```

---

## 4. FIZYKA XR — POWTARZAJĄCE SIĘ PUŁAPKI

### 4.1 Grawitacja w CharacterBody3D

**Problem:** `velocity.y` narastał w nieskończoność po wylądowaniu, powodując
"zapadanie się" postaci przez podłogę.

```gdscript
# DOBRZE:
if not is_on_floor():
    velocity.y -= 9.8 * delta
else:
    velocity.y = 0.0  # ← KRYTYCZNE — reset po wylądowaniu

# ŹLE:
if not is_on_floor():
    velocity.y -= 9.8 * delta
# brak else → velocity.y = -0.001, -0.002, -0.003... → przenika podłogę
```

### 4.2 NavigationAgent3D — `path_desired_distance`

**Problem:** Wysoka postać (środek na ~1.3m) nigdy nie "docierała" do punktu
nawigacyjnego na podłodze (0m), bo domyślny próg `1.0m` mierzony jest w 3D.

```gdscript
# Rozwiązanie:
nav_agent.path_desired_distance = 2.0
nav_agent.target_desired_distance = 2.0
```

### 4.3 Separacja osi ruchu (X/Z vs Y)

Przy obliczaniu ruchu AI **ZAWSZE** zeruj `direction.y`:
```gdscript
var direction = (target - global_position)
direction.y = 0  # ← NIE mieszaj nawigacji poziomej z grawitacją
direction = direction.normalized()

velocity.x = direction.x * SPEED
velocity.z = direction.z * SPEED
# velocity.y kontrolowany oddzielnie przez grawitację
```

### 4.4 Warstwy kolizji — separacja wrogów

**Problem:** Foxy blokował się na Balorze, bo obaj byli na warstwie 1.

**Rozwiązanie:** Każdy typ wroga dostaje odrębną warstwę, maskę ustawioną
tylko na "World" (1):

| Obiekt | `collision_layer` | `collision_mask` | Efekt |
|--------|:-:|:-:|--------|
| Ściany/Podłoga | 1 (World) | — | — |
| PlayerBody | 524289 (1+20) | 1 | — |
| Balora | 2 | 1 | Koliduje ze ścianami, ignoruje Foxy'ego |
| Foxy | 4 | 1 | Koliduje ze ścianami, ignoruje Balorę |
| Physics Hand | 131072 (18) | — | Wykrywana przez BlockTrigger |

---

## 5. AUDIO W VR — KRYTYCZNE LEKCJE

### 5.1 Optymalizacja startu sceny (P0)

**Problem:** ~3-4 sekundy ciszy/zacięcia na starcie mapy. Przyczyna:
jednoczesna dekompresja 21 MB MP3 + 3.6 MB WAV + bake NavMesh w `_ready()`.

**Rozwiązania zastosowane:**
1. `call_deferred("_deferred_bake_navmesh")` zamiast synchronicznego bake'a
2. Wrogowie zaczynają w stanie `IDLE` (nie odtwarzają audio od klatki 0)
3. **Reguła kciuka:** OGG Vorbis do wszystkiego > 0.5s. WAV tylko dla SFX < 0.3s.
   MP3 jest dekodowany programowo w Godocie — brak przewagi nad OGG.

### 5.2 AudioStreamPlayer vs AudioStreamPlayer3D

- **`AudioStreamPlayer`** — mono, globalne, identyczne w obu uszach.
  Używaj do: ambient, muzyka, UI sounds, systemowe.
- **`AudioStreamPlayer3D`** — przestrzenne, HRTF. Używaj do: kroki wrogów,
  szepty, jumpscare'y, efekty pozycyjne.
- **Problem (napotkany):** Whoosh obrotu był `AudioStreamPlayer` (bez informacji
  kierunkowej). Gracz nie wiedział, w którą stronę się obrócił.

### 5.3 Głośność — nigdy powyżej ~5 dB

**Problem:** `volume_db = 15.0` na whooshu = przesterowanie, maskowanie wrogów.

- +15 dB to ~5.6× wzmocnienie → zniekształcenie i zagłuszenie dźwięków wrogów
- **W grze audio-only każdy dB jest krytyczny** — głośny SFX gracza maskuje
  subtelne sygnały wrogów, czyniąc grę niesprawiedliwą

### 5.4 Dynamiczne tworzenie AudioStreamPlayer (wzorzec one-shot)

```gdscript
# Wzorzec "fire and forget" na jednorazowe dźwięki:
var sfx = AudioStreamPlayer.new()  # lub AudioStreamPlayer3D
sfx.stream = preload("res://assets/sounds/nice-sfx.mp3")
sfx.volume_db = -5.0
sfx.pitch_scale = 1.2  # opcjonalne
add_child(sfx)
sfx.play()
sfx.finished.connect(sfx.queue_free)  # automatyczne sprzątanie
```

### 5.5 Efekt Distortion (proximity-based)

```gdscript
# Pitch-based distortion w _process():
var closest_dist = 999.0
for e in get_tree().get_nodes_in_group("enemy"):
    if e is Node3D:
        var d = e.global_position.distance_to(player_pos)
        if d < closest_dist:
            closest_dist = d

var target_pitch = 1.0
if closest_dist < 10.0:
    target_pitch = remap(closest_dist, 2.0, 10.0, 0.4, 1.0)
    target_pitch = clamp(target_pitch, 0.4, 1.0)

ambient_audio.pitch_scale = lerp(ambient_audio.pitch_scale, target_pitch, delta * 3.0)
```

---

## 6. WIBRACJE HAPTYCZNE (XR CONTROLLERS)

### 6.1 Poprawne API w Godot 4.x

**Problem:** Użyto `XRServer.get_tracker(hand.tracker).set_input("haptic", ...)`
— to było niepoprawne API Godot 4.x. Wibracje nie działały w ogóle.

```gdscript
# DOBRZE (Godot 4.x):
if left_hand and left_hand is XRController3D:
    left_hand.trigger_haptic_pulse(
        "haptic",   # action name
        100.0,      # frequency (Hz)
        1.0,        # amplitude (0.0 - 1.0)
        0.5,        # duration_sec
        0.0         # delay_sec
    )

# ŹLE (stare/niepoprawne API):
# XRServer.get_tracker(hand.tracker).set_input("haptic", Vector2(1.0, 0.5))
```

---

## 7. WZORCE AI PRZECIWNIKÓW (STATE MACHINE)

### 7.1 Szablon maszyny stanów

Każdy wróg w projekcie używa `enum State` + `match` w `_physics_process()`:

```gdscript
extends CharacterBody3D

enum State { IDLE, PATROL, ALERT, ATTACK, JUMPSCARE }
var current_state: State = State.IDLE
var state_timer: float = 0.0
var is_jumpscaring: bool = false  # ← globalny guard

func _physics_process(delta: float):
    if is_jumpscaring:
        return  # ← ZAWSZE na początku

    # Grawitacja (osobno od logiki stanów)
    if not is_on_floor():
        velocity.y -= 9.8 * delta
    else:
        velocity.y = 0.0

    match current_state:
        State.IDLE:
            _process_idle(delta)
        State.PATROL:
            _process_patrol(delta)
        # ...

    move_and_slide()  # ← ZAWSZE na końcu
```

### 7.2 Jumpscare — wydzielony helper (DRY)

Wielokrotne pisanie logiki jumpscare'a w każdym wrogu prowadziło do bugów
(szeptanie po pokonaniu, podwójne przeładowanie sceny). Rozwiązanie:

```gdscript
# jumpscare_helper.gd — statyczna klasa (class_name JumpscareHelper)
static var is_jumpscaring_global: bool = false  # ← globalny mutex

static func execute(caller, jumpscare_sound, extra_nodes = []):
    if is_jumpscaring_global:
        return  # ← zapobiega nakładaniu się jumpscareów
    is_jumpscaring_global = true
    # 1. Reparent audio/mesh do kamery gracza
    # 2. Trigger wibracji
    # 3. Czekaj, załaduj menu
```

### 7.3 Grupa "enemy" dla wrogów

Dodawaj wrogów do grupy `"enemy"` w `.tscn`:
```
[node name="Balora" type="CharacterBody3D" groups=["enemy"]]
```
Umożliwia to generyczne iterowanie (np. efekt distortion, kompas zagrożeń).

### 7.4 Grace Period

**Problem:** Marionette karała gracza za ruch w momencie usłyszenia szeptów —
zanim zdążył zareagować.

**Rozwiązanie:** Zmienna `grace_time` (np. 2.5-4.0s), podczas której mechanika
kary jest wyłączona, a pozycja startowa gracza jest ciągle aktualizowana.

---

## 8. XR TOOLS — KLUCZOWE KOMPONENTY I GOTCHAS

### 8.1 Hierarchia sceny gracza

```
Player (Node3D, group="player")
└── XROrigin3D
    ├── PlayerBody (XRToolsPlayerBody)
    │   └── CollisionShape3D
    ├── MovementSprint (XRToolsMovementSprint)
    ├── MovementFootstep (XRToolsMovementFootstep)
    ├── XRCamera3D
    │   ├── TimerLabel (Label3D)
    │   └── MilestoneAudio (AudioStreamPlayer3D)
    ├── left_hand (XRController3D)
    │   ├── LeftHand (physics_hand_low.tscn)
    │   ├── MovementTurn (XRToolsMovementTurn)
    │   └── FunctionGazePointer
    └── right_hand (XRController3D)
        ├── RightHand (physics_hand_low.tscn)
        ├── MovementDirect (XRToolsMovementDirect)
        └── FunctionGazePointer
```

### 8.2 Ruch kontrolerem vs kamerą

Domyślnie XR Tools kieruje ruch orientacją kamery (głowy). Dla gry typu horror,
gdzie gracz musi się rozglądać niezależnie od kierunku ruchu:

```
# player.tscn:
[node name="PlayerBody" ... instance=ExtResource("player_body")]
movement_direction = 2  # 0=Camera, 1=LeftController, 2=RightController
```

### 8.3 Physics Hands vs normalne ręce

- `left_hand_low.tscn` / `right_hand_low.tscn` — wizualne, przenikają przez ściany
- `left_physics_hand_low.tscn` / `right_physics_hand_low.tscn` — fizyczne,
  blokują się na kolizjach (warstwa 18). Wymagane do "bloku" wroga ręką.

### 8.4 FunctionGazePointer jako symulacja dotyku

Zamiast lasera (FunctionPointer), użyj `FunctionGazePointer` z krótkim zasięgiem:
```
distance = 0.15  # bardzo krótki — trzeba "dotknąć" guzika
click_on_hold = true
hold_time = 0.7  # czas przytrzymania — symulacja wciśnięcia
visible = false  # ukryj laser
```

---

## 9. WZORCE GDSCRIPT (GODOT 4.x)

### 9.1 `@onready` i typowanie

```gdscript
# DOBRZE:
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var audio: AudioStreamPlayer3D = $JumpscareSound

# ŹLE (brak typowania → utrudnia debugowanie):
@onready var nav_agent = $NavigationAgent3D
```

### 9.2 Null-guard przed każdą operacją na węźle

```gdscript
# DOBRZE:
if walk_sound:
    walk_sound.stop()
if player_root:
    var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")

# ŹLE:
walk_sound.stop()  # → crash jeśli węzeł nie istnieje
```

### 9.3 `call_deferred` dla ciężkich operacji w `_ready()`

```gdscript
# DOBRZE — nie blokuje pierwszej klatki:
func _ready():
    if nav_region and nav_region.navigation_mesh:
        call_deferred("_deferred_bake_navmesh")

func _deferred_bake_navmesh():
    nav_region.bake_navigation_mesh()

# ŹLE — blokuje rendering:
func _ready():
    nav_region.bake_navigation_mesh()  # ← zamrożenie VR na 1-3 sekundy!
```

### 9.4 `_process()` vs `_physics_process()` w VR

- **AI wrogów** → `_physics_process()` (tick-dependent, stały krok czasowy)
- **Animacje UI, HUD** → `_process()` (framerate-dependent)
- **Mieszanie jest niebezpieczne:** Marionette w `_process()` dawała różne
  prędkości reakcji przy zmiennym FPS (72-120 Hz w VR).

### 9.5 Unikanie martwego kodu debugowego

```gdscript
# ŹLE (znalezione w projekcie):
if ClassDB.class_exists("EventBus") or true:  # ← "or true" = zawsze prawda!

# DOBRZE:
var event_bus = get_node_or_null("/root/EventBus")
if event_bus:
    event_bus.noise_emitted.connect(_on_noise_emitted)
```

### 9.6 EventBus (Pub/Sub) dla komunikacji między systemami

```gdscript
# event_bus.gd (Autoload):
extends Node
signal noise_emitted(position: Vector3, noise_level: float)

# Emitowanie (z player_audio_manager.gd):
EventBus.noise_emitted.emit(origin.global_position, noise_level)

# Nasłuchiwanie (z foxy.gd):
event_bus.noise_emitted.connect(_on_noise_emitted)
```

---

## 10. ACCESSIBILITY W AUDIO-ONLY VR

### 10.1 Informacja kierunkowa przy obrotach (Kompas Dźwiękowy)

Snap Turn musi informować gracza:
1. **W którą stronę** — różny `pitch_scale` (0.8 = lewo, 1.2 = prawo)
2. **Gdzie teraz patrzy** — "ping" o pitch mapowanym na absolutną rotację

```gdscript
# Kompas: Północ = 1.5 pitch, Południe = 0.5 pitch
var compass_pitch = remap(abs(current_rotation_y), 0.0, PI, 1.5, 0.5)
```

### 10.2 Feedback dźwiękowy za akcje gracza

Każda skuteczna obrona MUSI być nagrodzona satysfakcjonującym dźwiękiem.
Brak nagrody = gracz nie wie, że się obronił = frustracja.

### 10.3 Crescendo dla narastającego zagrożenia

Dźwięk wroga powinien się fizycznie zbliżać z upływem czasu:
```gdscript
# Mnożnik dystansu maleje od 1.0 do 0.5 w czasie attack_timer:
var crescendo_mult = 1.0 - (attack_timer / attack_duration_limit) * 0.5
var target_pos = camera.global_position + (current_offset * crescendo_mult)
```

---

## 11. CHECKLIST DLA AGENTA AI PRZED KAŻDĄ ZMIANĄ

- [ ] Czy edytuję plik `.tscn`? → Sprawdź rozszerzenia plików audio na dysku
- [ ] Czy dodaję `[ext_resource]`? → Sprawdź unikalność ID
- [ ] Czy używam `_ready()`? → Czy operacja jest lekka? Jeśli nie → `call_deferred`
- [ ] Czy odwołuję się do gracza? → Użyj `get_first_node_in_group("player")`
- [ ] Czy modyfikuję `velocity`? → Separuj X/Z od Y
- [ ] Czy odtwarzam dźwięk? → Sprawdź `volume_db` (max ~5 dB)
- [ ] Czy używam wibracji? → `trigger_haptic_pulse`, NIE `set_input("haptic")`
- [ ] Czy tworzę AudioStreamPlayer dynamicznie? → `.finished.connect(.queue_free)`
- [ ] Czy dodaję wroga? → Dodaj do grupy `"enemy"`, oddziel warstwy kolizji
- [ ] Czy loguję debug info? → Owiń w `if OS.is_debug_build()`
