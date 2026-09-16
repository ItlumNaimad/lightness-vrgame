# Audyt Projektu Lightless VR — Raport

Poniżej zebrałem wszystko, co znalazłem po analizie każdego skryptu, każdej sceny `.tscn`, konfiguracji `project.godot`, zawartości `error.md` oraz logiki Game Design.

---

## 🐛 Część 1: Błędy i Problemy w Kodzie

### 1.1 NavigationMesh jest pusta (KRYTYCZNE)
**Plik:** [game_map.tscn](file:///c:/Users/naimad/Documents/lightness-vrgame/scenes/game_map.tscn#L20-L21)

```
[sub_resource type="NavigationMesh" id="NavigationMesh_new"]
```

Zasób `NavigationMesh` jest zdefiniowany, ale **nie ma żadnych parametrów** (brak `vertices`, `polygons`, `agent_radius` itd.). To oznacza, że Balora nawiguje po **pustej** siatce nawigacyjnej. Prawdopodobnie nigdy nie wciśnięto "Bake NavMesh" w edytorze. Bez tego `NavigationAgent3D.get_next_path_position()` zwraca pozycję Balory — ergo nie rusza się lub chodzi chaotycznie.

> [!CAUTION]
> **Naprawić:** Otwórz `game_map.tscn` w edytorze Godot → zaznacz `NavigationRegion3D` → kliknij **"Bake NavMesh"** na pasku. Alternatywnie dodaj wywołanie `$NavigationRegion3D.bake_navigation_mesh()` w `_ready()` skryptu `game_map.gd`.

---

### 1.2 Stary komentarz w `game_map.gd` — mylące informacje
**Plik:** [game_map.gd:12-13](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/game_map.gd#L12-L13)

```gdscript
# Nadpisujemy funkcję z klasy bazowej, aby uniknąć szukania $XROrigin3D/XRCamera3D wewnątrz mapy.
# Gracz jest zarządzany globalnie przez Staging.
```

Komentarz mówi o starym systemie Staging, z którego zrezygnowaliście. Teraz gracz **nie jest** zarządzany globalnie — każda scena ma swoją instancję. To powinno być zaktualizowane, żeby nie wprowadzać w błąd.

---

### 1.3 Ścieżki `@onready` w `game_map.gd` zależą od `[editable path]`
**Plik:** [game_map.gd:8-9](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/game_map.gd#L8-L9)

```gdscript
@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
```

Te ścieżki **działają wyłącznie** gdy w `.tscn` widnieje `[editable path="Player"]`. Jeśli ktokolwiek usunie tę flagę z pliku sceny, oba zwrócą `null`. Plik [error.md](file:///c:/Users/naimad/Documents/lightness-vrgame/error.md) potwierdza, że w przeszłości te ścieżki generowały już błędy `null instance`. Bezpieczniej byłoby szukać przez grupę `player`:

```gdscript
@onready var _player_root = get_tree().get_first_node_in_group("player")
@onready var timer_label: Label3D = _player_root.get_node_or_null("XROrigin3D/XRCamera3D/TimerLabel") if _player_root else null
```

---

### 1.4 Brak resetu `velocity.y` po wylądowaniu (Balora)
**Plik:** [ballora.gd:49-51](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/ballora.gd#L49-L51)

```gdscript
if not is_on_floor():
    velocity.y -= 9.8 * delta
```

Grawitacja odejmuje wartość w każdej klatce, ale **nigdy nie jest resetowana do zera** po wylądowaniu. Po powrocie na podłogę `velocity.y` zachowa resztkową wartość ujemną z poprzednich klatek. Powinno być:

```gdscript
if not is_on_floor():
    velocity.y -= 9.8 * delta
else:
    velocity.y = 0.0
```

---

### 1.5 Jumpscare Balory — szukanie kamery zakłada konkretne drzewo sceny
**Plik:** [ballora.gd:77-78](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/ballora.gd#L77-L78)

```gdscript
var xr_origin = player_body.get_parent()
var camera = xr_origin.get_node_or_null("XRCamera3D")
```

`player_body` w sygnale `body_entered` to `PlayerBody` (ciało fizyczne), a jego parent to `XROrigin3D`. To działa **teraz**, ale jest kruche — brak weryfikacji czy `xr_origin` w ogóle istnieje i czy ma `XRCamera3D`. Bezpieczniej:

```gdscript
var camera = get_tree().get_first_node_in_group("player").get_node_or_null("XROrigin3D/XRCamera3D")
```

---

### 1.6 Marionette — hardcoded granice mapy
**Plik:** [marionette.gd:95-96](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/marionette.gd#L95-L96)

```gdscript
spawn_pos.x = clamp(spawn_pos.x, -9.0, 9.0)
spawn_pos.z = clamp(spawn_pos.z, -9.0, 9.0)
```

Granice pokoju zakodowane na sztywno. Jeśli zmieni się rozmiar mapy, Marionette będzie spawnować się w nieprawidłowych miejscach (albo za ścianą, albo nigdy nie dotrze do ściany). Lepiej użyć `@export` lub raycast do najbliższej ściany.

---

### 1.7 Duplikacja kodu Jumpscare między Balorą a Marionette
Obie postacie mają niemal identyczną logikę:
- Zatrzymanie timera (`stop_timer_and_save`)
- Reparenting audio do kamery
- `await` 2 sekundy → `SceneLoader.load_scene(MAIN_MENU_PATH)`

To doskonały kandydat na **wydzielenie do wspólnej funkcji** lub nawet dedykowanego skryptu narzędziowego `jumpscare_helper.gd`.

---

## 🧩 Część 2: Problemy ze Scenami i Węzłami

### 2.1 `NavigationRegion3D` — brak ścian w `game_map.tscn`
Mapa zawiera **jedynie podłogę** (jeden `StaticBody3D` o rozmiarze 20x1x20). Brak ścian powoduje, że:
- Gracz może wyjść poza mapę
- Mechanika uderzania w ściany (planowana dla Foxy'ego) nie istnieje
- Marionette nie ma ścian, do których mogłaby się przyczepiać

> [!IMPORTANT]
> Trzeba dodać przynajmniej 4 ściany (`StaticBody3D` z `CollisionShape3D`) tworzące zamknięty pokój.

### 2.2 `AudioStreamPlayer` (ambience) — nie jest 3D
**Plik:** [game_map.tscn:65](file:///c:/Users/naimad/Documents/lightness-vrgame/scenes/game_map.tscn#L65)

Ambient na mapie gry używa zwykłego `AudioStreamPlayer` (mono/stereo), a nie `AudioStreamPlayer3D`. W grze dla niewidomych opartej na dźwięku przestrzennym warto rozważyć, czy ambient powinien być niekierunkowy (aktualnie — OK dla tła), czy raczej wielopunktowy (immersja).

### 2.3 Menu główne — brak wyświetlania wyniku przetrwania
`SceneLoader.last_survival_time` jest zapisywany, ale **nigdy nie jest odczytywany** w menu głównym. Po śmierci gracz nie wie, ile sekund przetrwał.

### 2.4 Menu główne — brak ekranu Game Over
Gracz po śmierci zostaje natychmiast przeniesiony do menu głównego bez żadnej informacji o przegranej. Brakuje dedykowanej sceny/ekranu Game Over, która jest wymieniona w planie (Faza 1).

### 2.5 Scena `marionette.tscn` — brak UID
**Plik:** [marionette.tscn:1](file:///c:/Users/naimad/Documents/lightness-vrgame/scenes/marionette.tscn#L1)

UID `uid://b3t54b22cxxxx` jest placeholderem. Godot 4.x powinien sam nadpisać go poprawną wartością przy pierwszym otwarciu w edytorze, ale warto sprawdzić — może generować ostrzeżenie.

---

## ⚙️ Część 3: Konfiguracja Projektu

### 3.1 `project.godot` — nazwa "Inżynierka"
Nazwa projektu ustawiona na `"Inżynierka"` zamiast `"Lightness"`. To wpływa na tytuł okna i identyfikację projektu.

### 3.2 Brak warstw kolizji z nazwami
W `project.godot` nie ma zdefiniowanych nazw warstw kolizji. Gracz ma `collision_layer = 524289` (bit 1 + bit 20), ale bez nazewnictwa trudno śledzić, co koliduje z czym. Warto dodać sekcję:
```
[layer_names]
3d_physics/layer_1="Player"
3d_physics/layer_2="Enemies"
3d_physics/layer_3="Walls"
```

---

## 💡 Część 4: Sugestie Projektowe i Gameplay

### 4.1 System Dźwięków Kroków Gracza (Faza 2 — potrzebne dla Foxy'ego)
Gracz obecnie nie generuje **żadnych** dźwięków chodzenia ani sprintu. To kluczowe dla:
- **Mechaniki Foxy'ego** (reaguje na hałas)
- **Immersji niewidomych** (echo kroków to jedyny sposób percepcji otoczenia)

Sugestia: Dodać `AudioStreamPlayer3D` do stóp gracza odtwarzający losowe sample kroków. Głośność zależna od prędkości (`walking` vs `sprinting`). Sprint emituje sygnał globalny `noise_emitted(position, loudness)`.

### 4.2 Echolokacja — klucz do dostępności ✨
Gracz niewidomy nie wie, jak wygląda pokój, gdzie są ściany, drzwi czy przeszkody. Propozycja:

> **Mechanika "Puls Echolokacyjny"** — gracz naciska przycisk kontrolera, co emituje krótki "klik" lub "stuknięcie". Dźwięk ten odbija się od najbliższych ścian i wraca jako echo z kierunku, w którym są przeszkody. Im bliżej ściana — tym szybsze i głośniejsze echo.

Implementacja: Raycasty w 8 kierunkach z `AudioStreamPlayer3D` emitującymi opóźniony dźwięk odbicia (delay proporcjonalny do odległości). **To jednocześnie generuje hałas, co przyciąga Foxy'ego** — gracz musi balansować między orientacją a bezpieczeństwem.

### 4.3 Wibracje Haptyczne (Rumble) jako kanał informacyjny
`XRToolsRumbleManager` jest w Autoload, ale **nigdy nie jest używany** w kodzie. Propozycje:
- **Bicie serca:** Narastająca wibracja kontrolerów gdy wróg jest blisko (bez zdejmowania wątpliwości co do kierunku — to daje dźwięk).
- **Uderzenie w ścianę:** Krótka, mocna wibracja + dźwięk uderzenia.@AU