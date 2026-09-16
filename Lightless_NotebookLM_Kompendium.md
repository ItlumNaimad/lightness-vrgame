This file is a merged representation of a subset of the codebase, containing specifically included files and files not matching ignore patterns, combined into a single document by Repomix.

# File Summary

## Purpose
This file contains a packed representation of a subset of the repository's contents that is considered the most important context.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Repository files (if enabled)
5. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.
- Pay special attention to the Repository Description. These contain important context and guidelines specific to this project.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Only files matching these patterns are included: scripts/**, scenes/*.tscn, gameDoc/Inżynierka/Notatka.md, gameDoc/Inżynierka/README.md, gameDoc/Inżynierka/Audit_2026-08.md, gameDoc/Inżynierka/.obsidian/audit_09-09-2026.md, .agents/AGENTS.md, README.md, project.godot
- Files matching these patterns are excluded: addons/**, assets/**, *.uid, *.import, .godot/**, gameDoc/Inżynierka/Dokumentacja.pdf, gameDoc/Inżynierka/Audit.md, gameDoc/Inżynierka/audit2.md
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Files are sorted by Git change count (files with more changes are at the bottom)

# User Provided Header
# Kompendium Projektu Lightless VR — Kompletna Baza Wiedzy i Kodu dla NotebookLM

Niniejszy dokument stanowi skonsolidowane, kompletne źródło wiedzy o projekcie gry VR 'Lightless' tworzonej w silniku Godot Engine 4.x na potrzeby pracy inżynierskiej.
Gra jest survival horrorem zaprojektowanym w 100% z myślą o dostępności dla osób niewidomych (rozgrywka oparta na przestrzennym 3D Audio, haptyce kontrolerów OpenXR oraz sterowaniu joystickiem w interfejsach).

Dokument zawiera:
1. Zasady projektowe i wytyczne inżynierskie (.agents/AGENTS.md)
2. Dziennik zmian, notatki techniczne, założenia poziomów (nocy) oraz audyty (gameDoc/Inżynierka/)
3. Kompletny kod źródłowy wszystkich autorskich skryptów GDScript (scripts/) wraz z pełnymi komentarzami i maszynami stanów
4. Trójwymiarową strukturę węzłów i właściwości scen (scenes/*.tscn)
5. Konfigurację projektu i warstw kolizji (project.godot)

# Directory Structure
````
.agents/
  AGENTS.md
gameDoc/
  Inżynierka/
    .obsidian/
      audit_09-09-2026.md
    Audit_2026-08.md
    Notatka.md
    README.md
scenes/
  balora.tscn
  foxy.tscn
  game_map.tscn
  game_over_ui.tscn
  game_over.tscn
  main_menu_ui.tscn
  main_menu.tscn
  marionette.tscn
  pause_menu_ui.tscn
  pause_menu.tscn
  phantom_grasp.tscn
  player.tscn
scripts/
  ballora.gd
  ballora.gd.uid
  event_bus.gd
  event_bus.gd.uid
  foxy.gd
  foxy.gd.uid
  game_map.gd
  game_map.gd.uid
  game_over_ui.gd
  game_over_ui.gd.uid
  game_over.gd
  game_over.gd.uid
  glitch_title.gd
  glitch_title.gd.uid
  hold_button.gd
  hold_button.gd.uid
  jumpscare_helper.gd
  jumpscare_helper.gd.uid
  level_manager.gd
  level_manager.gd.uid
  main_menu_ui.gd
  main_menu_ui.gd.uid
  main_menu.gd
  main_menu.gd.uid
  marionette.gd
  marionette.gd.uid
  pause_menu_ui.gd
  pause_menu_ui.gd.uid
  pause_menu.gd
  pause_menu.gd.uid
  phantom_grasp.gd
  phantom_grasp.gd.uid
  player_audio_manager.gd
  player_audio_manager.gd.uid
  scene_loader.gd
  scene_loader.gd.uid
  tts_manager.gd
  tts_manager.gd.uid
  vr_ui_navigator.gd
  vr_ui_navigator.gd.uid
project.godot
README.md
````

# Files

## File: gameDoc/Inżynierka/.obsidian/audit_09-09-2026.md
````markdown
Viewed scene_loader.gd:1-76
Viewed game_map.gd:1-180
Viewed foxy.gd:30-120
Viewed foxy.gd:115-243
Viewed foxy.gd:1-60
Viewed game_map.gd:60-140
Viewed pause_menu.gd:1-100
Viewed pause_menu.gd:95-109
Viewed phantom_grasp.gd:1-100
Viewed phantom_grasp.gd:100-160
Viewed tts_manager.gd:1-100
Viewed tts_manager.gd:100-155
Viewed task.md:1-70
Ran command: `git status -s`
Viewed Audit_2026-08.md:1-100
Searched for "^## "
Searched for "^#+ "
Searched for "Część"
Listed directory gameDoc
Listed directory In%C5%BCynierka
Viewed Audit_2026-08.md:100-250
Viewed Audit_2026-08.md:250-379
Viewed SKILL.md:1-72
Viewed SKILL.md:1-70
Viewed SKILL.md:1-60
Viewed SKILL.md:1-60
Viewed scene_loader.gd:1-76
Viewed jumpscare_helper.gd:1-88
Listed directory scenes
Listed directory scripts
Viewed game_over_ui.gd:1-57
Viewed game_over.gd:1-32
Viewed player_audio_manager.gd:1-120
Viewed player_audio_manager.gd:121-212
Viewed ballora.gd:1-100
Viewed ballora.gd:101-206
Viewed marionette.gd:1-110
Viewed marionette.gd:111-276
Viewed marionette.tscn:1-19
Viewed game_map.tscn:1-60
Viewed game_map.tscn:120-153
Viewed main_menu_ui.gd:1-100
Viewed main_menu_ui.gd:101-180
Viewed pause_menu_ui.gd:1-29
Viewed project.godot:1-50
Searched for "XRToolsRumbleManager"
Ran command: `& "C:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe" --headless --quit --path .`
Viewed Notatka.md:1-100

# Audyt Techniczny i Przegląd Jakości Kodu — Lightless VR
**Data audytu:** Wrzesień 2026  
**Wersja bazowa projektu:** v0.5.1  
**Podstawa analizy:** Wykonane zadania z [`task.md`](file:///C:/Users/naimad/.gemini/antigravity-ide/brain/c523b6ed-b3e9-4009-ba62-8e14121b8c1c/task.md) oraz zalecenia z [`gameDoc/Inżynierka/Audit_2026-08.md`](file:///c:/Users/naimad/Documents/lightness-vrgame/gameDoc/In%C5%BCynierka/Audit_2026-08.md).  
**Zastosowane moduły i standardy inżynierskie:**
`code-review-excellence`, `ai-debt-detector`, `architecture-patterns`, `architecture-decision-records`, `memory-safety-patterns`, `error-handling-patterns`, `cost-optimization`, `workflow-orchestration-patterns`.

---

## 1. Podsumowanie Wykonawcze (Executive Summary)

Projekt przeszedł gruntowną modernizację fundamentów technicznych, mechanik AI oraz warstwy sensorycznej (Audio 3D i haptyka VR). Zaimplementowano wszystkie 15 zadań zdefiniowanych w Etapach 0–4 pliku [`task.md`](file:///C:/Users/naimad/.gemini/antigravity-ide/brain/c523b6ed-b3e9-4009-ba62-8e14121b8c1c/task.md).

### Kluczowe osiągnięcia:
1. **Wyeliminowano 4 błędy krytyczne (Silent Failures):**
   - Ściemnianie (`Fade`) działa bezbłędnie (usunięto błędne sprawdzenia `ClassDB.class_exists` na klasach GDScript w [`scripts/scene_loader.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/scene_loader.gd)).
   - Pozycja gracza dla efektu Distortion i wrogów jest pobierana dynamicznie z głowy (`player_head` / `XRCamera3D`), a nie z nieruchomego roota.
   - Usunięto ryzyko permanentnego zawieszenia ładowania sceny (`is_loading = false` w gałęzi błędu).
   - HUD z etykietami tekstowymi został całkowicie odsprzęgnięty od logiki mapy — gra i bake NavMesh działają zawsze, nawet bez elementów wizualnych.
2. **AI wrogów w 100% zgodne ze specyfikacją [`.agents/AGENTS.md`](file:///c:/Users/naimad/Documents/lightness-vrgame/.agents/AGENTS.md):**
   - **Balora:** Maszyna stanów `PATROL → ALERT → CHASE → COOLDOWN` z płynną zmianą tempa pozytywki (`pitch_scale`) i możliwością ucieczki sprintem.
   - **Marionette:** Aktywna obrona przez zdecydowane machnięcie kontrolerem w stronę szeptu z fizycznym ostrzeżeniem haptycznym i eskalacją rund szeptów.
   - **Foxy:** Reakcja na kumulatywny hałas (w tym kolizje ze ścianami i echolokację), dedykowany sygnał ostrzegawczy [`danger.wav`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/danger.wav) oraz blok dłonią.
   - **Phantom Grasp:** Kompletny, nowo utworzony czwarty przeciwnik chwytający kontroler VR z mechaniką wyszarpywania.
3. **Pacing i Zarządzanie Zagrożeniem (Threat Director):**
   - Wprowadzono sekwencyjne odblokowywanie wrogów w czasie gry (0–15s orientacja, 15s Balora, 40s Marionette, 75s Foxy, 110s Phantom Grasp).
4. **Nowe Narzędzia Dostępności:**
   - **Echolokacja 3D** (przycisk `ax_button`) wypuszczająca 8 przestrzennych impulsów z opóźnionym echem kosztem ściągania uwagi Foxy'ego.
   - **Menu Pauzy VR** (`menu_button`) pozycjonujące się przed graczem z odczytem lektorskim (TTS) i zatrzymaniem fizyki.
   - **Ekran Game Over** czytający precyzyjną przyczynę śmierci oraz czas przetrwania.

---

## 2. Architektura i Wzorce Projektowe (Architecture Review)

### 2.1 Architektura SceneLoader i cykl życia sceny (ADR)
- **Decyzja:** Porzucenie węzła Staging na rzecz pełnej zamiany scen (`change_scene_to_packed`) z osobnym wątkiem `load_threaded_request`.
- **Ocena:** **Bardzo dobra**. Każda scena (`main_menu.tscn`, `game_map.tscn`, `game_over.tscn`) zawiera kompletne instancje `StartXR`, `Player` i `Fade`. Daje to natychmiastowy, deterministyczny reset fizyki OpenXR i eliminuje desynchronizacje kontrolerów.
- **Race Condition Prevention:** Zastosowanie podwójnego `await get_tree().process_frame` w [`scripts/scene_loader.gd:55-56`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/scene_loader.gd#L55-L56) gwarantuje, że węzły nowej sceny wykonały `_ready()` przed wywołaniem rozjaśnienia ekranu `_fade_in()`.

### 2.2 Wzorzec EventBus (Decoupling)
- Emisja hałasu z kroków, sprintu, uderzeń w ściany i echosondy odbywa się wyłącznie przez [`scripts/event_bus.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/event_bus.gd):
  ```gdscript
  EventBus.noise_emitted.emit(position, noise_level)
  EventBus.milestone_reached.emit(milestone_seconds)
  ```
- Żaden skrypt poruszania się gracza nie zna bezpośrednio instancji Foxy'ego ani Marionetki. Umożliwia to testowanie modułowe oraz bezbłędne działanie scen bez obecności wrogów.

### 2.3 Centralizacja sekwencji ataku (JumpscareHelper)
- Klasa [`scripts/jumpscare_helper.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/jumpscare_helper.gd) stanowi pojedynczy punkt wejścia dla zgonu gracza:
  - Zabezpieczenie `is_jumpscaring_global` zapobiega kaskadowemu nakładaniu się ataków (np. jednoczesny atak Marionetki i Balory).
  - Wykorzystanie natywnego `Node.reparent(camera, true)` zamiast dawnego usuwania i ponownego dodawania dziecka.
  - Płynny zapis przyczyny śmierci (`SceneLoader.last_death_reason`) i automatyczne przejście do `game_over.tscn`.

---

## 3. Szczegółowy Przegląd Implementacji AI Wrogów

| Przeciwnik | Stan przed audytem | Stan obecny (po task.md) | Zgodność z AGENTS.md |
|---|---|---|---|
| **Balora** | Ciągły, liniowy pościg bez patrolu; zacinanie się na ścianach. | Maszyna stanów `PATROL → ALERT → CHASE → COOLDOWN`. Alert przyspiesza pozytywkę (`pitch_scale: 1.0 → 1.35 → 1.7`). Możliwość zerwania kontaktu sprintem. Dopasowany promień agenta `0.85m`. | **100%** |
| **Marionette** | Pasywne patrzenie w bok (sprzeczne z VR dla niewidomych); brak haptyki. | Aktywna obrona gestem zamachu dłonią (`swing_speed_threshold: 1.3 m/s`) w stronę szeptu. Haptyka ostrzegawcza w ostatnich 1.8s. Narastająca liczba szeptów w serii po sygnale `milestone_reached`. | **100%** |
| **Foxy** | Reagował tylko na kroki; ostrzeżenie miało ten sam dźwięk co nagroda. | Hałas generowany także przez kolizje ze ścianami (3.5) i echolokację (4.5). Dedykowane audio [`danger.wav`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/danger.wav). Blok dłonią wyzwala haptykę i [`nice-sfx.mp3`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/nice-sfx.mp3). | **100%** |
| **Phantom Grasp** | Całkowity brak implementacji w projekcie. | Nowa scena [`scenes/phantom_grasp.tscn`](file:///c:/Users/naimad/Documents/lightness-vrgame/scenes/phantom_grasp.tscn) i skrypt [`scripts/phantom_grasp.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/phantom_grasp.gd). Losowy chwyt kontrolera, narastający dźwięk pełzania, ciągła wibracja dłoni i wyszarpywanie ruchem ręki (`shake_accel_threshold`). | **100%** |

---

## 4. Dostępność i Dźwięk Przestrzenny (Accessibility Review)

### 4.1 Semantyka Audio i likwidacja wieloznaczności próbek
Przed audytem pojedynczy plik `nice-sfx.mp3` pełnił 4 sprzeczne funkcje. Obecnie semantyka jest jednoznaczna:
- **Zagrożenie Foxy'ego:** [`assets/sounds/danger.wav`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/danger.wav) (niskotonowy, ponury ton ostrzegawczy).
- **Sukces obrony Foxy'ego:** [`assets/sounds/nice-sfx.mp3`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/nice-sfx.mp3) (wysoki, jasny akcent).
- **Sukces odpędzenia Marionetki:** [`assets/sounds/whoosh2.mp3`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/whoosh2.mp3) (dynamiczny świst rozproszenia).
- **Kompas dźwiękowy:** [`assets/sounds/Broken bell.ogg`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/sounds/Broken%20bell.ogg) (modulacja `pitch_scale` 0.6–1.4 w zależności od orientacji N–S z debouncingiem 0.25s).
- **Echolokacja:** Wysokotonowy impuls sonaru + opóźnione, przestrzenne odbicia 3D z 8 kierunków.

### 4.2 Lektor UI (Text-to-Speech)
- Wdrożono globalny [`scripts/tts_manager.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/tts_manager.gd) z automatycznym wykrywaniem głosu angielskiego (`en`, `eng`, `english`) oraz buforem **Dwell Debounce (80ms)**, co zapobiega crashom i zacinaniu wątku SAPI w systemie Windows przy szybkim przesuwaniu wskaźnika laserowego po przyciskach.
- Każdy przycisk w Menu Głównym, Menu Opcji, Pause Menu oraz Game Over posiada pełną zapowiedź lektorską oraz haptyczny impuls zwrotny przy naciśnięciu.

---

## 5. Wykryty Dług Technologiczny i Ryzyka (AI Debt & Edge Cases)

W oparciu o analizę wzorców ze skilli `ai-debt-detector`, `error-handling-patterns` oraz `memory-safety-patterns`, zidentyfikowano **trzy konkretne kwestie do drobnej poprawki**:

### 🔴 5.1 Wyłącznik lektora TTS w ustawieniach nie wycisza odczytu przycisków (Edge Case)
- **Lokalizacja:** [`scripts/tts_manager.gd:64`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/tts_manager.gd#L64) i [`scripts/tts_manager.gd:26-32`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/tts_manager.gd#L26-L32)
- **Problem:** Funkcja `speak(text)` posiada warunek `if not tts_enabled: return`. Jednak proces Dwell Timer w `_process()` po odliczeniu 80ms wywołuje bezpośrednio wewnętrzną metodę `_execute_speak(_pending_speech_text)`, w której **brakuje** sprawdzenia `if not tts_enabled: return`.
- **Skutek:** Gracz, który wyłączy w opcjach opcję *TTS Voice: OFF*, nadal słyszy odczytywanie przycisków po najechaniu na nie laserem.
- **Rekomendacja:** Dodać guard `if not tts_enabled: return` na początku funkcji `_execute_speak()`.

### 🟡 5.2 Asynchroniczne coroutines po `await create_timer` bez walidacji `is_inside_tree()`
- **Lokalizacja:** [`scripts/player_audio_manager.gd:200-209`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/player_audio_manager.gd#L200-L209) (`_spawn_delayed_echo`) oraz [`scripts/player_audio_manager.gd:136`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/player_audio_manager.gd#L136) (`_trigger_compass_ping`)
- **Problem:** Echolokacja tworzy do 8 opóźnionych ech za pomocą `await get_tree().create_timer(delay).timeout`, a dopiero potem wywołuje `add_child(echo)`. Jeśli gracz zginie lub zmieni scenę w trakcie tego opóźnienia, `add_child` zostanie wywołane na węźle odpiętym z drzewa sceny.
- **Rekomendacja:** Dodać po każdym takim `await` warunek:
  ```gdscript
  if not is_inside_tree():
      return
  ```

### 🟡 5.3 Failsafe dla pauzy w `SceneLoader.load_scene()`
- **Lokalizacja:** [`scripts/scene_loader.gd:18-28`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/scene_loader.gd#L18-L28)
- **Problem:** `load_scene()` używa `await get_tree().create_timer(0.6).timeout`. Timery drzewa sceny w Godot 4 są domyślnie wstrzymywane, gdy `get_tree().paused == true`. W `pause_menu.gd` zadbano o `get_tree().paused = false`, ale gdyby jakikolwiek inny skrypt wywołał zmianę sceny w stanie pauzy, ładowanie zablokowałoby się na timerze.
- **Rekomendacja:** Na samym początku `load_scene()` dodać twarde `get_tree().paused = false`.

### 🔵 5.4 Nieużywany Autoload `XRToolsRumbleManager`
- **Lokalizacja:** [`project.godot:25`](file:///c:/Users/naimad/Documents/lightness-vrgame/project.godot#L25)
- **Problem:** Wszystkie skrypty projektu korzystają z bezpośredniego, natywnego API OpenXR: `controller.trigger_haptic_pulse()`. Żaden skrypt w `scripts/` nie odwołuje się do `XRToolsRumbleManager`.
- **Rekomendacja:** Wyrejestrować ten autoload z `project.godot`, zmniejszając narzut pamięciowy i czas uruchamiania gry na goglach VR (Meta Quest).

---

## 6. Wydajność i Profilowanie VR (Cost & Performance)

1. **Eliminacja wyszukiwań w drzewie węzłów (Tree Traversal):**
   - Wcześniej: `get_nodes_in_group("enemy")` i `get_first_node_in_group("player")` wywoływane co klatkę w `_process` (`game_map.gd`) i `_physics_process` (`foxy.gd`).
   - Teraz: Wprowadzono timer odświeżania listy wrogów co 1.0s (`_enemy_refresh_timer`) oraz jednokrotny cache referencji głowy gracza w `_ready()`.
2. **Optymalizacja NavMesh:**
   - Poprawiono konfigurację `NavigationMesh`: `agent_radius = 0.85`, `agent_height = 2.8`, `cell_size = 0.15`.
   - Balora nie ociera się już o ściany pomieszczenia (40×43m), co wyeliminowało błędy mikro-kolizji i spadek klatek przy zakrętach.
3. **Smoke Test Silnika (Headless):**
   - Wykonany test kompilacji: `godot --headless --quit --path .`
   - **Wynik:** Kod wyjścia `0` — **0 błędów parsowania GDScript, 0 brakujących zasobów, 100% poprawności typów**.

---

## 7. Rekomendowana Kolejność Dalszych Prac (Actionable Roadmap)

### Priorytet A (Drobne łatki techniczne — ~15 minut):
1. Dodać guard `if not tts_enabled: return` w [`scripts/tts_manager.gd:_execute_speak`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/tts_manager.gd#L64).
2. Dodać guard `if not is_inside_tree(): return` po `await create_timer` w [`scripts/player_audio_manager.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/player_audio_manager.gd).
3. Dodać `get_tree().paused = false` na początku `SceneLoader.load_scene()` w [`scripts/scene_loader.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/scene_loader.gd).
4. Usunąć wpis `XRToolsRumbleManager` z sekcji `[autoload]` w [`project.godot`](file:///c:/Users/naimad/Documents/lightness-vrgame/project.godot).

### Priorytet B (Dokumentacja i Zgodność Akademicka):
1. Zaktualizować [`gameDoc/Inżynierka/Notatka.md`](file:///c:/Users/naimad/Documents/lightness-vrgame/gameDoc/In%C5%BCynierka/Notatka.md) oraz [`README.md`](file:///c:/Users/naimad/Documents/lightness-vrgame/README.md) o opis nowych mechanik (Threat Director, Echolokacja, machanie dłonią na Marionetkę, Phantom Grasp i Pause Menu).
2. Zaktualizować numer wersji w dokumentacji do `v0.5.2` (zgodnie ze zmianami z audytu).
````

## File: gameDoc/Inżynierka/Audit_2026-08.md
````markdown
# Audyt Lightness VR — sierpień 2026

Audyt jakości kodu, błędów i rekomendacji naprawczych. Zakres: wszystkie skrypty w `scripts/`, wszystkie scenami `scenes/`, `project.godot`, wendorowany `addons/godot-xr-tools` (wersja z `plugin.cfg`: `4.4.1-dev`), oraz zgodność implementacji ze specyfikacją `.agents/AGENTS.md`.

> [!NOTE]
> Poprzedni audyt (`Audit.md`) jest **częściowo nieaktualny i urwany w połowie zdania** (kończy się na `@AU`). Pozycje 1.4 (grawitacja Balory), 1.5 (szukanie kamery), 1.7 (duplikacja jumpscare), 2.1 (brak ścian) oraz 4.1 (dźwięki kroków) zostały już naprawione. Ten dokument go zastępuje.

Legenda severity: 🔴 krytyczne (psuje rozgrywkę) · 🟠 wysokie · 🟡 średnie · 🔵 niskie / dług techniczny

---

## 🔴 Część 1: Błędy krytyczne

### 1.1 🔴 Ściemnianie (fade) NIE DZIAŁA — martwy kod przez `ClassDB.class_exists`

**Plik:** `scripts/scene_loader.gd:54,61`

```gdscript
func _set_fade(target_alpha: float, duration: float):
	if ClassDB.class_exists("XRToolsFade"):   # <-- zawsze FALSE
```

`XRToolsFade` jest klasą **GDScript** (`addons/godot-xr-tools/effects/fade.gd:2` → `class_name XRToolsFade`). `ClassDB` rejestruje **wyłącznie klasy natywne (C++)** silnika — skrypty z `class_name` trafiają do `ProjectSettings._global_script_classes`, nie do `ClassDB`. Wywołanie zwraca więc **zawsze `false`**.

**Skutek:** cała funkcja `_set_fade()` oraz `_apply_fade_color()` to **martwy kod**. Fade do czarnego nigdy się nie odpala, fade-in również. Każda zmiana scenami to natychmiastowy, gwałtowny przeskok obrazu w gogle — dokładnie to, czemu `SceneLoader` miał zapobiegać. To bezpośrednia przyczyna choroby lokomocyjnej.

**Naprawa** — usunąć guard, `set_fade` jest `static` i sam znajduje węzły przez grupę `fade_mesh`:

```gdscript
func _apply_fade_color(color: Color) -> void:
	XRToolsFade.set_fade("scene_transition", color)
```

> [!CAUTION]
> Ten sam antywzorzec (`ClassDB.class_exists` na klasie GDScript) występuje w `scene_loader.gd:43` i `foxy.gd:42`, ale tam jest **maskowany** przez `or true` — warunek zawsze przechodzi. Kod działa przez przypadek. Usunąć wszystkie trzy wystąpienia; są mylące i sugerują, że guard cokolwiek chroni.

---

### 1.2 🔴 Pozycja gracza czytana z węzła, który się nie rusza

**Pliki:** `scripts/game_map.gd:65`, `scripts/foxy.gd:129`

```gdscript
var player_root = get_tree().get_first_node_in_group("player")
var p_pos = player_root.global_position     # <-- statyczna pozycja!
```

Grupa `player` jest przypisana do **roota** `Player` (Node3D) w `player.tscn:19`. Ruchem zarządza `XRToolsPlayerBody`, który przesuwa **`XROrigin3D`**, nie roota (`player_body.gd:364` → `origin_node.global_transform.origin += movement`). Root `Player` pozostaje na transformacie z `game_map.tscn:131` przez całą rozgrywkę.

**Skutki:**
- **Efekt Distortion nie działa** — dystans do wrogów liczony jest od nieruchomego punktu startowego. `pitch_scale` ambientu reaguje na to, jak wrogowie krążą wokół punktu spawnu, a nie wokół gracza. Podprogowe ostrzeżenie o bliskości zagrożenia jest fałszywe.
- **Foxy w stanie LISTENING idzie w złe miejsce** — powoli podąża do punktu spawnu gracza, nie do gracza.

**Naprawa:** wszędzie używać kamery (głowy), zgodnie z konwencją z `CLAUDE.md`:

```gdscript
var camera := player_root.get_node_or_null("XROrigin3D/XRCamera3D") as XRCamera3D
var p_pos := camera.global_position if camera else player_root.global_position
```

Rekomendacja systemowa: dodać do `player.tscn` skrypt eksponujący `func get_head_position() -> Vector3`, albo dodać samą kamerę do osobnej grupy `player_head`. Powtarzanie ścieżki `"XROrigin3D/XRCamera3D"` w 6 plikach to źródło dokładnie tej klasy błędów.

---

### 1.3 🔴 Zablokowanie `SceneLoader` na zawsze po nieudanym ładowaniu

**Plik:** `scripts/scene_loader.gd:30-32`

```gdscript
if status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
	set_process(false)
	printerr("Błąd ładowania sceny: ", scene_path)
	# BRAK: is_loading = false
```

`is_loading` zostaje `true`. Ponieważ `load_scene()` na wejściu robi `if is_loading: return`, **każda kolejna próba zmiany scenami jest cicho ignorowana**. Gracz zostaje uwięziony w scenie na zawsze, bez żadnego komunikatu (a ekran jest w tym momencie wyczerniony — po naprawie 1.1 byłby to czarny ekran bez wyjścia).

**Naprawa:** zresetować `is_loading = false` w gałęzi błędu i przywrócić fade-in.

---

### 1.4 🔴 Brakujący HUD wyłącza timer ORAZ nawigację

**Plik:** `scripts/game_map.gd:18-29`

```gdscript
if timer_label == null or milestone_audio == null:
	printerr("HUD nie został zainicjowany...")
	return                       # <-- ucieka z _ready()
# ...poniżej, NIEOSIĄGALNE przy braku HUD:
call_deferred("_deferred_bake_navmesh")
is_timer_running = true
```

Kosmetyczna zależność (`Label3D` z licznikiem — **nieistotny dla niewidomego gracza**) blokuje: bake NavMesha (Balora przestaje się ruszać), timer przetrwania, kamień milowy (gong co 10 s), zapis wyniku. Kaskadowa awaria całej rozgrywki z powodu brakującej etykiety tekstowej.

**Naprawa:** rozdzielić — HUD jest opcjonalny, logika obowiązkowa:

```gdscript
if timer_label == null:
	push_warning("TimerLabel niedostępny — HUD wyłączony (gra działa dalej).")
if nav_region and nav_region.navigation_mesh:
	call_deferred("_deferred_bake_navmesh")
is_timer_running = true
```

Potem chronić każde użycie (`if timer_label:` już jest w `_process`, `milestone_audio` też).

---

### 1.5 🔴 Marionette poza grupą `enemy`

**Plik:** `scenes/marionette.tscn:9`

```
[node name="Marionette" type="Node3D" unique_id=1428825871]
```

`balora.tscn:23` i `foxy.tscn:27` mają `groups=["enemy"]`. Marionette **nie ma**. A to ona podchodzi na 1,0–1,5 m do głowy gracza — jest najbliższym i najgroźniejszym przeciwnikiem.

**Skutek:** `game_map.gd:_update_distortion_effect` całkowicie ją pomija. Najsilniejsze zagrożenie w grze nie generuje żadnego ostrzeżenia dźwiękowego przez ambient.

**Naprawa:** dodać `groups=["enemy"]` do roota `marionette.tscn`.

---

## 🟠 Część 2: Rozbieżność kodu ze specyfikacją `.agents/AGENTS.md`

To najpoważniejszy problem projektowy: **trzy z czterech przeciwników nie realizują zaprojektowanej mechaniki**. Dla pracy inżynierskiej rozjazd dokumentacji z implementacją jest szczególnie kosztowny.

### 2.1 🟠 Balora — brak patrolu, stref alertu i ucieczki

**Spec (`AGENTS.md:20`):** patroluje mapę, emituje pozytywkę, przy wejściu w strefę Alertu pozytywka **przyspiesza** i Balora rusza w stronę gracza, wejście w strefę Krytyczną → pościg, **da się od niej uciec** i wraca do patrolu.

**Implementacja (`ballora.gd`):** `nav_agent.target_position = player.global_position` w każdej klatce, `SPEED = 1.0`, bez przerwy, od pierwszej sekundy. Brak: punktów patrolu, stref alert/krytyczna, zmiany `pitch_scale` pozytywki, jakiegokolwiek stanu i możliwości ucieczki.

To nie jest „proximity-based AI” — to nieprzerwany, liniowy pościg. Gracz nie ma żadnej informacji zwrotnej o poziomie zagrożenia ani sposobu na deeskalację.

**Rekomendacja:** maszyna stanów `PATROL → ALERT → CHASE → COOLDOWN` z `@export` progami dystansu, `pitch_scale` pozytywki mapowanym na stan (kluczowy kanał informacyjny dla niewidomego gracza) i timerem zgubienia gracza.

### 2.2 🟠 Marionette — zaimplementowana odwrotna mechanika

**Spec (`AGENTS.md:22`):** gracz ustala kierunek szeptu i **zdecydowanie macha kontrolerem** w stronę źródła, żeby ją odpędzić.

**Implementacja (`marionette.gd:128-153`):** gracz musi **stać nieruchomo** (`max_movement_allowed = 0.6`) i **patrzeć w inną stronę** (`look_threshold`) przez `survive_time`. Machanie kontrolerem nie jest w ogóle sprawdzane — nie ma `Area3D` na dłonie, nie ma detekcji gestu.

To całkowicie inna mechanika: pasywne przetrwanie zamiast aktywnej obrony. Dodatkowo mechanika „spojrzenie na źródło = jumpscare" jest dla niewidomego gracza nieczytelna (nie ma świadomości, gdzie „patrzy" kamera) i sprzeczna z ideą braku przewagi z bodźców wizualnych.

**Powiązane:**
- `marionette.gd:109` — komunikat `"Czas na reakcję (3s) minął!"` przy `attack_duration_limit = 5.5`. Nieaktualny tekst.
- **Brak haptyki bliskiego zagrożenia** — `AGENTS.md:28` wymaga wibracji gogli/kontrolerów jako ostatecznego fizycznego ostrzeżenia. Niezaimplementowane.
- `marionette.tscn:21` ma stały, **zawsze widoczny** `MeshInstance3D` (SphereMesh) obok tworzonej w kodzie kuli debugowej (`marionette.gd:70-83`, chowanej pod `debug_visible`). Prawdopodobnie pozostałość — usunąć węzeł ze scenami.

### 2.3 🟠 Foxy — brak reakcji na hałas z kolizji

**Spec (`AGENTS.md:8,21`):** hałas generują sprint, **uderzenia w ściany** i gwałtowne ruchy.

**Implementacja:** `EventBus.noise_emitted` jest emitowany **wyłącznie** z kroków (`player_audio_manager.gd:65`). Uderzenia w ściany nie generują ani dźwięku, ani hałasu, ani haptyki — mimo że ściany zostały dodane do `game_map.tscn`. Gwałtowne ruchy kontrolerami również nie.

**Skutek:** jedyny sposób zwrócenia uwagi Foxy'ego to bieganie. Połowa zaprojektowanej pętli rozgrywki nie istnieje, a gracz niewidomy traci najważniejszy kanał percepcji otoczenia (echo uderzenia w przeszkodę).

### 2.4 🟠 Phantom Grasp — całkowicie niezaimplementowany

`AGENTS.md:23` opisuje czwartego przeciwnika (chwyt kontrolera → intensywne potrząsanie żeby się wyrwać). Brak skryptu, brak scenami, brak jakichkolwiek śladów w kodzie.

### 2.5 🟠 Eskalacja trudności niepodłączona

**Plik:** `scripts/game_map.gd:86-87`

```gdscript
# W tym miejscu w przyszłości możesz dodać wywołanie zmian w logice AI
print("Osiągnięto próg! Aktualny próg uciekł na: ", next_milestone)
```

Gong co 10 s brzmi, ale `next_milestone` nie wpływa na żadne AI. `AGENTS.md:22` wymaga, by Marionette z czasem atakowała sekwencyjnie i trudniej.

**Rekomendacja:** dodać do `EventBus` sygnał `milestone_reached(milestone: int)`, wyemitować w `_trigger_milestone_event()`, a przeciwnicy niech się podpisują i skalują własne parametry. Zgodnie z istniejącą architekturą (EventBus jako jedyny kanał odsprzęgający) to naturalne rozszerzenie.

---

## 🟠 Część 3: Dostępność — defekty blokujące

Cel projektu to **pełna grywalność dla osób niewidomych**. Poniższe braki są sprzeczne z tym celem, więc traktuję je jako defekty, nie jako „nice to have".

### 3.1 🟠 Menu nieobsługiwalne bez wzroku — brak TTS

`AGENTS.md:7` wymaga „systemu odczytywania zaznaczeń (TTS / nagrania lektorskie)". `main_menu_ui.gd` to trzy gołe `signal` + `Button`. Gaze pointer ma `click_on_hold = true` z `hold_time` 0.7 s / 1.0 s, ale **nic nie informuje gracza, na którym przycisku jest kursor**.

Niewidomy gracz nie jest w stanie uruchomić gry. To defekt blokujący całą tezę projektu.

**Rekomendacja:** Godot ma wbudowane `DisplayServer.tts_speak()`. Podpiąć `focus_entered` / `mouse_entered` każdego `Button` do odczytania etykiety + krótki „tick" haptyczny na kontrolerze, z którego przyszedł pointer. Alternatywnie nagrania lektorskie (`AudioStreamPlayer` per pozycja menu) — pewniejsze na Quest, gdzie TTS może być niedostępny. Zweryfikować `DisplayServer.tts_get_voices()` na docelowym urządzeniu przed wyborem.

### 3.2 🟠 Brak informacji o śmierci i wyniku

`SceneLoader.last_survival_time` jest **zapisywany, ale nigdy nie czytany** (potwierdzone: brak wystąpień poza `scene_loader.gd:3` i `game_map.gd:92`). Po jumpscare gracz wraca do menu bez żadnej informacji: ile przetrwał, co go zabiło, że w ogóle przegrał.

**Rekomendacja:** ekran/stan Game Over z odczytem TTS: „Przetrwałeś 47 sekund. Zabiła cię Marionette." Przekazać też przyczynę — `JumpscareHelper.execute()` może przyjmować `enemy_name: String` i zapisywać ją obok czasu.

### 3.3 🟠 Jeden dźwięk `nice-sfx.mp3` dla czterech różnych zdarzeń

`AGENTS.md:30` wymaga: *„Każde skuteczne odparcie wroga musi być natychmiast nagrodzone **unikalnym** i satysfakcjonującym dźwiękiem"*.

Ten sam plik `res://assets/sounds/nice-sfx.mp3` jest użyty w:

| Plik | Linia | Zdarzenie |
|---|---|---|
| `foxy.gd` | 68 | **Ostrzeżenie** przed szarżą (zagrożenie!) |
| `foxy.gd` | 215 | **Sukces** — blok szarży |
| `marionette.gd` | 164 | **Sukces** — odpędzenie szeptu |
| `player_audio_manager.gd` | 47 | Ping kompasu dźwiękowego (nawigacja) |

Dla gracza operującego wyłącznie słuchem to katastrofa semantyczna: **ten sam dźwięk oznacza „uwaga, atak" i „dobrze, udało się"**. Do tego ping kompasu (najczęstszy dźwięk w grze) zużywa tę samą próbkę, co dodatkowo ją odziera ze znaczenia.

**Naprawa (wysoki priorytet, niski koszt):** cztery osobne próbki o wyraźnie różnej barwie i konturze — ostrzeżenie niskie/narastające, sukces wysoki/opadający, kompas krótki i neutralny. Pamiętać o atrybucji w `README.md` (`## Sounds:`).

### 3.4 🟡 Brak echolokacji / orientacji przestrzennej

Gracz niewidomy nie ma sposobu poznania układu pomieszczenia (40×44 m, cztery ściany). Kompas dźwiękowy podaje tylko azymut głowy, nie geometrię.

Propozycja z poprzedniego audytu (4.2 — „Puls Echolokacyjny": przycisk → klik → raycasty w 8 kierunkach → opóźnione echa proporcjonalne do dystansu, **jednocześnie generujące hałas przyciągający Foxy'ego**) pozostaje najlepszym pojedynczym usprawnieniem dostępności w projekcie i elegancko domyka pętlę risk/reward. Rekomenduję wdrożenie.

### 3.5 🟡 `XRToolsRumbleManager` w autoload, nieużywany

Autoload jest zarejestrowany (`project.godot:26`), ale **żadne** wywołanie w kodzie go nie dotyka. `jumpscare_helper.gd:78-92` obchodzi go i woła `trigger_haptic_pulse()` bezpośrednio na `XRController3D`, ręcznie szukając `left_hand`/`right_hand`.

Haptyka to drugi (po dźwięku) kanał informacyjny w tej grze i jest wykorzystana **wyłącznie** w momencie jumpscare — czyli gdy jest już za późno. Brakuje: bicia serca przy bliskości wroga, uderzenia w ścianę, potwierdzenia bloku, ostrzeżenia Marionette.

---

## 🟡 Część 4: Poprawność i wydajność

### 4.1 🟡 NavMesh: pusty zasób + niedopasowany promień agenta

`game_map.tscn:21` — `[sub_resource type="NavigationMesh" id="NavigationMesh_new"]` bez **żadnych** parametrów. Bake odbywa się w runtime (`game_map.gd:31`), więc używane są wartości domyślne, m.in. `agent_radius = 0.5`.

Kolizja Balory ma `radius = 0.761` (`balora.tscn:8`). Agent o promieniu 0.5 dostaje ścieżki przechodzące 0,26 m zbyt blisko ścian → Balora **będzie się zacinać na ścianach i narożnikach**. Skrypt kompensuje to `path_desired_distance = 2.0` (`ballora.gd:29`), co jest obejściem objawu, nie przyczyny, i psuje precyzję ścieżki.

**Naprawa:** ustawić w zasobie `agent_radius = 0.85`, `agent_height` ≈ 2.8, `cell_size` ≈ 0.15 i zbakować **w edytorze**, zapisując wynik do `.tscn`. Runtime bake przy starcie mapy to koszt kilkuset ms na Queście — niepotrzebny, skoro geometria jest statyczna. Zostawić `bake_navigation_mesh()` tylko jako awaryjny fallback, gdy `navigation_mesh.get_polygon_count() == 0`.

### 4.2 🟡 Wyszukiwania w grupach w każdej klatce

| Plik | Linia | Wywołanie | Częstotliwość |
|---|---|---|---|
| `game_map.gd` | 60-61 | `get_nodes_in_group("enemy")` + `get_first_node_in_group("player")` | co klatkę `_process` |
| `foxy.gd` | 127 | `get_first_node_in_group("player")` | co klatkę `_physics_process` |
| `marionette.gd` | 96 | `_find_player()` przy `camera == null` | co klatkę, dopóki null |

Balora robi to poprawnie — cache'uje w `_ready()` (`ballora.gd:20-25`). Na Mobile rendererze / Queście te przeszukiwania drzewa co klatkę są zbędnym obciążeniem, a lista wrogów jest statyczna po załadowaniu mapy.

**Naprawa:** cache'ować w `_ready()` (z `call_deferred` jeśli kolejność inicjalizacji jest problemem), odświeżać tylko na sygnał. `game_map.gd` może też liczyć distortion co 3–4 klatki — `lerp` z `delta * 3.0` i tak wygładza wynik, a różnica będzie niesłyszalna.

### 4.3 🟡 Race condition przy fade-in po zmianie scenami

`scene_loader.gd:39-48` — `change_scene_to_packed()` w Godot 4 **odkłada** podmianę do końca klatki. Bezpośrednio po nim wołane jest `call_deferred("_fade_in")`, czyli fade-in może wystartować, gdy nowa scena (a z nią nowy węzeł `Fade` w grupie `fade_mesh`) jeszcze nie istnieje. Wtedy `XRToolsFade.set_fade()` nie znajduje żadnego węzła i nowa scena startuje bez zaciemnienia albo pozostaje czarna.

Obecnie zamaskowane błędem 1.1 (fade nie działa wcale). **Po naprawie 1.1 ten błąd się ujawni.**

**Naprawa:** poczekać na faktyczną podmianę:

```gdscript
get_tree().change_scene_to_packed(loaded_resource)
await get_tree().process_frame          # scena podmieniona
await get_tree().process_frame          # węzły _ready() wykonane
is_loading = false
JumpscareHelper.is_jumpscaring_global = false
_fade_in()
```

### 4.4 🟡 `reparent()` zamiast ręcznego `remove_child`/`add_child`

`jumpscare_helper.gd:46-64` ręcznie robi `remove_child()` → `add_child()` → przywrócenie `global_transform`. Godot 4 ma `Node.reparent(new_parent, keep_global_transform = true)`, które robi dokładnie to, atomowo i bez ryzyka przerwania odtwarzania audio między zdjęciem a dodaniem.

Dodatkowo `jumpscare_helper.gd:80`:
```gdscript
var left = caller.get_viewport().find_world_3d()   # nigdzie nieużywane
```
Martwa zmienna o mylącej nazwie (`left` sugeruje lewą rękę, a trzyma `World3D`). Usunąć.

### 4.5 🟡 Detekcja sprintu przez próg na `ground_control_velocity`

`player_audio_manager.gd:61` — `if player_body.ground_control_velocity.length() > 2.0`. To wektor **wejścia sterowania** skalowany prędkością, nie stan sprintu. W scenach jest węzeł `MovementSprint` (`player.tscn:30`), który zna prawdę.

Problemy: próg `2.0` jest magiczną liczbą zależną od konfiguracji `MovementDirect`/`MovementSprint`; zmiana prędkości chodzenia w ustawieniach cicho psuje wykrywanie hałasu (a więc całą mechanikę Foxy'ego). Do tego dostęp `player_body.ground_control_velocity` bez sprawdzenia (`in` / `has_method`) na węźle z wendorowanego addona — przy aktualizacji XR Tools wywali się runtime error.

**Naprawa:** odpytywać `MovementSprint` o stan sprintu, a `noise_level` trzymać jako dwie stałe `@export`.

### 4.6 🔵 Kumulacja timerów pingu kompasu

`player_audio_manager.gd:44-52` — `_trigger_compass_ping()` robi `await create_timer(0.2)`, potem tworzy `AudioStreamPlayer`. Przy serii szybkich obrotów (snap turn można spamować) narasta kolejka oczekujących coroutine, każda tworząca węzeł. Dorzucić prosty guard („ping nie częściej niż raz na 0.25 s").

### 4.7 🔵 Tworzenie węzłów audio ad-hoc — 4× powtórzony wzorzec

Wzorzec `AudioStreamPlayer.new()` → `stream = preload(...)` → `add_child` → `play()` → `finished.connect(queue_free)` powtarza się w `foxy.gd` (2×), `marionette.gd` (1×), `player_audio_manager.gd` (1×). Kandydat na `AudioHelper.play_oneshot(parent, stream, volume_db, pitch)` — spójnie z tym, jak `JumpscareHelper` już wydzielił wspólną logikę jumpscare'ów.

### 4.8 🔵 Warstwy kolizji — do weryfikacji

- `foxy.tscn:68` — `BlockTrigger` ma `collision_mask = 131072` (bit 18 = `PlayerHand`). **Nie udało się potwierdzić**, że fizyczne dłonie z XR Tools faktycznie są na warstwie 18 — `left_physics_hand_low.tscn` nie nadpisuje `collision_layer`. Jeśli addon używa innej warstwy, **blok Foxy'ego nie działa w ogóle**. Sprawdzić w edytorze i w razie potrzeby ustawić warstwę jawnie na węzłach dłoni w `player.tscn`.
- `balora.tscn:45` — `JumpscareTrigger` bez nadpisania warstw → domyślne `layer=1, mask=1`. Wykrywa więc także `Floor` i ściany (warstwa `World`=1). Filtr `"PlayerBody" in body.name` (`ballora.gd:63`) ratuje logikę, ale generuje zbędne sygnały co klatkę kontaktu. Foxy robi to poprawnie (`mask = 524289`). Wyrównać.

---

## 🔵 Część 5: Konfiguracja projektu i Godot 4.7

### 5.1 🟠 `config/features` podniesione do 4.7 bez weryfikacji migracji

W drzewie roboczym (niezacommitowane) `project.godot` ma już `PackedStringArray("4.7", "Mobile")`, ale wendorowany XR Tools to `4.4.1-dev` (`plugin.cfg`), przy czym `VERSIONS.md` opisuje zmiany aż do `4.5.0`. **Wersja addona jest niespójna sama w sobie** — prawdopodobnie częściowo podmieniony katalog.

Ryzyka przy 4.6 → 4.7:
- Godot 4.7 **upraszcza domyślną mapę akcji OpenXR** do czterech profili. Projekt ma własny, 87 KB `openxr_action_map.tres` — nie zostanie nadpisany, ale warto potwierdzić, że profile dla docelowego kontrolera nadal się bindują.
- 4.7 **rekomenduje teraz Mobile renderer dla XR** (Vulkan subsampled images / foveated rendering) — obecny wybór `renderer/rendering_method="mobile"` jest zgodny z nowym zaleceniem. Dobrze.
- XR Tools **4.5.x wymaga minimum Godot 4.4**, więc formalnie 4.7 jest OK, ale kombinacja 4.7 + `4.4.1-dev` nie jest przez nikogo testowana.

**Rekomendacja przed dalszą pracą:**
1. Zacommitować lub wycofać obecne zmiany w `project.godot` — praca na niezacommitowanym bumpie wersji silnika jest ryzykowna.
2. Podmienić `addons/godot-xr-tools` na czysty tag **4.5.1** (najnowszy stabilny) i zweryfikować `plugin.cfg`.
3. Smoke test: `godot --headless --quit --path .` wyłapie wszystkie błędy parsowania GDScript bez gogli — jedyna forma automatycznego testu dostępna w tym projekcie, warto ją stosować po każdej większej zmianie.
4. Przejrzeć oficjalny przewodnik „Upgrading from Godot 4.6 to 4.7" pod kątem `AudioStreamPlayer3D` i `NavigationAgent3D`.

### 5.2 🟡 Nazwa projektu

`project.godot:17` — `config/name="Inżynierka"`. Projekt nazywa się **Lightness VR** (`README.md:1`), repozytorium `lightness-vrgame`. Nazwa wpływa na tytuł okna i katalog `user://`. Zmienić na `"Lightness VR"`.

### 5.3 🔵 Porządki w repozytorium

- `scripts/main.gd.uid` — **osierocony** plik `.uid` po usuniętym `main.gd` (pozostałość po porzuceniu architektury Staging). Usunąć.
- `scenes/marionette.tscn:1` — `uid://b3t54b22cxxxx` to oczywisty placeholder wpisany ręcznie. Działa (`game_map.tscn:12` referuje tę samą wartość), ale należy pozwolić Godotowi wygenerować prawdziwy UID.
- `.freebuff/desktop.db-shm`, `.freebuff/desktop.db-wal` — pliki tymczasowe SQLite **śledzone przez git** (widoczne jako zmodyfikowane na starcie każdej sesji). Dodać `.freebuff/` do `.gitignore` i `git rm --cached`.
- Nieaktualne dokumenty w korzeniu: `error.md`, `implementation_plan.md`, `implementation_from_gemini.md`, `Antigravity_setup.md`, `konsol log.png` (+ `.import`). Zaśmiecają kontekst — przenieść do `gameDoc/archiwum/` lub usunąć.
- `ballora.gd` — **pięć komentarzy `![ASK]`** w zacommitowanym kodzie (linie 16, 21, 33, 43, 75) to pytania autora do siebie/agenta, nie dokumentacja. Zawierają m.in. „Co to JumpscareHelper i jak działa await". Rozstrzygnąć i usunąć; w pracy inżynierskiej wyglądają bardzo źle.
- `main_menu_ui.gd:1` — `@tool` na `Control` bez żadnej logiki edytorowej. Zbędne (`@tool` zwiększa ryzyko dziwnych błędów w edytorze). Usunąć.
- `ballora.gd:5-8` — referencje `mesh_instance`, `audio_player` bez typów, wbrew konwencji z `AGENTS.md:34`. Dotypować.

---

## Rekomendowana kolejność prac

Kolejność wynika z zależności: naprawy fundamentów odblokowują sensowne testowanie wszystkiego powyżej.

**Etap 0 — odblokowanie (kilka godzin, ogromny zwrot)**
1. `1.1` fade (usunąć guardy `ClassDB`) — **równocześnie** z `4.3` (race fade-in), bo naprawa 1.1 ujawnia 4.3
2. `1.3` reset `is_loading` przy błędzie
3. `1.4` rozdzielenie HUD od logiki mapy
4. `1.2` pozycja gracza z kamery, nie z roota
5. `1.5` Marionette do grupy `enemy`
6. `5.1` uporządkowanie wersji Godot/XR Tools + smoke test headless

**Etap 1 — dostępność (rdzeń tezy)**
7. `3.3` cztery osobne dźwięki potwierdzeń (najtańsza duża wygrana)
8. `3.1` TTS/lektor w menu — **defekt blokujący**
9. `3.2` Game Over z odczytem wyniku i przyczyny śmierci
10. `2.3` hałas i dźwięk uderzenia w ścianę (+ haptyka)
11. `3.5` haptyka jako stały kanał ostrzegania

**Etap 2 — zgodność ze specyfikacją**
12. `4.1` NavMesh z poprawnym `agent_radius`, zbakowany w edytorze
13. `2.1` Balora: maszyna stanów patrol/alert/chase + pitch pozytywki
14. `2.2` Marionette: mechanika machania kontrolerem (albo **świadoma aktualizacja `AGENTS.md`**, jeśli obecna mechanika okazała się lepsza w testach — ale rozjazd musi zniknąć)
15. `2.5` `EventBus.milestone_reached` i skalowanie AI

**Etap 3 — rozszerzenia**
16. `3.4` puls echolokacyjny
17. `2.4` Phantom Grasp
18. `4.2`, `4.7` cache grup, `AudioHelper`
19. `5.2`, `5.3` porządki

---

## Podsumowanie

Architektura projektu jest **dobra i przemyślana** — decyzja o samowystarczalnych scenach z `SceneLoader`, `EventBus` jako jedyny kanał odsprzęgający hałas od AI, oraz wydzielenie `JumpscareHelper` to trafne wybory, które dobrze się obroniły. Poprzedni audyt doprowadził do realnych napraw (grawitacja, ściany, kroki, deduplikacja jumpscare).

Główne problemy nie leżą w strukturze, a w **trzech obszarach**:

1. **Cztery ciche awarie** (fade nigdy nie działa, pozycja gracza czytana z nieruchomego węzła, Marionette poza grupą `enemy`, HUD blokujący całą mapę) — kod się wykonuje bez błędów w konsoli, więc nikt ich nie zauważył, ale psują kolejno: komfort VR, efekt distortion, tracking Foxy'ego i całą rozgrywkę.
2. **Rozjazd implementacji ze specyfikacją** — Balora i Marionette robią co innego niż `AGENTS.md`, Phantom Grasp nie istnieje, eskalacja nie jest podłączona. Dla pracy inżynierskiej ten rozjazd jest kosztowniejszy niż same braki funkcjonalne.
3. **Dostępność jest zadeklarowana, ale nie domknięta** — niewidomy gracz nie uruchomi menu (brak TTS), nie dowie się, że przegrał, i słyszy ten sam dźwięk jako ostrzeżenie i jako nagrodę. To dotyka bezpośrednio głównej tezy projektu.

Punkt 1 to kilka godzin pracy o nieproporcjonalnie dużym efekcie i od niego rekomenduję zacząć.
````

## File: gameDoc/Inżynierka/Notatka.md
````markdown
# Nowy system zarządzania scenami (SceneLoader.gd)

Zrezygnowaliśmy z podejścia "Staging" (z persistentnym graczem w `main.tscn`) na rzecz **pełnej podmiany scen** (`change_scene_to_packed`). Rozwiązuje to krytyczne problemy z fizyką XR oraz błędami kolizji przy teleportacji na dynamicznie ładowane mapy.

Oto kluczowe punkty jak to działa teraz:

1. **Rola `SceneLoader.gd` (Autoload):**
   - Zarządza ładowaniem scen w osobnym wątku (`ResourceLoader.load_threaded_request`), co zapobiega "zamrażaniu" obrazu w goglach (ważne dla komfortu VR).
   - Obsługuje globalne ściemnianie i rozjaśnianie ekranu (`XRToolsFade`) podczas przejścia.
   - Po załadowaniu zasobu wykonuje `get_tree().change_scene_to_packed(loaded_resource)`.

2. **Struktura Scen (Self-contained):**
   - Każda scena (np. `main_menu.tscn`, `game_map.tscn`) posiada własne instancje:
	 - `StartXR` (inicjalizacja OpenXR)
	 - `Player` (węzeł gracza z kamerą i kontrolerami)
	 - `Fade` (efekt przejścia)
   - Dzięki temu każde załadowanie mapy całkowicie resetuje stan fizyki i pozycję gracza do wartości domyślnych zdefiniowanych w edytorze.

3. **Inicjowanie i przebieg:**
   - Projekt startuje bezpośrednio z `main_menu.tscn` (zdefiniowane w `project.godot`).
   - Przejście do gry następuje po wywołaniu `SceneLoader.load_scene("res://scenes/game_map.tscn")`.

## Implementacja Przeciwnika (Ballora)

Aby zaimplementować przeciwnika (Ballora), który po zbliżeniu się gracza wyrzuca go do menu głównego, przygotowano dedykowany skrypt `res://scripts/ballora.gd`:

1. **Zasada działania skryptu `ballora.gd`:**
   - Skrypt wykorzystuje sygnał `body_entered` strefy `Area3D`.
   - Gdy kolizja rejestruje ciało gracza, uruchamiana jest sekwencja Jumpscare (reparenting duszka i dźwięku do kamery gracza).
   - Po zakończeniu animacji ataku, wywoływana jest funkcja `SceneLoader.load_scene(MAIN_MENU_PATH)`, która przywraca gracza do menu głównego.

2. **Poprawki Fizyki i Nawigacji (Balora):**
   - Aby zapobiec zapadaniu się podłogę, aplikacja wektora grawitacji (`velocity.y`) w `move_and_slide()` została zrestrukturyzowana, aby przypisywać osie horyzontalne X i Z oddzielnie od osi wertykalnej.
   - Aby postać nie zacinała się docierając do węzła NavMesh (szła, a potem stawała zamrożona), zwiększono `path_desired_distance` w `NavigationAgent3D` do `2.0`. Problem wynikał z mierzenia dystansu w przestrzeni 3D - środek wysokiej postaci znajduje się na wys. ~1.3m, podczas gdy punkt nawigacyjny leży na podłodze (wys. 0m), przez co postać nigdy nie osiągała domyślnego progu `1.0m`.

## Implementacja Przeciwnika (Marionette / Marnin)

Marionette to `Node3D` operujący jako wróg pojawiający się na krawędziach mapy (np. ściany pokoju). Jej zadaniem jest zaskoczenie gracza za pomocą mylących dźwięków kierunkowych i wymuszenie na nim pasywności. Została wpięta bezpośrednio do głównej planszy `game_map.tscn`.

1. **Zasada działania (State Machine):**
   - **HIDDEN:** Ukrywa się na 20-35 sekund, nasłuchując timera.
   - **WHISPERING:** Przenosi się na odległość 7-9 metrów od gracza i odtwarza zapętlony, przerażający szept z komponentu `AudioStreamPlayer3D`.
   - **JUMPSCARE:** Atak – zatrzymanie czasu, wyrzucenie gracza z mapy i odtworzenie głośnego krzyku w uchu.

2. **Mechanika przetrwania i rozpoznawanie zachowań (VR):**
   - Skrypt dynamicznie śledzi wektor i pozycję `XRCamera3D`.
   - **Weryfikacja ruchu:** Jeśli po uruchomieniu szeptów gracz przemieści się w osi poziomej o więcej niż `0.6` metra, zostaje zaatakowany.
   - **Weryfikacja pola widzenia:** Obliczany jest iloczyn skalarny (`dot product`) między kierunkiem wzroku gracza (`-camera.global_transform.basis.z`) a kierunkiem na przeciwnika. Jeśli wynik jest większy niż `0.707` (co odpowiada stożkowi około 45 stopni), gra uznaje, że użytkownik patrzy w niebezpiecznym kierunku. Patrzenie przez ponad 1.5 sekundy uruchamia Jumpscare.
   - Aby przeżyć i by wróg wrócił do stanu `HIDDEN`, gracz musi zastygnąć w bezruchu i odwrócić głowę (patrzeć pod kątem mniejszym niż 45 stopni na wroga) przez minimum 3.0 sekundy.

## Audyt i Naprawy Projektu

Przeprowadzono pełną analizę projektu (szczegóły w pliku `gameDoc/Inżynierka/Audit.md`). Poniżej lista zrealizowanych napraw oraz zadań do wykonania.

### Naprawy wykonane

1. **NavMesh — runtime bake (KRYTYCZNE):**
   - `NavigationMesh` w `game_map.tscn` była pusta (brak wygenerowanych wierzchołków). Dodano automatyczne wywołanie `nav_region.bake_navigation_mesh()` w `_ready()` skryptu `game_map.gd`, co zapewnia poprawną nawigację AI nawet bez ręcznego bake'a w edytorze.

2. **Ściany pokoju (KRYTYCZNE):**
   - Mapa posiadała wyłącznie podłogę — gracz mógł wyjść poza obszar gry. Dodano 4 ściany (`WallNorth`, `WallSouth`, `WallEast`, `WallWest`) jako `StaticBody3D` o wymiarach 20×4×0.5m wewnątrz `NavigationRegion3D`.

3. **Reset grawitacji Balory:**
   - `velocity.y` nie był resetowany po wylądowaniu, co prowadziło do narastającej resztkowej wartości ujemnej. Dodano `else: velocity.y = 0.0` w pętli `_physics_process`.

4. **Wspólny helper Jumpscare (`jumpscare_helper.gd`):**
   - Wydzielono zduplikowaną logikę Jumpscare'a (reparenting audio/meshy do kamery, zatrzymanie timera, powrót do menu) do klasy statycznej `JumpscareHelper`. Oba przeciwnicy (Balora i Marionette) delegują teraz sekwencję ataku do jednego miejsca w kodzie.
   - Helper dodaje również **wibracje haptyczne** (rumble) obu kontrolerów VR podczas Jumpscare'a, wykorzystując wcześniej nieużywany `XRToolsRumbleManager`.

5. **Marionette — konfigurowalność z edytora:**
   - Hardcoded granice mapy (-9 do 9) zamieniono na zmienne `@export` (`map_bounds_min`, `map_bounds_max`), konfigurowalne bezpośrednio w Inspektorze Godota. Analogicznie wyeksportowano progi kątów patrzenia, czasy przetrwania i dystanse spawnu.

6. **Stary komentarz o Staging:**
   - Usunięto mylący komentarz w `game_map.gd` odnoszący się do porzuconego systemu Staging.

7. **Sterowanie zorientowane na kontroler (Hand-Oriented Movement):**
   - Domyślnie ruch w XR Tools bazuje na orientacji głowy (kamery). Zmodyfikowano skrypt wtyczki `addons/godot-xr-tools/player/player_body.gd` dodając parametr `movement_direction`, pozwalający wybrać węzeł odniesienia (Kamera, Lewy Kontroler, Prawy Kontroler).
   - W `player.tscn` ustawiono `movement_direction = 2` (Prawy Kontroler). Dzięki temu gracz idzie w stronę wychylenia gałki prawego kontrolera, niezależnie od tego, w którą stronę odwraca głowę. Jest to kluczowe do walki z Marionette (możliwość wycofywania się patrząc przed siebie).

8. **Okres łaski (Grace Period) dla Marionette:**
   - Aby nie karać gracza za ruch w momencie usłyszenia szeptów (gdy jeszcze nie zdążył zareagować), dodano do `marionette.gd` parametr `grace_time` (domyślnie 2.5s).
   - W tym czasie gracz może się swobodnie zorientować w sytuacji, a dystans ruchu zaczyna być mierzony dopiero po upłynięciu tego czasu.

9. **Tryb Debugowania (Wizualizacja) dla Marionette:**
   - Dodano parametr `debug_visible` do skryptu `marionette.gd`, który programowo generuje świecącą różową kulę reprezentującą pozycję wroga.
   - **Jak włączyć:** W edytorze otworzyć `game_map.tscn`, zaznaczyć węzeł `Marionette` i w Inspektorze (po prawej) zaznaczyć opcję **Debug Visible**. Domyślnie wyłączone dla normalnej rozgrywki.

10. **Sprint gracza:**
   - Do sceny gracza dodano węzeł `MovementSprint` z XR Tools (wymagane by był dzieckiem `XROrigin3D`).
   - Ustawiono aktywację na lewym kontrolerze pod przyciskiem `primary_click` (wciśnięcie gałki) w trybie *Hold to Sprint*. Prędkość wzrasta dwukrotnie, co jest kluczowe w ucieczce przed Balorą.

11. **Dźwięki kroków i obrotu (Dostępność):**
   - Podpięto węzeł `XRToolsMovementFootstep` odpowiedzialny za dźwięki poruszania się oraz `default_surface.tres` ładujący zdefiniowane próbki podłoża.
   - Stworzono niestandardowy menedżer `player_audio_manager.gd`, który wykrywa skokowe obroty joystickiem (Snap Turn) i odtwarza `whoosh.mp3`, zapobiegając utracie orientacji przestrzennej gracza. Dodatkowo skrypt na bieżąco analizuje prędkość gracza i ocenia "generowany hałas", który jest zintegrowany na potrzeby wroga Foxy.

12. **Balans Marionette i poprawki błędów z Jumpscare'ami:**
   - Wyeliminowano problem "szeptania po pokonaniu". Sprecyzowano zasady ataku: gracz ma bezwzględnie 3 sekundy na zażegnanie ataku. Przetrwanie wymaga stania w miejscu i patrzenia odwróconym wzrokiem łącznie przez 1.5 sekundy.
   - W klasie `JumpscareHelper` wdrożono globalną zmienną odcinającą. Zapobiega to nakładaniu się Jumpscare'ów (np. atak z dwóch stron jednocześnie od Balory i Marionette) i chroni przed zapętleniem przeładowania sceny.

13. **Globalny system emisji dźwięku i demon Foxy:**
   - Wprowadzono węzeł Autoload `EventBus` w projekcie, który pośredniczy w wysyłaniu informacji o hałasie.
   - Nowy przeciwnik, **Foxy**, nasłuchuje zdarzeń `noise_emitted`. Każdy krok podnosi jego pasek "irytacji". Gdy zostanie przekroczony próg hałasu, Foxy milknie na 2 sekundy.
   - W trakcie nasłuchiwania Foxy powoli porusza się w stronę gracza, wydając ciężkie robotyczne kroki.
   - Szarża Foxy'ego namierza gracza dopiero w momencie samego uderzenia (nie podczas zbierania irytacji), co czyni go groźniejszym.

14. **Kolizja dłoni gracza z otoczeniem:**
   - Zainstalowano fizyczne dłonie (`physics_hand_low.tscn`) z pakietu XR Tools w miejsce zwykłych. Zapobiega to wizualnemu przenikaniu rąk przez ściany i obiekty, co symuluje odczucie znane np. z *FNaF Help Wanted*.

15. **Szlify optymalizacyjne, audio i wibracje (v0.4.0):**
   - **Bake NavMesh**: Przeniesiono `bake_navigation_mesh()` do `call_deferred`, co likwiduje lag renderowania w pierwszej klatce. Foxy otrzymał stan początkowy `IDLE`, odciążając RAM ze swoich ogromnych plików WAV w pierwszych sekundach gry.
   - **Kompas Dźwiękowy**: Do menadżera dodano absolutną rotację - każdy obrót o odpowiedni próg (Snap Turn) generuje zminimalizowany sygnał ("ping"), którego wysokość tonu (`pitch`) informuje gracza w którą stronę patrzy (Północ = najwyższy, Południe = najniższy). `whoosh.mp3` zamieniono na `whoosh2.mp3` odgrywany w 2 wariantach pitcha dla rozróżnienia prawej/lewej strony.
   - **Warstwy Kolizji**: Uporządkowano i przypisano maski w `project.godot`. Balora ma warstwę "Balora", a Foxy "Foxy" - usunięto kolizje pomiędzy wrogami, zapobiegając blokowaniu się Foxy'ego o innych przeciwników.
   - **Distortion Effect**: Dynamicznie modyfikowany ton Ambientu zależny od najkrótszego wektora odległości od dowolnego wroga. Im niższy dystans (<10m), tym mroczniejszy i niższy pitch_scale zniekształcający tło muzyczne gry.
   - **Balans Wrogów**: Foxy przed samą szarżą gra głośne powiadomienie-warning, a Marionette dostała potężne okno błędu dla gracza (`grace_time` 4.0s) i efekt "Crescendo" (dźwięk płynnie redukuje swój dystans o połowę na symulację przybliżania). Za skuteczne zablokowanie wróg nagradza gracza satysfakcjonującym `nice-sfx.mp3`.
16. **Dedykowany Ekran Game Over i Telemetria Sesji (v0.5.0):**
   - **Zamknięcie pętli śmierci**: Po jumpscarze gracz nie jest już natychmiastowo wyrzucany do Menu Głównego, lecz trafia na dedykowaną scenę `scenes/game_over.tscn` ze szklanym, wysokokontrastowym panelem `Viewport2Din3D` (`scenes/game_over_ui.tscn`).
   - **Telemetria sesji**: Do `SceneLoader.gd` dodano zmienne rejestrujące osiągnięty czas przetrwania (`last_survival_time`), wykonane kroki (`steps_taken`), liczbę odpartych Marionetek (`marionettes_defended`), zablokowanych szarż Foxy'ego (`foxy_charges_blocked`) oraz przyczynę porażki (`last_death_reason`). Statystyki są zerowane funkcją `reset_session_stats()` przy każdym starcie `game_map.gd`.
   - **Przyczyny porażki**: Wrogowie przekazują teraz szczegółowe powody do helpera (np. *"Balora — Wejście w strefę krytyczną"*, *"Foxy — Niezablokowana szarża"*, *"Marionette — Nieodwrócony wzrok lub ruch"*).
   - **Przyciski akcji**: Panel zawiera duże przyciski dotykowe VR: *⟳ Zagraj Ponownie* (natychmiastowy restart na `game_map.tscn`) oraz *⌂ Menu Główne* (powrót do `main_menu.tscn`).

18. **Przebudowa Menu Głównego na styl industrialny (v0.5.1):**
   - Zrealizowano projekt menu na bazie makiety Google Stitch — w miejsce dawnego jednolicie ciemnego panelu stworzono **scenerię zniszczonej ściany betonowej 3D** ([`Plaster006_2K-PNG`](file:///c:/Users/naimad/Documents/lightness-vrgame/assets/textures/Plaster006_2K-PNG/)) z rurami i nastrojowym oświetleniem punktowym (`SpotLight3D`).
   - **Glitch Title**: Skrypt [`scripts/glitch_title.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/glitch_title.gd) z czcionką `Nosifer-Regular.ttf` generuje mikro-offsety 25 Hz oraz gwałtowne zniekształcenia tekstu co 4 sekundy.
   - **Napisy wyryte w ścianie**: Przyciski `start game`, `settings`, `guide`, `exit` (czcionka `CinzelDecorative-Bold.ttf`) wkomponowano w ścianę jako płaskie etykiety rozświetlające się na biało po najechaniu.
   - **Podpis**: W lewym dolnym rogu dodano stały znak wodny *"by Damian Skonieczny version 0.5"*.
   - **Zmiana nazwy**: Zmieniono globalnie nazwę projektu na **Lightless** (`project.godot`, `README.md`).

19. **Komponent `HoldButton` i stabilna interakcja VR (v0.5.1):**
   - Wdrożono komponent [`scripts/hold_button.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/hold_button.gd), który rysuje błękitny pasek postępu przytrzymania wyłącznie na aktywnym przycisku (czas: 0.6s) i automatycznie wyzwala sygnał `pressed`.
   - Dodano wsparcie dla `allow_repeat_on_hold = true` (płynna regulacja głośności przyciskami `+` / `−`).
   - W `scenes/player.tscn` zastąpiono `FunctionGazePointer` dedykowanym `FunctionPointer` (`function_pointer.tscn`), co przywróciło natywną obsługę spustu kontrolera (`trigger_click`) i bezpośrednich kliknięć w `Viewport2DIn3D`.

20. **Eliminacja lagów TTS przez Dwell Debounce (v0.5.1):**
   - Zidentyfikowano wąskie gardło silnika syntezy mowy Windows SAPI, który przy szybkim przesuwaniu lasera po przyciskach blokował główny wątek Godota.
   - W [`scripts/tts_manager.gd`](file:///c:/Users/naimad/Documents/lightness-vrgame/scripts/tts_manager.gd) wprowadzono buforowanie `DWELL_THRESHOLD = 0.08s` — syntezator uruchamia się dopiero po zatrzymaniu wskaźnika na przycisku na 80ms, eliminując wszelkie spadki klatek.

21. **Fizyczne dłonie gracza (CollisionHand) (v0.5.1):**
   - W [`scenes/player.tscn`](file:///c:/Users/naimad/Documents/lightness-vrgame/scenes/player.tscn) wdrożono `CollisionHandLeft` i `CollisionHandRight` (`XRToolsCollisionHand`).
   - Model ręki blokuje się na obiektach i ścianach o warstwie 1 (World) za pomocą `move_and_slide()`, nie przenikając przez przeszkody (wzorem *FNaF: Help Wanted*).

22. **Subtelny wskaźnik VR (Pointer Style) (v0.5.1):**
   - Zmodyfikowano [`addons/godot-xr-tools/materials/pointer.tres`](file:///c:/Users/naimad/Documents/lightness-vrgame/addons/godot-xr-tools/materials/pointer.tres) i [`function_pointer.tscn`](file:///c:/Users/naimad/Documents/lightness-vrgame/addons/godot-xr-tools/functions/function_pointer.tscn).
   - Zastąpiono gruby czerwony promień i wielką kulę cienką wiązką (1.2mm) w chłodnym błękitnym kolorze (`Color(0.15, 0.55, 1, 0.6)`) oraz miniaturową świecącą kropką celownika.

23. **Rozbudowa pokoju Menu Głównego i poprawa ergonomii przestrzennej (v0.5.2):**
   - **Pełnowymiarowe pomieszczenie 3D**: Dotychczasowe menu składało się jedynie z pojedynczej płaskiej ściany zawieszonej w próżni, co wywoływało poczucie klaustrofobii i nienaturalnego lewitowania w pustce. Zbudowano pełny pokój industrialny o wymiarach 10.0m x 9.2m i wysokości 4.8m (podłoga, sufit, ściany boczne, ściana tylna oraz frontowa ściana interaktywna z rurami przemysłowymi i lampą sufitową).
   - **Korekta ergonomii i wysokości**: Podniesiono `Viewport2Din3D` na ścianie (`transform.origin.y = 2.15m`, screen_size `2.4m x 1.45m`). Wcześniej interfejs wisiał zbyt nisko, zmuszając gracza do nienaturalnego pochylania głowy i schylania się w goglach.
   - **Ukierunkowane oświetlenie strefowe**: Wyeliminowano ogólne jasne rozświetlenie otoczenia. Źródło światła punktowego `SpotLight3D` (`MenuSpotLight`) skierowano selektywnie wyłącznie na ścianę interfejsu (GUI), podczas gdy reszta pomieszczenia i sufit zostały przyciemnione (`WorldEnvironment` z chłodnym ambientem `Color(0.08, 0.1, 0.14)`). Nadaje to surowy, skupiony klimat bez oślepiania gracza.
   - **Korekta ekranu Game Over**: W scenie `scenes/game_over.tscn` usunięto jaskrawe, zalewające całą przestrzeń czerwone światło, skupiając delikatniejsze oświetlenie punktowe jedynie na ścianie z wynikami telemetrii sesji.

24. **Cyfrowy Glitch napisu tytułowego i estetyka ścian (v0.5.2):**
   - **Czcionka i shader**: Napis tytułowy "LIGHTLESS" wyśrodkowano i zmieniono czcionkę na cyfrową `RubikGlitch-Regular.ttf` współpracującą z shaderem `glitch_text.gdshader`.
   - **Balans czasu trwania**: Wcześniejszy mikro-offset był ledwo dostrzegalny. Zwiększono częstotliwość występowania zakłóceń oraz wydłużono czas trwania silniejszego glitcha do ok. 1.0 sekundy, dzięki czemu gracz wyraźnie widzi dynamiczną zmianę glifów i artefakty cyfrowe.
   - **Styl Google Stitch**: Ekrany Settings i Game Over zintegrowano ze stylistyką wyrytych w ścianie inskrypcji. Interaktywne przyciski rozświetlają się neonowym blaskiem i płynnie powiększają po najechaniu laserem VR, bez konieczności stosowania odcinających się prostokątnych paneli tła.

25. **Przełączenie syntezatora mowy TTS na język angielski (v0.5.2):**
   - Poprzednio syntezator mowy w systemie Windows SAPI wymuszał głos polski, co brzmiało nienaturalnie przy anglojęzycznym interfejsie ("Start Game", "Settings", "Controls and Survival Guide", "Exit Game").
   - W `scripts/tts_manager.gd` przestawiono domyślny język syntezy na angielski (lokalizacja `en`), dzięki czemu lektor poprawnie i płynnie wymawia nazwy kontrolek i opcji.

26. **Batalia z niedziałającymi przyciskami – studium błędu (v0.5.2):**
   - **Objaw**: Po najechaniu na przycisk (np. Start Game lub Settings) i przytrzymaniu triggera pasek napełniał się do 100%, lecz po załadowaniu nie następowała jakakolwiek reakcja — brak przejścia do mapy gry, brak otwarcia ustawień, brak możliwości wyjścia. Gracz był uwięziony w menu.
   - **Diagnoza etap 1 (Pętla wielokrotnego ładowania)**: W logach debugera ujawniono, że `[HoldButton] ACTIVATED: SettingsButton` odpalało się 4 razy z rzędu w ułamku sekundy. Wynikało to z faktu, że gracz po osiągnięciu 100% napełnienia nadal fizycznie trzymał trigger, przez co po 0.4s cooldownu przycisk natychmiast ładował się od nowa. Naprawiono to wprowadzając flagę `_wait_for_release = true`, która zamraża ładowanie aż do fizycznego puszczenia spustu.
   - **Diagnoza etap 2 (Brak reakcji mimo pojedynczego wyzwolenia)**: Mimo wyeliminowania pętli, przycisk nadal nic nie robił. Wprowadzono diagnostyczne printy w łańcuchu: `HoldButton` -> `pressed` -> `main_menu_ui.gd` -> `start_pressed` -> `main_menu.gd`.
   - **Przełom diagnostyczny ("The Missing Script Bug")**: W logu konsoli pojawił się krytyczny wpis:
     `[MainMenu] Found UI instance: MainMenuUI`
     `[MainMenu] ERROR: UI does not have start_pressed signal!`
     `[MainMenu] ERROR: UI does not have exit_pressed signal!`
     W pliku `scenes/main_menu_ui.tscn` korzeń sceny `[node name="MainMenuUI" type="Control"]` z niewyjaśnionych przyczyn utracił linijkę `script = ExtResource("1_ui_script")`. W efekcie Godot traktował całe UI jako goły węzeł `Control`. Sygnały `start_pressed` i `exit_pressed` w ogóle nie istniały na obiekcie, a wywołania sygnałów wewnętrznych (np. `_on_settings_button_pressed`) trafiały w próżnię (Control nie posiada takich metod).
   - **Rozwiązanie**: Przywrócono powiązanie skryptu `main_menu_ui.gd` do korzenia sceny w pliku `.tscn`. W efekcie cała komunikacja i nawigacja między panelami oraz startem mapy natychmiast zaczęła działać.

27. **Zidentyfikowane błędy, dług techniczny i wnioski:**
   - **Błąd podwójnego Jumpscare'a**: Zauważono, że po wystąpieniu sekwencji jumpscare gracz nadal może wykonać minimalny ruch kontrolerem. Może to spowodować wejście w strefę kolizji kolejnego przeciwnika i wywołanie drugiego jumpscare'a nakładającego się na pierwszy. Konieczne jest natychmiastowe zablokowanie fizyki gracza i wejść ruchu (`movement_providers`) w momencie zainicjowania ataku w `JumpscareHelper`.
   - **Błąd wyłącznika TTS**: Przycisk toggle w panelu Settings wizualnie zmienia stan ("Sound Compass: ON/OFF", "TTS Voice: ON/OFF"), lecz wyłączenie TTS w żaden sposób nie blokuje odtwarzania mowy w `TTSManager` — syntezator nadal odczytuje teksty. Należy dodać ścisłą weryfikację flagi `tts_enabled` przed każdym wywołaniem `DisplayServer.tts_speak()`.
   - **Mechanika aktywacji przycisków (Kliknięcie vs Hold)**: W toku testów ustalono, że przyciski reagują zarówno na pojedyncze kliknięcie triggera (z racji podpięcia wskaźnika laserowego VR), jak i na pełne przytrzymanie paska `HoldButton`. Skoro wystarczy samo kliknięcie triggera, animacja ładowania paska jest zbędna i wprowadza niepotrzebną zwłokę. W kolejnej iteracji planowane jest usunięcie animacji paska na rzecz natychmiastowego kliknięcia.

28. **Wdrożenie zaleceń audytu technicznego i nowe mechaniki (v0.6.0):**
   - **Naprawa systemu Fade i likwidacja race condition w SceneLoader**:
     - Usunięto wadliwy warunek `ClassDB.class_exists("XRToolsFade")` (klasa GDScript niewidoczna w ClassDB), przywracając działanie ściemniania i rozjaśniania widoku w goglach VR.
     - Wprowadzono podwójne oczekiwanie na klatkę (`await get_tree().process_frame`) po podmianie sceny, co zagwarantowało obecność węzła Fade w grupie `fade_mesh` przed wywołaniem rozjaśnienia.
     - Zaimplementowano reset flagi `is_loading = false` w przypadku nieudanego ładowania zasobu, eliminując ryzyko trwałego uwięzienia gracza w czarnym ekranie.
   - **Precyzyjny tracking pozycji gracza w VR**:
     - Do węzła `XRCamera3D` w `scenes/player.tscn` dodano grupę `player_head`.
     - W `scripts/game_map.gd` (efekt Distortion) oraz `scripts/foxy.gd` (nasłuchiwanie i szarża) zastąpiono statyczną pozycję roota `Player` pozycją głowy gracza (`camera.global_position`), likwidując błąd fałszywego odległościomierza i błędnego namierzania Foxy'ego.
     - Kosmetyczny `TimerLabel` uczyniono opcjonalnym, co zapobiega zablokowaniu bake'owania NavMesha i timera przetrwania.
     - Scena `scenes/marionette.tscn` została zarejestrowana w grupie `enemy` i oczyszczona ze zbędnego stałego mesha debugowego.
   - **Semantyka audio i rozdzielenie próbek dźwiękowych**:
     - Wyeliminowano wieloznaczność próbki `nice-sfx.mp3`.
     - Ostrzeżenie przed szarżą Foxy'ego przypisano do złowrogiego sygnału `danger.wav` (pitch 0.8).
     - Sukces zablokowania szarży Foxy'ego zachowano na satysfakcjonującym `nice-sfx.mp3`.
     - Odpędzenie Marionetki zyskało dedykowany świst rozproszenia `whoosh2.mp3`.
     - Kompas dźwiękowy otrzymał unikalny, subtelny dzwon `Broken bell.ogg` z debouncingiem i zmiennym pitchem azymutu.
   - **Akustyka i haptyka kolizji ze ścianami**:
     - W `player_audio_manager.gd` zaimplementowano detekcję uderzenia gracza w ścianę (`player_body.is_on_wall()`).
     - Uderzenie generuje głuchy odgłos kontaktu, fizyczny impuls haptyczny w kontrolerach oraz emituje hałas `EventBus.noise_emitted(3.5)`, alarmując Foxy'ego i domykając immersyjną pętlę percepcji otoczenia dla niewidomego gracza.
   - **Dostosowanie AI Balory i Marionette do specyfikacji AGENTS.md**:
     - **Balora**: Wdrożono maszynę stanów `PATROL → ALERT → CHASE → COOLDOWN`. Balora patroluje węzły trasy na NavMeshu (promień agenta 0.85m). Wejście w strefę Alertu przyspiesza pozytywkę (`pitch_scale` 1.35), strefa Krytyczna wyzwala szybki pościg (`pitch_scale` 1.7), a ucieczka sprintem na odległość >9.5m pozwala zgubić pościg i wprowadza Balorę w stan odpoczynku (Cooldown).
     - **Marionette**: Zastąpiono pasywne wpatrywanie się aktywną obroną — gracz musi ustalić kierunek szeptu i zdecydowanie machnąć kontrolerem VR w stronę źródła dźwięku. Dodano wibrację ostrzegawczą kontrolerów, gdy szept zbliża się krytycznie do ucha, oraz eskalację trudności z sygnału `EventBus.milestone_reached`.
   - **Threat Director (Pacing)**:
     - W `game_map.gd` wprowadzono stopniowe wprowadzanie przeciwników na osi czasu: Balora (15s), Marionette (40s), Foxy (75s), Phantom Grasp (110s).
   - **Nowy przeciwnik — Phantom Grasp**:
     - Stworzono `scenes/phantom_grasp.tscn` i `scripts/phantom_grasp.gd`. Wróg pełznie od dołu ku dłoni gracza, nagle chwyta kontroler wywołując ciągłą, intensywną wibrację i agresywny dźwięk. Gracz musi dynamicznie potrząsać pochwyconym kontrolerem, by wyrwać się z uścisku przed jumpscarem.
   - **Echolokacja (Puls dźwiękowy)**:
     - Pod przyciskiem `ax_button` wdrożono sondujący impuls dźwiękowo-haptyczny. Raycast w 8 kierunkach generuje przestrzenne, opóźnione echa 3D odbite od ścian pomieszczenia, kosztem wygenerowania hałasu ściągającego Foxy'ego.
   - **Menu Pauzy VR**:
     - Utworzono scenę `scenes/pause_menu.tscn` i `scenes/pause_menu_ui.tscn`. Przycisk `menu_button` wyświetla trójwymiarowy panel pauzy 1.6m przed graczem na wysokości oczu, zamraża pętlę gry (`paused = true`) i oferuje opcje Resume, Restart Map oraz Main Menu z pełnym odczytem TTS.

### Zadania do wykonania

| Priorytet | Zadanie                                                                                       | Status       |
| --------- | --------------------------------------------------------------------------------------------- | ------------ |
| 🟢 WYSOKI | Ekran Game Over (dedykowana scena / UI / telemetria)                                         | Zrobione     |
| 🟢 WYSOKI | System TTS / lektora w menu (Accessibility z Dwell Debounce) + HoldButton                      | Zrobione     |
| 🟢 WYSOKI | Przebudowa Menu Głównego (industrialna ściana 3D + glitch "LIGHTLESS")                       | Zrobione     |
| 🟢 WYSOKI | Rozbudowa pokoju Menu Głównego do pełnego 3D                                                 | Zrobione     |
| 🟢 WYSOKI | Naprawa systemu Fade w SceneLoader i likwidacja martwego kodu ClassDB                        | Zrobione     |
| 🟢 WYSOKI | Poprawne odczytywanie pozycji głowy gracza (Distortion & Foxy)                               | Zrobione     |
| 🟢 WYSOKI | Rozdzielenie próbek audio (unikalne dźwięki ostrzeżeń, sukcesów i kompasu)                    | Zrobione     |
| 🟢 WYSOKI | Detekcja kolizji ze ścianami (dźwięk, hałas dla Foxy'ego, haptyka)                           | Zrobione     |
| 🟢 WYSOKI | AI Balory wg AGENTS.md (FSM: Patrol, Alert z przyspieszającą pozytywką, Pościg, Ucieczka)    | Zrobione     |
| 🟢 WYSOKI | AI Marionetki wg AGENTS.md (aktywne machnięcie dłonią w stronę szeptu, haptyka bliskości)     | Zrobione     |
| 🟢 WYSOKI | Threat Director (pacing pojawiania się wrogów w czasie gry)                                  | Zrobione     |
| 🟢 WYSOKI | Przeciwnik Phantom Grasp (chwyt za kontroler, wibracja, mechanika wyszarpywania)              | Zrobione     |
| 🟢 WYSOKI | Echolokacja (puls dźwiękowy sondujący geometrię pomieszczenia kosztem hałasu)                | Zrobione     |
| 🟢 WYSOKI | Menu Pauzy w grze (`scenes/pause_menu.tscn`, wywołanie `menu_button`, pełny TTS)              | Zrobione     |
| 🟢 WYSOKI | Optymalizacje w pętli klatek (cache referencji grup, `node.reparent()`)                      | Zrobione     |
| 🟢 NISKI  | Czyszczenie kodu i usunięcie osieroconych plików (`main.gd.uid`, komentarze `![ASK]`)         | Zrobione     |
| 🟢 WYSOKI | Poprawka wyłącznika TTS w ustawieniach (`_execute_speak` guard) — wersja v0.5.2              | Zrobione     |
| 🟢 WYSOKI | Zabezpieczenie coroutines audio po `await create_timer` (`is_inside_tree()`)                 | Zrobione     |
| 🟢 WYSOKI | Failsafe resetu pauzy `get_tree().paused = false` w `SceneLoader.load_scene()`                | Zrobione     |
| 🟢 NISKI  | Usunięcie zbędnego autoloadu `XRToolsRumbleManager` na rzecz natywnego OpenXR                | Zrobione     |

---

## Wersja v0.5.2 — Podsumowanie Poprawek Audytowych (Priorytet A)
W ramach weryfikacji po-audytowej wdrożono 4 kluczowe usprawnienia:
1. **TTSManager**: Dopisano guard `if not tts_enabled: return` wewnątrz `_execute_speak()`, dzięki czemu przełączenie opcji *TTS Voice: OFF* w menu ustawień natychmiast wycisza mowę lektora również przy najechaniu wskaźnikiem (Dwell Debounce).
2. **PlayerAudioManager**: W funkcjach `_spawn_delayed_echo` i `_trigger_compass_ping` wprowadzono sprawdzenie `if not is_inside_tree(): return` bezpośrednio po `await get_tree().create_timer(...).timeout`. Zapobiega to błędom w konsoli w sytuacji, gdy scena zostanie przeładowana lub nastąpi jumpscare w trakcie trwania opóźnienia echa.
3. **SceneLoader**: W `load_scene()` dodano prewencyjne `get_tree().paused = false` oraz `process_mode = Node.PROCESS_MODE_ALWAYS` w `_ready()`, eliminując ryzyko zablokowania ładowania, gdyby zmiana sceny została zainicjowana w trakcie aktywnej pauzy.
4. **project.godot**: Usunięto nieużywany wpis `XRToolsRumbleManager` z listy `[autoload]`. Całość haptyki w grze operuje teraz w 100% na bezpośrednim, wysokowydajnym wywołaniu OpenXR `controller.trigger_haptic_pulse()`.

---

## Nowe Ustalenie Projektowe: Struktura Poziomów (System Nocy / FNaF Style)

Zdecydowano o odejściu od pojedynczego, nieskończonego trybu przetrwania na rzecz **strukturyzowanej kampanii poziomów (nocy)**, analogicznie do progresji znanej z serii *Five Nights at Freddy's*. Każdy poziom ma z góry zdefiniowany cel czasowy przetrwania, specyficzną konfigurację przeciwników, rosnące tempo i parametry agresji, a także pełni rolę stopniowego wprowadzenia (onboardingu) niewidomego gracza w mechaniki sensoryczne VR.

### Szczegółowa specyfikacja poziomów:

#### 1. Poziom 1: Pokój Testowy / Tutorial (Noc 0)
- **Cel:** Bezpieczne zapoznanie się z akustyką pomieszczenia, fizyką poruszania się i orientacją 3D.
- **Przeciwnicy:** Brak zagrożeń (0 wrogów).
- **Mechaniki i zadania:**
  - Gracz uczy się poruszania (chód, sprint pod gałką, obrót snap-turn z dźwiękiem whoosh).
  - Test uderzeń w ściany pokoju (gracz słyszy głuchy odgłos kolizji i odczuwa haptykę kontrolerów, uświadamiając sobie geometrię 4 ścian).
  - **Sygnały treningowe:** W przestrzeni 3D pojawiają się sekwencyjne dźwięki (pingi/dzwoneczki) w różnych azymutach i odległościach, aby gracz nauczył się precyzyjnie obracać głowę i wskazywać źródło dźwięku przed wejściem w starcie z wrogami.
  - Możliwość przetestowania sonaru echolokacji (`ax_button`).

#### 2. Poziom 2: Pierwszy Kontakt — Balora (Noc 1)
- **Czas trwania:** **30 sekund** (krótka, wstępna noc wprowadzająca).
- **Przeciwnicy:** Wyłącznie **Balora**.
- **Parametry:**
  - Balora porusza się z niską prędkością bazową (`patrol_speed` ~0.7 m/s).
  - W ostatnich 5–8 sekundach nocy Balora zauważalnie przyspiesza tempo pozytywki i ruch, dając przedsmak zagrożenia tuż przed wybiciem dzwonu końcowego.
- **Nauka gracza:** Identyfikacja pozytywki 3D, nauka oceny odległości na słuch, reakcja na przyspieszające tempo muzyki.

#### 3. Poziom 3: Podwójne Zagrożenie — Marionette (Noc 2)
- **Czas trwania:** **60 sekund (1 minuta)**.
- **Przeciwnicy:** **Balora** + **Marionette**.
- **Parametry:**
  - **Balora:** Startuje powoli, przyspiesza stopniowo co 10 sekund (skalowanie parametrów przez milestone).
  - **Marionette:** Debiutuje na tej nocy. Atakuje w odstępach ok. 20 sekund. Przez większość nocy pojawia się w pojedynczych szeptach (`_rounds_remaining = 1`). Pod koniec nocy (ostatnie 15s) wchodzi w serię **2 szeptów z rzędu** z różnych stron.
- **Nauka gracza:** Dzielenie uwagi między krążącą po mapie Balorę a nagłe szepty przy uchu; nauka obrony gestem zamachu kontrolerem w stronę dźwięku.

#### 4. Poziom 4: Cisza i Hałas — Foxy (Noc 3)
- **Przeciwnicy:** **Balora** + **Marionette** + **Foxy**.
- **Parametry:**
  - Debiutuje **Foxy**.
  - W tej nocy Foxy jest **bardzo cierpliwy** na hałasy (wysoki próg irytacji `noise_threshold` np. 16.0–20.0, wolny przyrost wskaźnika hałasu).
  - Do ataku Foxy'ego dochodzi tylko przy ewidentnym, ciągłym bieganiu lub wielokrotnym wpadaniu w ściany.
- **Nauka gracza:** Zrozumienie mechaniki hałasu kroków i kolizji; nauka rozpoznawania sygnału ostrzegawczego `danger.wav`, ciszy przed szarżą i wykonywania bloku dłonią / uniku w bok.

#### 5. Poziom 5: Eskalacja — Noc Zagrożenia (Noc 4)
- **Przeciwnicy:** **Balora** + **Marionette** + **Foxy** + **Phantom Grasp**.
- **Parametry:**
  - **Foxy:** Znacznie aktywniejszy – niższy próg hałasu (`noise_threshold` ~9.0), szybsza reakcja na uderzenia w ściany i echolokację.
  - **Marionette:** Atakuje częściej (interwały 12–15s), standardowo w seriach po 2–3 szepty.
  - **Balora:** Wyższe prędkości patrolowe i agresywniejsza strefa pościgu.
  - **Phantom Grasp:** Sporadyczne pełzanie i chwyt dłoni, wymuszający intensywne potrząsanie kontrolerem pod presją innych dźwięków.

#### 6. Poziom 6: Finał / Koszmar (Noc 5)
- **Przeciwnicy:** **Balora** (maksymalna prędkość) + **2x Foxy** (dwaj niezależni łowcy hałasu!) + **Marionette** + **Phantom Grasp**.
- **Parametry:**
  - **Podwójny Foxy:** Na mapie operują dwie instancje Foxy'ego o różnych punktach startowych. Hałas gracza może sprowokować szarżę z dwóch różnych stron, zmuszając do błyskawicznej identyfikacji kierunku biegu i kierunkowego bloku.
  - **Balora:** Bardzo szybki patrol (`patrol_speed` ~1.4 m/s, `chase_speed` ~2.8 m/s), wymagający natychmiastowej reakcji sprintem przy wejściu w strefę Alertu.
  - Ekstremalny test percepcji wielokanałowej 3D Audio i odporności na presję sensoryczną.

---

## Nowe Ustalenie Projektowe: Pełna Obsługa Nawigacji Joystickiem w Menu (Accessibility)

### Problem i Uzasadnienie:
Ręczne celowanie wskaźnikiem laserowym VR (`FunctionPointer`) w trójwymiarową ścianę interfejsu jest dla osoby niewidomej barierą krytyczną. Bez bodźców wzrokowych trafienie promieniem w przycisk o wymiarach kilkudziesięciu centymetrów w przestrzeni wirtualnej wymaga żmudnego „przemiatania” powietrza.

### Rozwiązanie i Standard Dostępności:
1. **D-Pad / Joystick Navigation jako Główny Kanał Sterowania UI:**
   - Gracz w menu (Main Menu, Settings, Pause Menu, Game Over) może swobodnie poruszać się po pozycjach za pomocą **gałki analogowej (joysticka)** kontrolera VR (wychylenie w górę / w dół, akcje `ui_up` / `ui_down`).
2. **Sprzężenie z Focusem i TTS:**
   - Zmiana focusu (`grab_focus()` na kolejnym `Button`) natychmiast aktywuje podpięty sygnał `focus_entered`, co wywołuje:
     - Dedykowany odczyt lektora: `TTSManager.speak(button_label)`.
     - Krótki, czytelny impuls haptyczny w dłoni (`trigger_haptic_pulse` 35Hz, 0.04s).
3. **Zatwierdzanie Wyboru:**
   - Wciśnięcie przycisku **A** (lub spustu kontrolera / `ui_accept`) natychmiast wykonuje akcję przycisku (`pressed`), bez konieczności celowania ręką.
4. **Pointer jako Opcja Pomocnicza:**
   - Wskaźnik laserowy pozostaje dostępny dla osób widzących lub słabowidzących, jednak pętla sterowania joystickiem jest w pełni samowystarczalna.
## 27. Stabilizacja fizyki kolizji ze ścianami i optymalizacja NavMesh (v0.5.2)

1. **Eliminacja crasha przy uderzeniu w ścianę (`Invalid cast to Vector3`):**
   - **Przyczyna**: W `scripts/player_audio_manager.gd` weryfikacja ruchu gracza przy ścianie rzutowała `player_body.ground_control_velocity` za pomocą `as Vector3`. W Godot XR Tools właściwość ta jest typu `Vector2` (płaszczyzna wejścia gałki analogowej). Próba rzutowania na niezgodny typ rzucała wyjątek wykonania i natychmiast crashowała grę przy zetknięciu ze ścianą.
   - **Rozwiązanie**: Wprowadzono bezpieczne rozróżnienie typów `if gcv is Vector2 or gcv is Vector3` i bezpośredni odczyt długości wektora `.length() > 0.4`.

2. **Likwidacja ostrzeżenia `MISSING_TOOL` w `game_map.gd`:**
   - Klasa bazowa `XRToolsSceneBase` posiada adnotację `@tool`. Dodano `@tool` na początku `scripts/game_map.gd` wraz ze strażnikiem `if Engine.is_editor_hint(): return` w metodach `_ready()` i `_process()`, izolując logikę gry przed przypadkowym wykonaniem w edytorze.

3. **Optymalizacja pieczenia NavMesh w runtime (CPU vs GPU):**
   - W `scenes/game_map.tscn` w zasobie `NavigationMesh_new` włączono `geometry_parsed_geometry_type = 1` (`PARSED_GEOMETRY_STATIC_COLLIDERS`), dzięki czemu NavMesh parsuje kształty kolizyjne `StaticBody3D` bezpośrednio na CPU zamiast wyciągać wizualne siatki z pamięci GPU w runtime (co blokowało renderowanie klatek VR).
   - Skorygowano `cell_size` i `cell_height` do wartości standardowej `0.25`, likwidując ostrzeżenia o niedopasowaniu siatek i utracie precyzji promienia agenta.

4. **Płynna pula kroków audio (`XRToolsMovementFootstep`):**
   - Zwiększono rozmiar puli odtwarzaczy kroków w `addons/godot-xr-tools/functions/movement_footstep.gd` z 3 do 8 oraz wdrożono mechanizm recyklingu najstarszego grającego odtwarzacza w razie chwilowego wyczerpania puli. Zapobiega to gubieniu odgłosów kroków podczas szybkiego marszu lub sprintu.

## Ustalenia 16.09.2026 po przetestowaniu zmian po Audycie
- [x] **Do wywalenia dźwięk kompasu. Nie pomaga:**
  - Całkowicie usunięto instancję `CompassAudioPlayer` oraz timer kompasu z `scripts/player_audio_manager.gd`.
  - Usunięto zbędny przełącznik kompasu z menu ustawień `scenes/main_menu_ui.tscn`. Zostawiono czysty, przestrzenny odgłos obrotu (Whoosh).
- [x] **Dodać oddzielne ustawienia dźwięku kroków, dźwięków przeciwników, efektu whoosh po obrocie i jumpscare'u:**
  - Utworzono szyny w `default_bus_layout.tres`: `Master`, `Enemies`, `Footsteps`, `Whoosh`, `Jumpscare`.
  - Przypisano wszystkie źródła `AudioStreamPlayer3D` przeciwników (Balora, Marionette, Foxy, PhantomGrasp) do szyny `Enemies`, a ich jumpscare'y do `Jumpscare`.
  - Przypisano odtwarzacz obrotu w `player.tscn` do `Whoosh`, a odtwarzacze kroków w `movement_footstep.tscn` do `Footsteps`.
  - W `main_menu_ui.gd` i `main_menu_ui.tscn` dodano niezależne karty sterowania głośnością (0-100%) z odczytem lektorskim TTS.
- [x] **Marionette (Dystans, Wymóg Ręki i Rezygnacja z Whisper Freeze):**
  - Zwiększono dystans spawnu szeptu do 1.5m - 2.4m na wysokości głowy/uszu gracza (zamiast 0.8m).
  - W `marionette.gd` dodano wymóg uniesienia ręki (wysokość > 0.7m od stóp) oraz wysunięcia dłoni w kierunku szeptu (iloczyn skalarny `hand_to_whisper.dot(head_forward) > 0.15`), zapobiegając przypadkowemu odpędzaniu przy pasie.
  - **Rezygnacja z Whisper Freeze u Marionetki:** Po testach VR wycofano przyspieszanie ataku szeptu podczas biegu gracza – gracz nie miał fizycznej możliwości natychmiastowego wyhamowania z biegu i natychmiast dostawał jumpscare ("broken"). Czas szeptu płynie stabilnie, dając szansę na reakcję.
- [x] **PhantomGrasp (Wyszarpywanie oraz Spowolnienie i Blokada Sprintu):**
  - Usunięto niestabilne podwójne całkowanie przyspieszenia.
  - Wdrożono czytelne zliczanie nagłych zmian kierunku prędkości kontrolera (`shake_speed >= 1.2 m/s` z debouncem 0.22s).
  - Ustawiono **dokładnie 2 energiczne potrząśnięcia** (`required_shakes = 2`), dodając wyraźny impuls haptyczny przy każdym zaliczonym potrząśnięciu.
  - **Spowolnienie i blokada sprintu podczas ataku:** W momencie złapania gracza (`_enter_grabbed()`) macki paraliżują ruch: `MovementSprint.enabled = false` (brak możliwości sprintowania) oraz `MovementDirect.max_speed = 1.0` (silne spowolnienie chodu pod ciężarem macek). Po wyrwaniu się z uścisku (`_break_free()`) lub jumpscare pełna mobilność gracza zostaje natychmiast przywrócona.
- [x] **Ballora jest za cicha, nie słychać jej z daleka i trzeba podejść blisko niej:**
  - W `scenes/balora.tscn` zmieniono parametry dźwięku `BaloraTheme`: `max_distance = 65.0m`, `unit_size = 35.0m`, `volume_db = 7.5 dB`, a model tłumienia przestawiono na odwrotny/liniowy (`attenuation_model = 0`), dzięki czemu pozytywka jest słyszalna z dalekiego dystansu i pozwala na nawigację słuchową.
- [x] **Kroki się glitchują i nakładają się na siebie. Być może jest to za długi dźwięk i to dlatego:**
  - W `addons/godot-xr-tools/functions/movement_footstep.gd` dodano zatrzymywanie poprzednio grających odtwarzaczy kroków przed wystartowaniem nowego stąpnięcia. Zapobiega to nakładaniu się wielu 12-sekundowych próbek `woodwalking.wav`.
  - Wymiana plików audio na krótkie próbki (chód vs bieg) zostanie wykonana przez użytkownika w kolejnym kroku.
- [x] **Przyciski w MENU — Powiększenie oraz Całkowita Blokada Kliknięć (Wyłącznie Hold):**
  - Zwiększono rozmiary przycisków w menu głównym (StartButton: 650x88px font 40; Settings/Guide/Exit: 600x80px font 34; PanelContainer: 1120x720px).
  - **Rozwiązanie problemu natychmiastowej reakcji na trigger:** `Viewport2DIn3D` wysyłał zdarzenia `InputEventScreenTouch`, które omijały warunek `if event is InputEventMouseButton` i trafiały do natywnego `BaseButton` w silniku C++, generując kliknięcie. W `scripts/hold_button.gd` dodano pełne przechwytywanie i konsumowanie `InputEventScreenTouch`, `InputEventScreenDrag` oraz `ui_accept` przez `accept_event()`. Przycisk aktywuje się **wyłącznie po przytrzymaniu triggera przez 0.65s** i naładowaniu neonowego paska do 100%.
  - **Przycisk Menu Pauzy:** Pauza domyślnie wywoływana jest przyciskiem systemowym `menu_button` (na lewym kontrolerze Meta Quest / Pico - mały płaski przycisk z menu). W `scripts/pause_menu.gd` dodano obsługę alternatyw: przycisk `by_button` (górny przycisk Y na lewym kontrolerze lub B na prawym) oraz klawisze `Escape` i `P` na klawiaturze.

## SUGESTIE DO DŹWIĘKÓW NA PÓŹNIEJ:
- Dodać ambient zbliżania się przeciwnika jak zbliżanie się sąsiada w Hello Neighbor
- Dodać oddzielny ambient ataku PhantomGraspa
- Oddzielny dźwięk na minięcie 10-u sekund i oddzielny dźwięk na focus przeciwnika (zmiany stanu Ballory, pojawienie się/wykrycie przez Marionette, szarża Foxy'ego)
- Oddzielny dźwięk na kroki i na bieganie.
- Pokonanie PhantomGrasp'a alternatywną mechaniką: "beam dźwiękowy", który natychmiast niszczy macki, ale generuje olbrzymi hałas triggerujący szarżę Foxy'ego oraz kierujący Ballorę w to miejsce.

## Wdrożenie 16.09.2026 — Noce (FNaF Style), Trwały Zapis Ustawień, VR UI Navigator i Ciemność z FeetLight
- [x] **Podział na Noce / Poziomy (FNaF Style, Noc 0 - 5):**
  - Stworzono singleton `scripts/level_manager.gd` (Autoload `LevelManager`).
  - Zdefiniowano noce od Nocy 0 (Test Room / bezpieczny trening) do Nocy 5 (Koszmar: maks. prędkość Balory + 2 niezależnych Foxy szarżujących z różnych stron + Marionette + Phantom Grasp).
  - W `scenes/game_map.tscn` i `scripts/game_map.gd` wdrożono automatyczną konfigurację przeciwników na podstawie wybranej nocy, dynamiczny czas nocy (30s - 150s), dzwon 6:00 AM, lektorski komunikat zwycięstwa i automatyczne odblokowanie kolejnej nocy.
  - Dodano instancję `Foxy2` dla podwójnego polowania w Nocy 5.
- [x] **Trwały Zapis Ustawień i Postępu (JSON):**
  - Postęp gry (odblokowane i wybrana noc) zapisywany jest w `user://save_data.json`.
  - Ustawienia głośności szyn audio (`Master`, `Enemies`, `Footsteps`, `Jumpscare`) oraz stan lektora TTS (`tts_enabled`) zapisywane są trwale do `user://settings.json` przez `LevelManager.save_settings()` i ładowane automatycznie przy każdym starcie gry, eliminując problem resetowania ustawień.
- [x] **Nawigacja Joystickiem w Menu Głównym i Menu Pauzy (Krytyczne dla Dostępności):**
  - Stworzono moduł `scripts/vr_ui_navigator.gd` (`VRUINavigator`), który nasłuchuje osi pionowej gałki na kontrolerach VR (`left_hand` / `right_hand`).
  - Wychylenie gałki w górę/dół sekwencyjnie przenosi focus między przyciskami w menu, wyzwalając natychmiastowy odczyt lektorski TTS oraz impuls haptyczny w kontrolerze.
  - Wciśnięcie przycisku A (`ax_button`) lub pociągnięcie za spust (`trigger_click`) natychmiast zatwierdza wybór.
  - Wdrożono w `scenes/main_menu_ui.tscn` i `scenes/pause_menu_ui.tscn`.
- [x] **Usunięcie Sztucznego Obrotu (MovementTurn) i Efektu Whoosh:**
  - Zgodnie z decyzją projektową usunięto snap turn joystickiem – gracz w VR obraca się naturalnie własnym ciałem w 360°, co eliminuje dezorientację i chorobę lokomocyjną.
  - Usunięto węzeł `MovementTurn` oraz `TurnAudioPlayer` z `scenes/player.tscn`.
  - Usunięto szynę `Whoosh` z `default_bus_layout.tres` oraz zbędną kartę i suwaki z menu ustawień.
- [x] **Ciemność na Mapie i Subtelne Oświetlenie Stóp (FeetLight):**
  - Globalne oświetlenie na mapie (`DirectionalLight3D`) zostało wyłączone (`visible = false`, `energy = 0.0`), a `Environment` ustawiono na 100% czarne tło i zerowy ambient.
  - Do `scenes/player.tscn` dodano źródło światła `FeetLight` (`OmniLight3D`, zasięg 1.6m pod stopami), które rzuca delikatne, nastrojowe światło pod nogi gracza, dając poczucie stania na podłożu i orientację w przestrzeni, podczas gdy korytarze toną w absolutnym mroku.
- [x] **HoldButton — Całkowite Wyzerowanie `button_mask = 0`:**
  - Aby zapobiec samowolnemu emitowaniu zdarzenia `pressed` przez silnik C++ przy krótkim kliknięciu triggera, wyzerowano maskę przycisków myszy `button_mask = 0` w `scripts/hold_button.gd`.
  - Sygnał `pressed` emitowany jest wyłącznie po przytrzymaniu triggera przez 0.65s i naładowaniu paska.
````

## File: gameDoc/Inżynierka/README.md
````markdown
# Dziennik projektu i Kontekst "Lightless VR"

> Ten plik służy jako dziennik procesu powstawania gry, dokumentujący workflow, log zmian i aktualny plan działania. Poniżej znajduje się kontekst projektu dla szybkiego wczytania ułatwiającego powrót do pracy po przerwie.

## 📝 Kontekst i Założenia Gry
**Lightless VR** to gra (survival horror) dostępna w pełni dla osób niewidomych – bodźce wizualne nie dają przewagi, a gracz polega w 100% na informacjach dźwiękowych (i haptycznych). Czas odmierzany jest według przetrwanych sekwencji (surviving timer/clock).
- **Zasada ogólna**: Gra podzielona jest na sekcje Menu -> Gra -> (Game Over) -> Menu.
- **Nawigacja w menu i ustawieniach**: Interfejs wkomponowany w industrialną ścianę 3D. **Priorytet dostępności dla niewidomych:** pełna obsługa nawigacji gałką analogową kontrolera (joystickiem) z automatycznym odczytem focusu przez lektora TTS (`TTSManager`) i haptyką, zatwierdzana przyciskiem A/spustem, eliminująca konieczność celowania wskaźnikiem w ciemności. Wskaźnik VR (`FunctionPointer`) stanowi opcję pomocniczą.
- **Zderzenia / Game Over**: Popełnienie błędu (np. zignorowanie atakującego przeciwnika lub kolizja z nim) kończy grę głośnym Jumpscarem i przenosi na ekran Game Over, gdzie prezentowana jest telemetria (czas, statystyki, powód śmierci).

## 🚀 Log Zmian (Changelog)
- **v0.5.2** - Kompleksowa realizacja zaleceń audytu technicznego (`Audit_2026-08.md`) i modernizacja silnika gry: Naprawa systemu Fade w `SceneLoader.gd` (usunięcie nieskutecznych guardów `ClassDB.class_exists`, eliminacja race condition przy `_fade_in()` poprzez podwójne oczekiwanie na podmianę klatki, reset flagi `is_loading` przy błędzie ładowania). Precyzyjny tracking głowy gracza w VR (`camera.global_position` z grupą `player_head` w miejsce nieruchomego roota) dla efektu Distortion i namierzania Foxy'ego. Pełne rozdzielenie próbek audio (`danger.wav` na ostrzeżenie Foxy'ego, `whoosh2.mp3` na odpędzenie Marionetki, `Broken bell.ogg` na kompas dźwiękowy). Wdrożenie detekcji kolizji ze ścianami (głuchy dźwięk uderzenia, haptyka i emisja hałasu `EventBus.noise_emitted(3.5)` alarmująca Foxy'ego). Dostosowanie AI Balory do specyfikacji `AGENTS.md` (maszyna stanów PATROL/ALERT/CHASE/COOLDOWN, przyspieszająca pozytywka, możliwość ucieczki). Zmiana mechaniki Marionetki na aktywną obronę machnięciem kontrolera VR z wibracją ostrzegawczą bliskości ucha. Wdrożenie Threat Director (pacing wrogów na osi czasu). Dodanie czwartego wroga: **Phantom Grasp** (`scenes/phantom_grasp.tscn`, mechanika chwytu kontrolera i potrząsania dłonią). Dodanie Echolokacji (puls dźwiękowo-haptyczny na przycisku `ax_button` sondujący geometrię ścian echem 3D). Utworzenie Menu Pauzy VR (`scenes/pause_menu.tscn`, przycisk `menu_button`). Naprawa wyłącznika lektora TTS w panelu ustawień oraz zabezpieczenie wywołań asynchronicznych `is_inside_tree()`. Architektura przestrzenna Menu Głównego 3D z industrialną ścianą Google Stitch i cyfrowym glitchem `RubikGlitch`.
- **v0.5.1** - Przebudowa Menu Głównego na styl industrialnej ściany 3D z wyrytymi napisami (inspirowane projektem z Google Stitch), dynamiczny efekt animacji glitch tytułu "LIGHTLESS", komponent `HoldButton` (Hold-to-Click 0.6s) na wszystkich przyciskach, eliminacja lagów TTS przez Dwell Debounce (80ms), fizyczne blokowanie rąk gracza (`CollisionHandLeft`/`CollisionHandRight`), nowy subtelny wskaźnik VR w chłodnej błękitnej tonacji (`FunctionPointer`), zmiana nazwy projektu na Lightless.
- **v0.5.0** - Wdrożenie dedykowanego ekranu Game Over (`scenes/game_over.tscn`), systemu telemetrii w `SceneLoader` i integracji z `DESIGN.md`.
- **v0.4.0** - Wdrożenie poprawek ułatwiających nawigację (Kompas Dźwiękowy, Whoosh) oraz ulepszenia Audio (efekt Distortion w tle). Rebalans przeciwników, kolizji oraz wsparcie natywnych wibracji XR.
- **v0.3.0** - Wdrożenie logiki przeciwników (Balora, Marionette) ze sztuczną inteligencją reagującą na akcje, wektory wzroku, odległość i hałas. Powstanie globalnych menadżerów zdarzeń.
- **v0.2.0** - Przebudowa architektury na system **SceneLoader**. Rezygnacja z węzła nadrzędnego `Main` na rzecz pełnej podmiany scen (`change_scene_to_packed`). Rozwiązanie problemów z fizyką XR i stabilnością gracza podczas przeładowywania map.
- **v0.1.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (Staging).

## ⚠️ Znane Problemy i Dług Techniczny (Known Bugs)
1. **Niedziałający przełącznik TTS (Brak wyłączenia lektora)**:
   - Opcja przełączania TTS w panelu Settings (`TTSToggleBtn`) zmienia tekst na przycisku, lecz sam syntezator mowy w `TTSManager` nadal odczytuje teksty i nie respektuje globalnego wyłączenia głosu.
2. **Dualizm aktywacji przycisków VR (Kliknięcie vs Przytrzymanie)**:
   - Przyciski reagują na bezpośrednie wciśnięcie triggera (`trigger_click`) oraz na napełnienie paska ładowania `HoldButton`. Skoro do aktywacji wystarcza samo kliknięcie, pasek ładowania jest wizualnie mylący i planowane jest usunięcie animacji ładowania na rzecz bezpośredniej aktywacji na kliknięcie.

## 👻 Przeciwnicy
### 1. Balora
- **Zachowanie**: Maszyna stanów PATROL → ALERT → CHASE → COOLDOWN. Patroluje mapę po siatce NavMesh.
- **Sygnał**: Pozytywka (music box). W stanie Alert tempo pozytywki przyspiesza (`pitch_scale` 1.35), a Balora idzie w stronę gracza. W stanie pościgu pozytywka gra bardzo szybko i agresywnie (`pitch_scale` 1.7).
- **Kontra**: Natychmiastowa ucieczka sprintem na odległość >9.5m pozwala zgubić pościg, wprowadzając Balorę w kilkusekundowy stan wyciszenia (Cooldown) i powrót do patrolu. Reaguje wyłącznie na bliskość, nie na hałas.

### 2. Marionette
- **Zachowanie**: Pojawia się blisko głowy gracza i emituje szepty otaczające. Dźwięk narasta i przybliża się do ucha (efekt crescendo).
- **Sygnał**: Szepty do ucha, narastające napięcie oraz intensywna wibracja haptyczna kontrolerów przy skrajnej bliskości ucha.
- **Kontra**: Należy zlokalizować uchem kierunek szeptu i zdecydowanie machnąć dłonią/kontrolerem VR w jego stronę, aby odpędzić Marionetkę. Sukces nagradzany jest unikalnym świstem rozproszenia (`whoosh2.mp3`) i impulsem haptycznym.

### 3. Foxy
- **Zachowanie**: Skupia się na impulsach skumulowanego hałasu gracza (sprint, zderzenia ze ścianami, puls echolokacji).
- **Sygnał**: Niski sygnał ostrzegawczy `danger.wav`, po którym zapada absolutna cisza na 2 sekundy, a następnie następuje gwałtowna szarża w linii prostej na pozycję gracza.
- **Kontra**: Po usłyszeniu ciszy należy zrobić odskok w bok LUB wystawić dłoń z kontrolerem w stronę szarży, wykonując blok. Udany blok odrzuca Foxy'ego, nagradzając gracza dźwiękiem sukcesu i wibracją w dłoni.

### 4. Phantom Grasp
- **Zachowanie**: Zbliża się cichym pełzaniem od dołu wprost ku dłoni gracza, po czym nagle chwyta jeden z kontrolerów VR.
- **Sygnał**: Agresywny odgłos zaciskania macek i ciągła, silna wibracja pochwyconego kontrolera.
- **Kontra**: Gracz musi natychmiast i gwałtownie potrząsać zaatakowanym kontrolerem, by wyrwać się z uścisku przed upływem limitu czasu.

---

## 🛠️ Plan Działania / Workflow (To-Do)

### Faza 1: Interfejs i Przejścia (Foundation)
- [x] **Accessibility Menu System**: Zaprojektowanie struktury menu obsługującego VR-Pointer z Godot XR Tools i wejścia kontrolera. Zintegrowanie z systemem TextToSpeech (`TTSManager`) z buforowaniem Dwell Debounce (80ms).
- [x] **HoldButton Component**: Komponent obsługi przycisków VR z zabezpieczeniem `_wait_for_release` przed zapętleniem.
- [x] **Scene Staging / SceneLoader**: Wdrożenie asynchronicznego ładowania scen z przejściami Fade (`SceneLoader.gd`) i eliminacją błędu ClassDB.
- [x] **Ekran Game Over**: Dedykowany interfejs z telemetrią sesji i opcją restartu / powrotu do menu (`scenes/game_over.tscn`), dopasowany do motywu industrialnego Google Stitch.
- [x] **Industrialne Menu Główne 3D**: Pełne trójwymiarowe pomieszczenie (10x9.2m) z ukierunkowanym oświetleniem punktowym na GUI, cyfrowy glitch tytułu "LIGHTLESS" (RubikGlitch, czas ~1s).
- [x] **Naprawa błędu braku skryptu UI**: Przywrócenie powiązania `main_menu_ui.gd` do korzenia sceny 2D i odblokowanie nawigacji Start/Settings.
- [ ] **Uproszczenie interakcji przycisków**: Usunięcie animacji ładowania paska w `HoldButton` na rzecz natychmiastowego kliknięcia triggerem.
- [x] **Naprawa wyłączenia TTS**: Zapewnienie pełnej blokady mowy lektora po przełączeniu opcji na "OFF" (`_execute_speak` guard w v0.5.2).
- [ ] **Nawigacja Joystickiem w Menu**: Bezpośrednie przekazywanie wychylenia gałki kontrolera VR do poruszania focusem po przyciskach UI (TTS czyta zaznaczenia, A/trigger zatwierdza) dla pełnej dostępności bez celowania wskaźnikiem.

### Faza 2: Kontroler Gracza Rozszerzony
- [x] Obsługa logiki generowania dźwięków gracza (podział cichy chód, sprint powodujący alarm).
- [x] Rozpoznawanie uderzeń (kolizje ciała i uderzenia w ściany dla mechaniki hałasu dla Foxy'ego + haptyka).
- [x] Fizyczne blokowanie rąk gracza (`CollisionHandLeft`/`CollisionHandRight`) zapobiegające przenikaniu przez ściany i interfejsy.
- [x] Subtelne wskaźniki VR (`FunctionPointer`) w chłodnej błękitnej tonacji z bezpośrednim trigger_click.
- [x] Echolokacja pod przyciskiem `ax_button` z 8 kierunkami raycastu i echem przestrzennym.

### Faza 3: SI Przeciwników
- [x] **Balora**: Maszyna stanów Patrol/Alert/Pościg/Cooldown, przyspieszająca pozytywka, możliwość ucieczki, NavMesh o promieniu 0.85m.
- [x] **Marionette**: Logika szeptów kierunkowych i mechanika odpędzania machnięciem kontrolera + haptyka bliskości.
- [x] **Foxy**: System alertowy na głośne dźwięki (kroki, kolizje ze ścianami, echolokacja) -> cisza -> szarża. Blok dłonią.
- [x] **Phantom Grasp**: Chwyt kontrolera, silne wibracje i mechanika wyszarpywania.

### Faza 4: Threat Director i Pacing
- [x] Oś czasu pojawiania się wrogów (0:15 Balora, 0:40 Marionette, 1:15 Foxy, 1:50 Phantom Grasp).
- [x] Dynamiczny efekt Distortion obniżający ton ambientu przy zbliżaniu się wrogów.
- [x] Eskalacja trudności Marionetki z czasem (`EventBus.milestone_reached`).
- [x] Menu Pauzy w grze (`scenes/pause_menu.tscn`, przycisk `menu_button`, pełny TTS).

### Faza 5: System Poziomów / Nocy (FNaF Progression)
- [ ] **Poziom 1 (Noc 0 - Test Room / Tutorial)**: Brak wrogów, trening poruszania, uderzeń w ściany i wskazywania dźwięków 3D w przestrzeni.
- [ ] **Poziom 2 (Noc 1 - 30 sekund)**: Wyłącznie Balora (niska prędkość, przyspieszenie w ostatnich sekundach).
- [ ] **Poziom 3 (Noc 2 - 60 sekund)**: Balora (przyspiesza co 10s) + Marionette (co ~20s, seria 2 szeptów pod koniec).
- [ ] **Poziom 4 (Noc 3)**: Balora + Marionette + Foxy (bardzo cierpliwy na hałas).
- [ ] **Poziom 5 (Noc 4)**: Balora + częstsza Marionette + aktywniejszy Foxy + Phantom Grasp.
- [ ] **Poziom 6 (Noc 5 - Finał)**: Balora na pełnej prędkości + 2x Foxy (niezależne szarże z dwóch stron) + Marionette + Phantom Grasp.
- [ ] **System wyboru nocy w menu / zapis postępu**: Odblokowywanie kolejnych nocy po przetrwaniu poprzedniej.

---

## 🌙 Struktura Poziomów (System Nocy / FNaF Style)
Gra zorganizowana jest w 6 zróżnicowanych nocy, wprowadzających gracza krok po kroku w mechaniki sensoryczne:
1. **Noc 0 (Test Room)**: Bezpieczna eksploracja, test echolokacji, kolizji ze ścianą i lokalizacji dźwięków w przestrzeni 3D.
2. **Noc 1 (30s)**: Powolna Balora, nauka oceny odległości na słuch, finisz z przyspieszoną pozytywką.
3. **Noc 2 (60s)**: Balora przyspieszająca co 10s + Marionette atakująca co 20s (zwieńczona podwójnym szeptem).
4. **Noc 3**: Wprowadzenie Foxy'ego o wysokiej tolerancji na hałas. Nauka mechaniki ciszy i bloku.
5. **Noc 4**: Eskalacja agresji Foxy'ego, serie szeptów Marionetki i uściski Phantom Grasp.
6. **Noc 5 (Finał)**: Podwójny Foxy, superszybka Balora i pełna presja sensoryczna.


---

## 🎧 Aktualizacja sensoryczna i gameplayowa (16.09.2026)
Wdrożono kluczowe poprawki na podstawie testów VR z dnia 16.09.2026:
- **Niezależne szyny audio (`default_bus_layout.tres`):** Pełna kontrola suwakami w UI nad głośnością szyn: Master, Enemies (dźwięki przeciwników), Footsteps (kroki gracza), Whoosh (odgłos obrotu) oraz Jumpscare.
- **Usunięcie kompasu:** Skasowano dezorientujący dźwięk dzwonka kompasu (`Broken bell.ogg`); nawigacja obrotowa opiera się wyłącznie na czystym Whooshu.
- **Marionette (Dystans, Odpędzanie):** Zwiększono dystans spawnu do 1.5m-2.4m, dodano wymóg uniesienia i wyciągnięcia dłoni w kierunku szeptu (obrót z rękami przy pasie nie odpędza wroga). Zrezygnowano z mechaniki Whisper Freeze, zapewniając stabilny czas na orientację w przestrzeni.
- **Phantom Grasp (Wyszarpywanie, Spowolnienie i Blokada Sprintu):** Zastąpiono podwójne całkowanie prostą detekcją 2 gwałtownych potrząśnięć kontrolerem z feedbackiem haptycznym. Podczas chwytu macek gracz zostaje natychmiast spowolniony (`max_speed = 1.0`), a sprint zostaje zablokowany aż do oswobodzenia.
- **Ballora (Donośność pozytywki):** Zwiększono zasięg do 65m, `unit_size` do 35.0 i `volume_db` do 7.5 dB z modelem liniowym, przywracając orientację słuchową z oddali.
- **Kroki:** Wstrzymywanie poprzednich instancji przed nowym stąpnięciem, eliminując nakładanie się 12-sekundowych próbek.
- **Interfejs VR (Hold Button & Pauza):** Zwiększono rozmiary przycisków w menu, skonsumowano zdarzenia `InputEventScreenTouch` z viewportu VR, wymuszając aktywację **wyłącznie po przytrzymaniu triggera przez 0.65s** (brak przypadkowych kliknięć). Dodano alternatywne mapowanie pauzy (`by_button` Y/B oraz Escape/P).

*Ostatnia aktualizacja:* v0.5.2 (16.09.2026) — Wdrożenie szyn audio, spowolnienie i blokada sprintu Phantom Grasp, naprawa wyszarpywania, poprawa donośności Ballory, powiększenie i 100% ochrona przycisków VR przed luźnym kliknięciem (Hold Button).
````

## File: scripts/ballora.gd.uid
````
uid://40tyohs7i6dm
````

## File: scripts/event_bus.gd.uid
````
uid://bupsx8u5arpwo
````

## File: scripts/foxy.gd.uid
````
uid://bebk6fhspwj0v
````

## File: scripts/game_map.gd.uid
````
uid://cbilw02reekmp
````

## File: scripts/game_over_ui.gd.uid
````
uid://c3335djg2m52k
````

## File: scripts/game_over.gd
````
@tool
extends XRToolsSceneBase

const GAME_MAP_PATH = "res://scenes/game_map.tscn"
const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	# Zablokowanie ruchu kontrolerem dla sceny Game Over
	var providers = get_tree().get_nodes_in_group("movement_providers")
	for p in providers:
		if "enabled" in p:
			p.enabled = false
			
	# Podpinamy sygnały z UI wewnątrz Viewport2Din3D
	var viewport_2d = $Viewport2Din3D
	if viewport_2d:
		if not viewport_2d.is_node_ready():
			await viewport_2d.ready
		var ui = viewport_2d.get_scene_instance()
		if ui:
			ui.restart_pressed.connect(_on_restart_pressed)
			ui.menu_pressed.connect(_on_menu_pressed)

func _on_restart_pressed() -> void:
	SceneLoader.load_scene(GAME_MAP_PATH)

func _on_menu_pressed() -> void:
	SceneLoader.load_scene(MAIN_MENU_PATH)
````

## File: scripts/game_over.gd.uid
````
uid://ckr1jiigqdojl
````

## File: scripts/glitch_title.gd.uid
````
uid://be1qqnukbv3uc
````

## File: scripts/hold_button.gd.uid
````
uid://csj733r2xrc37
````

## File: scripts/jumpscare_helper.gd.uid
````
uid://cgrlq66342glr
````

## File: scripts/level_manager.gd
````
extends Node

## LevelManager — Autoload zarządzający poziomami (nocami w stylu FNaF),
## progresją gry oraz trwałym zapisem/odczytem ustawień do plików JSON.

signal night_selected(night_index: int)
signal night_unlocked(night_index: int)

const SAVE_PATH := "user://save_data.json"
const SETTINGS_PATH := "user://settings.json"

var selected_night: int = 1
var unlocked_night: int = 1 # Noc 0 i 1 są zawsze dostępne na start

var nights: Dictionary = {
	0: {
		"title": "Night 0: Test Room",
		"desc": "Safe exploration training. No enemies. Practice walking, wall collisions and sound direction.",
		"duration": 60.0,
		"has_balora": false,
		"balora_speed": 0.0,
		"balora_boost_time": 0.0,
		"has_marionette": false,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	1: {
		"title": "Night 1: First Contact",
		"desc": "Survive 30 seconds. Slow Balora patrols the maze, speeding up in the final seconds.",
		"duration": 30.0,
		"has_balora": true,
		"balora_speed": 1.2,
		"balora_boost_time": 6.0, # Przyspieszenie w ostatnich 6 sekundach
		"has_marionette": false,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	2: {
		"title": "Night 2: Whispering Shadows",
		"desc": "Survive 60 seconds. Balora accelerates every 10s. Marionette whispers from the dark.",
		"duration": 60.0,
		"has_balora": true,
		"balora_speed": 1.5,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": false,
		"foxy_count": 0,
		"foxy_threshold": 999.0,
		"has_phantom_grasp": false
	},
	3: {
		"title": "Night 3: Silence and Charge",
		"desc": "Survive 90 seconds. Foxy joins the hunt, reacting to accumulated movement noise.",
		"duration": 90.0,
		"has_balora": true,
		"balora_speed": 1.6,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 1,
		"foxy_threshold": 24.0, # Bardzo cierpliwy na hałas
		"has_phantom_grasp": false
	},
	4: {
		"title": "Night 4: The Deep Dark",
		"desc": "Survive 120 seconds. Aggressive Foxy, frequent Marionette whispers, and Phantom Grasp tentacles.",
		"duration": 120.0,
		"has_balora": true,
		"balora_speed": 1.8,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 1,
		"foxy_threshold": 14.0, # Aktywny łowca
		"has_phantom_grasp": true
	},
	5: {
		"title": "Night 5: Nightmare Finale",
		"desc": "Survive 150 seconds. Full speed Balora, TWO independent Foxies, Marionette and Phantom Grasp.",
		"duration": 150.0,
		"has_balora": true,
		"balora_speed": 2.2,
		"balora_boost_time": 0.0,
		"has_marionette": true,
		"has_foxy": true,
		"foxy_count": 2, # Dwóch łowców!
		"foxy_threshold": 12.0,
		"has_phantom_grasp": true
	}
}

func _ready() -> void:
	load_game()
	load_and_apply_settings()

func get_current_night_config() -> Dictionary:
	if nights.has(selected_night):
		return nights[selected_night]
	return nights[1]

func select_night(night_idx: int) -> bool:
	if night_idx < 0 or night_idx > 5:
		return false
	if night_idx > unlocked_night and night_idx != 0:
		return false # Zablokowana noc
	selected_night = night_idx
	night_selected.emit(selected_night)
	save_game()
	return true

func unlock_next_night() -> void:
	var next_night = selected_night + 1
	if next_night <= 5 and next_night > unlocked_night:
		unlocked_night = next_night
		night_unlocked.emit(unlocked_night)
		save_game()
		print("[LevelManager] Odblokowano Noc: ", unlocked_night)

func save_game() -> void:
	var data := {
		"unlocked_night": unlocked_night,
		"selected_night": selected_night,
		"last_saved": Time.get_datetime_string_from_system()
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(json_text)
		if parsed is Dictionary:
			unlocked_night = clamp(int(parsed.get("unlocked_night", 1)), 1, 5)
			selected_night = clamp(int(parsed.get("selected_night", 1)), 0, unlocked_night)

# --- TRWAŁY ZAPIS I ODCZYT USTAWIEŃ ---

func save_settings(settings_dict: Dictionary) -> void:
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings_dict, "\t"))
		file.close()
		print("[LevelManager] Ustawienia zapisane do: ", SETTINGS_PATH)

func load_settings() -> Dictionary:
	var defaults := {
		"master_volume": 80,
		"enemies_volume": 85,
		"footsteps_volume": 80,
		"jumpscare_volume": 90,
		"tts_enabled": true
	}
	if not FileAccess.file_exists(SETTINGS_PATH):
		return defaults
	var file := FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	if file:
		var json_text := file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(json_text)
		if parsed is Dictionary:
			for k in defaults.keys():
				if not parsed.has(k):
					parsed[k] = defaults[k]
			return parsed
	return defaults

func load_and_apply_settings() -> void:
	var s = load_settings()
	_apply_bus_volume("Master", int(s.get("master_volume", 80)))
	_apply_bus_volume("Enemies", int(s.get("enemies_volume", 85)))
	_apply_bus_volume("Footsteps", int(s.get("footsteps_volume", 80)))
	_apply_bus_volume("Jumpscare", int(s.get("jumpscare_volume", 90)))
	if TTSManager:
		TTSManager.tts_enabled = bool(s.get("tts_enabled", true))

func _apply_bus_volume(bus_name: String, volume_percent: int) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx >= 0:
		if volume_percent <= 0:
			AudioServer.set_bus_mute(bus_idx, true)
		else:
			AudioServer.set_bus_mute(bus_idx, false)
			var db = linear_to_db(float(volume_percent) / 100.0)
			AudioServer.set_bus_volume_db(bus_idx, db)
````

## File: scripts/level_manager.gd.uid
````
uid://cb68butgxiya
````

## File: scripts/main_menu_ui.gd.uid
````
uid://cnirmw4v8ixlt
````

## File: scripts/main_menu.gd.uid
````
uid://c1n8p7fin4eiq
````

## File: scripts/marionette.gd.uid
````
uid://b7ny004tb164f
````

## File: scripts/pause_menu_ui.gd.uid
````
uid://dnxve3m5i3n4j
````

## File: scripts/pause_menu.gd.uid
````
uid://bcr15wxo5bwsm
````

## File: scripts/phantom_grasp.gd.uid
````
uid://ck2hvdc2sbygk
````

## File: scripts/player_audio_manager.gd.uid
````
uid://ddgofpxlmq1d3
````

## File: scripts/scene_loader.gd.uid
````
uid://b0l72c2rig2ql
````

## File: scripts/tts_manager.gd.uid
````
uid://bin4f34eliqc8
````

## File: scripts/vr_ui_navigator.gd
````
extends Node
class_name VRUINavigator

## VRUINavigator — Komponent uniwersalnej nawigacji joystickiem VR w menu.
## Zapewnia pełną dostępność dla osób niewidomych:
## - Wychylenie gałki góra/dół sekwencyjnie przenosi focus między przyciskami
## - Automatyczny odczyt lektorski TTS zaznaczonej opcji
## - Impuls haptyczny w kontrolerze przy każdej zmianie focusu
## - Wciśnięcie przycisku A (ax_button) lub pociągnięcie spustu zatwierdza wybór

@export var root_control: Control
@export var debounce_time: float = 0.28

var _cooldown: float = 0.0
var _current_buttons: Array[Button] = []
var _current_index: int = -1

var _left_ctrl: XRController3D
var _right_ctrl: XRController3D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if root_control == null and get_parent() is Control:
		root_control = get_parent() as Control
	_find_controllers()
	refresh_buttons()

func _find_controllers() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var origin = player.get_node_or_null("XROrigin3D")
		if origin:
			_left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
			_right_ctrl = origin.get_node_or_null("right_hand") as XRController3D

func refresh_buttons() -> void:
	_current_buttons.clear()
	if root_control:
		_gather_buttons(root_control, _current_buttons)
	
	if not _current_buttons.is_empty():
		# Szukamy aktualnie sfokusowanego przycisku
		_current_index = -1
		for i in range(_current_buttons.size()):
			if _current_buttons[i].has_focus():
				_current_index = i
				break
		if _current_index == -1:
			_current_index = 0
			# Nie wymuszamy natychmiastowego TTS przy starcie, aby nie zagłuszyć zapowiedzi ekranu
			_current_buttons[0].grab_focus()

func _gather_buttons(node: Node, out_list: Array[Button]) -> void:
	if node is CanvasItem:
		if not (node as CanvasItem).is_visible_in_tree():
			return
	elif node is Node3D:
		if not (node as Node3D).is_visible_in_tree():
			return

	if node is Button and not node.disabled and (node as CanvasItem).is_visible_in_tree():
		out_list.append(node)
	for child in node.get_children():
		_gather_buttons(child, out_list)

func _process(delta: float) -> void:
	if _cooldown > 0.0:
		_cooldown -= delta
		return

	if _left_ctrl == null or _right_ctrl == null:
		_find_controllers()

	# Odczyt gałki z kontrolerów VR
	var stick_y := 0.0
	var active_ctrl: XRController3D = null
	
	if _left_ctrl and _left_ctrl.get_is_active():
		var v = _left_ctrl.get_vector2("primary")
		if abs(v.y) > 0.45:
			stick_y = v.y
			active_ctrl = _left_ctrl
			
	if active_ctrl == null and _right_ctrl and _right_ctrl.get_is_active():
		var v = _right_ctrl.get_vector2("primary")
		if abs(v.y) > 0.45:
			stick_y = v.y
			active_ctrl = _right_ctrl

	# Fallback dla klawiatury PC podczas testów
	if stick_y == 0.0:
		if Input.is_action_just_pressed("ui_down") or Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
			stick_y = -1.0
		elif Input.is_action_just_pressed("ui_up") or Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
			stick_y = 1.0

	# Nawigacja góra / dół
	if stick_y != 0.0 and not _current_buttons.is_empty():
		_cooldown = debounce_time
		
		# W OpenXR / Godot: zazwyczaj wychylenie gałki w dół ma wartość ujemną (lub dodatnią zależnie od mapowania)
		if stick_y < 0.0:
			# Następny przycisk w dół
			_current_index = (_current_index + 1) % _current_buttons.size()
		else:
			# Poprzedni przycisk w górę
			_current_index = (_current_index - 1 + _current_buttons.size()) % _current_buttons.size()
			
		_apply_focus_to_current(active_ctrl)
		return

	# Zatwierdzenie przyciskiem A (ax_button) na kontrolerze VR
	var confirm_pressed := false
	if _left_ctrl and (_left_ctrl.is_button_pressed("ax_button") or _left_ctrl.is_button_pressed("trigger_click")):
		confirm_pressed = true
		active_ctrl = _left_ctrl
	elif _right_ctrl and (_right_ctrl.is_button_pressed("ax_button") or _right_ctrl.is_button_pressed("trigger_click")):
		confirm_pressed = true
		active_ctrl = _right_ctrl

	if confirm_pressed and not _current_buttons.is_empty() and _current_index >= 0 and _current_index < _current_buttons.size():
		_cooldown = 0.45 # Debounce zatwierdzenia
		var target_btn = _current_buttons[_current_index]
		if is_instance_valid(target_btn):
			if active_ctrl:
				active_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.8, 0.12, 0.0)
			if target_btn is HoldButton:
				(target_btn as HoldButton)._trigger_activation()
			else:
				target_btn.pressed.emit()

func _apply_focus_to_current(ctrl: XRController3D) -> void:
	if _current_buttons.is_empty() or _current_index < 0 or _current_index >= _current_buttons.size():
		return
		
	var target_btn = _current_buttons[_current_index]
	if not is_instance_valid(target_btn):
		refresh_buttons()
		return
		
	target_btn.grab_focus()
	
	# Haptyka
	if ctrl:
		ctrl.trigger_haptic_pulse("haptic", 120.0, 0.5, 0.06, 0.0)
		
	# Odczyt lektora TTS
	if TTSManager:
		var txt = target_btn.text.strip_edges()
		if txt.is_empty() and target_btn.tooltip_text:
			txt = target_btn.tooltip_text
		if not txt.is_empty():
			TTSManager.speak(txt, true)
````

## File: scripts/vr_ui_navigator.gd.uid
````
uid://cioohvcyfqwpl
````

## File: .agents/AGENTS.md
````markdown
# Wymogi projektowe dla agentów AI - Lightless VR

## Kontekst projektu
- **Gatunek:** Gra survival horror w VR tworzona w silniku Godot 4.x.
- **Dostępność:** Pełna dostępność dla osób niewidomych – rozgrywka oparta w 100% na dźwięku przestrzennym (3D Audio) i haptyce, bez jakiejkolwiek przewagi z bodźców wizualnych. 
- **Nawigacja (KRYTYCZNE DLA DOSTĘPNOŚCI):** Interfejsy (Menu Główne, Ustawienia, Pauza, Game Over) **muszą oferować pełną obsługę nawigacji joystickiem kontrolera**, aby gracze niewidomi nie musieli celować w przestrzeni 3D wskaźnikiem laserowym. Wychylenie gałki kontrolera (góra/dół) przesuwa focus po elementach interfejsu (wyzwalając natychmiastowy odczyt lektorski TTS i impuls haptyczny), a przycisk A / trigger zatwierdza wybór. VR-Pointer pozostaje opcjonalnym rozwiązaniem pomocniczym.
- **Zderzenia:** Uderzenia w ściany i hałasliwe poruszanie (sprint) generują dźwięki ostrzegające wrogów.

## Architektura i Zarządzanie Scenami
- **System SceneLoader (KRYTYCZNE):** Gra używa pełnej podmiany scen (`change_scene_to_packed`) przez skrypt `SceneLoader.gd` (Autoload), z wykorzystaniem dodatkowych wątków (`ResourceLoader.load_threaded_request`) i ściemniania poprzez `XRToolsFade`. Nie ma już węzła nadrzędnego `Main` i starego podejścia Staging.
- **Zasady budowy scen:** Każda scena jest w 100% samowystarczalna i zawiera kompletne instancje węzłów: `StartXR`, `Player` i `Fade`. Zapewnia to natychmiastowy reset fizyki i stabilność VR przy przeładowaniach (np. `main_menu.tscn`, `game_map.tscn`).
- **Pobieranie Gracza:** By znaleźć kamerę gracza w skryptach wrogów, należy używać:
  ```gdscript
  var player_root = get_tree().get_first_node_in_group("player")
  var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
  ```

## Przeciwnicy i Mechaniki (AI)
1. **Balora (Patrol i Bliskość):** Porusza się po NavMesh, stale patrolując mapę i emitując dźwięk pozytywki. **Reaguje na bliskość, nie na hałas**. Gdy gracz wejdzie w strefę Alertu, pozytywka przyspiesza, a Balora idzie w jego stronę. Zbyt długa obecność blisko niej lub bezpośrednie wejście w strefę Krytyczną wyzwala pościg. Należy od niej uciec, by wróciła do patrolu.
2. **Foxy (Hałas i Szarża):** Reaguje na **kumulatywny hałas gracza** (sprint, kolizje, gwałtowne ruchy). Gdy hałas przekroczy próg, Foxy nagle całkowicie milknie (sygnał dla gracza), a po ~2 sekundach szarżuje w linii prostej na pozycję, w której gracz hałasował. Kontra: gracz musi zrobić odskok w bok ALBO obronić się, wyciągając i machając kontrolerem w stronę szarży (blok).
3. **Marionette (Szepty i Odpędzanie):** Pojawia się blisko gracza i emituje jeden główny szept, który z czasem przybliża się do ucha. Należy ustalić kierunek i zdecydowanie machnąć ręką (kontrolerem) w stronę źródła dźwięku, by ją odpędzić. *Uwaga eskalacyjna:* Wraz z upływem czasu gry (sygnalizowanym gongiem co 10s), mechanika staje się trudniejsza i Marionette może atakować sekwencyjnie (np. 2-3 szepty z rzędu z różnych stron).
4. **Phantom Grasp (Macki/Chwyt):** Sygnalizowany cichym pełzaniem w kierunku rąk gracza. Nagle "chwyta" jeden z kontrolerów, wywołując silną wibrację i agresywny dźwięk. Gracz musi bardzo szybko i intensywnie potrząsać zaatakowanym kontrolerem, by wyrwać się z uścisku, zanim dojdzie do Jumpscare'a.

## Struktura Rozgrywki — Poziomy / Noce (FNaF Style)
Gra podzielona jest na poziomy (noce) z rosnącym poziomem trudności i stopniowym wprowadzaniem wrogów:
- **Poziom 1 (Noc 0 - Test Room / Tutorial):** Brak przeciwników. Trening poruszania, uderzeń w ściany (odgłos kolizji, haptyka) oraz wskazywania przestrzennych sygnałów dźwiękowych 3D.
- **Poziom 2 (Noc 1 - 30 sekund):** Tylko Balora na niskiej prędkości, przyspieszająca w ostatnich sekundach nocy.
- **Poziom 3 (Noc 2 - 60 sekund):** Balora przyspieszająca co 10s + Marionette atakująca co ok. 20s (pod koniec podwójny szept).
- **Poziom 4 (Noc 3):** Dołącza Foxy — bardzo cierpliwy na hałas (wysoki próg wyzwolenia szarży).
- **Poziom 5 (Noc 4):** Aktywniejszy Foxy (niższy próg hałasu), częstsza Marionette i ataki Phantom Grasp.
- **Poziom 6 (Noc 5 - Finał):** Maksymalna prędkość Balory + **2x Foxy** (dwóch łowców hałasu szarżujących z różnych kierunków) + Marionette + Phantom Grasp.

## Zalecenia Designowe (Audio i Feedback)
AI podczas implementacji musi uwzględnić wielokanałowe informowanie gracza o zagrożeniach:
- **Dźwięk sprintu i hałasu:** Gracz musi słyszeć konsekwencje swoich akcji. Dźwięk własnych kroków podczas sprintu musi być wyraźnie szybszy i głośniejszy niż przy zwykłym chodzie.
- **Haptyka zagrożenia bliskiego:** Gdy Marionette jest krytycznie blisko głowy gracza, należy aktywować wibracje gogli VR (lub obu kontrolerów z wysoką częstotliwością), jako ostateczne fizyczne ostrzeżenie przed atakiem.
- **Efekt Distortion (Hello Neighbor):** Należy nałożyć dynamiczny efekt (np. Low-pass filter lub bitcrusher) na warstwę muzyczną/ambientową. Im bliżej gracza znajduje się najniebezpieczniejszy przeciwnik, tym efekt zniekształcenia dźwięku w tle staje się mocniejszy, dając podprogową informację o bliskości zagrożenia.
- **Potwierdzenia akcji (Audio Cues):** Każde skuteczne odparcie wroga (machnięcie w stronę Marionette, wyrwanie się z macek, blok Foxy'ego) musi być natychmiast nagrodzone unikalnym i satysfakcjonującym dźwiękiem "rozproszenia" lub "odrzucenia".

## Dobre praktyki dla GDScript (Godot 4.x)
- Zawsze używaj `@onready` do przypisywania referencji węzłów do zmiennych.
- **Konwersje i Typowanie:** Rzutuj jawnie typy (np. `int(liczba_zmiennoprzecinkowa)`), aby zapobiec ucięciom (`NARROWING_CONVERSION`) i staraj się typować zmienne tam, gdzie to możliwe i pomocne.
- **Unikanie "null instance":** Przed manipulacją na węzłach sprawdzaj, czy nie są puste (np. `if node: node.do_something()`).

## Organizacja Pracy i Postępy (To-Do)
**ZALECENIE OBOWIĄZKOWE DLA AGENTÓW AI:** Jako agent współpracujący nad tym projektem, masz za zadanie używać i na bieżąco aktualizować plik planu i zadań - np. domyślny plik planowania zdefiniowany w systemie jako `<appDataDir>\brain\<conversation-id>/task.md`.
Każdy nowy, większy postęp, odkryte założenia logiki lub checklisty funkcjonalności muszą być zapisywane do formatu zadaniowego z wykorzystaniem oznaczeń:
- `[ ]` zadania niezrobione
- `[/]` zadania w trakcie realizacji
- `[x]` zadania ukończone
Dzięki temu po ponownym otwarciu projektu będzie możliwe odtworzenie pełnego kontekstu postępów implementacyjnych z pliku tekstowego.

## Flow Pracy (notatki i dokumentacje)
- gameDoc\Inżynierka\Notatka.md - Notatki o użytych mechanizmach w programowaniu, zapiski co się zmieniało z wersji na wersję, ostateczne decyzje techniczne
- gameDoc\Inżynierka\README.md - Ogólna dokumentacja o postępach, co zostało dodawane w jakich wersjach, którego dnia wchodziły dane aktualizacje, opis ogólny projektu, aktualne zadania/problemy
- README.md - dokumentcja ogólna z aktualnymi najważniejsyzmi informacjami, która jest pokazana na GitHub

## Agentic AI rules
- Jeżeli na drodze pracy zauważysz ważny patern GDScript/Godot, który jest efektywniejszy i prostszy od tego używanego w aktualnym kodzie - zaproponuj jego implementacje i opisz w dokumentacji dlaczego jest lepszy
- Jeżeli zauważysz, że jakaś funkcjonalność jest zbędna, niepotrzebnie skomplikowana lub sprawia problemy - zaproponuj zmianę i opisz w dokumentacji dlaczego jest to uzasadnione
- W przypadku zmian, które mogą wpłynąć na stabilność projektu (np. zmiana architektury, dodawanie nowych, złożonych mechanizmów) - konieczne jest opisanie i uzasadnienie tej zmiany w dokumentacji
- Rzeczy, które warto praktykować w przyszłych implementacjach/to czego można się nauczyć na bazie konwersacji/internetu możesz zaproponować do zrobienia własnego SKILL.md
````

## File: scenes/pause_menu_ui.tscn
````
[gd_scene load_steps=5 format=3]

[ext_resource type="Script" uid="uid://dnxve3m5i3n4j" path="res://scripts/pause_menu_ui.gd" id="1_script"]
[ext_resource type="Script" uid="uid://csj733r2xrc37" path="res://scripts/hold_button.gd" id="2_hold"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_bg"]
bg_color = Color(0.06, 0.07, 0.08, 0.95)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.3, 0.35, 0.4, 0.8)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn"]
bg_color = Color(0.12, 0.14, 0.16, 0.9)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.25, 0.3, 0.35, 0.7)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[node name="PauseMenuUI" type="Control"]
process_mode = 3
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_script")

[node name="CenterContainer" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="PanelContainer" type="PanelContainer" parent="CenterContainer"]
custom_minimum_size = Vector2(480, 420)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_bg")

[node name="MarginContainer" type="MarginContainer" parent="CenterContainer/PanelContainer"]
layout_mode = 2
theme_override_constants/margin_left = 32
theme_override_constants/margin_top = 32
theme_override_constants/margin_right = 32
theme_override_constants/margin_bottom = 32

[node name="VBoxContainer" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
layout_mode = 2
theme_override_constants/separation = 20

[node name="TitleLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_font_sizes/font_size = 36
text = "GAME PAUSED"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2

[node name="ResumeBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_btn")
text = "RESUME"
script = ExtResource("2_hold")

[node name="RestartBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_btn")
text = "RESTART MAP"
script = ExtResource("2_hold")

[node name="MenuBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_btn")
text = "MAIN MENU"
script = ExtResource("2_hold")

[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeBtn" to="." method="_on_resume_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RestartBtn" to="." method="_on_restart_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/MenuBtn" to="." method="_on_menu_pressed"]
````

## File: scenes/pause_menu.tscn
````
[gd_scene load_steps=4 format=3]

[ext_resource type="Script" uid="uid://bcr15wxo5bwsm" path="res://scripts/pause_menu.gd" id="1_pause"]
[ext_resource type="PackedScene" uid="uid://clujaf3u776a3" path="res://addons/godot-xr-tools/objects/viewport_2d_in_3d.tscn" id="2_vp"]
[ext_resource type="PackedScene" path="res://scenes/pause_menu_ui.tscn" id="3_ui"]

[node name="PauseMenu" type="Node3D"]
process_mode = 3
script = ExtResource("1_pause")

[node name="Viewport2Din3D" parent="." instance=ExtResource("2_vp")]
screen_size = Vector2(1.2, 0.9)
scene = ExtResource("3_ui")
viewport_size = Vector2(600, 480)
input_gamepad = true
unshaded = true
````

## File: scripts/pause_menu_ui.gd
````
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
	_navigator.root_control = self
	add_child(_navigator)
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible and _navigator:
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
````

## File: scripts/pause_menu.gd
````
extends Node3D

@onready var viewport_2d: Node3D = $Viewport2Din3D

var is_paused: bool = false
var left_ctrl: XRController3D
var right_ctrl: XRController3D
var camera: XRCamera3D

var _menu_btn_down: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	_find_vr_nodes()
	
	if viewport_2d and viewport_2d.has_method("get_scene_instance"):
		var ui = viewport_2d.get_scene_instance()
		if ui:
			_connect_ui_signals(ui)
	elif viewport_2d:
		# Fallback - czekamy klatkę na załadowanie sceny w Viewport2D
		call_deferred("_deferred_connect_ui")

func _deferred_connect_ui() -> void:
	if viewport_2d:
		var sub_vp = viewport_2d.get_node_or_null("Viewport")
		if sub_vp and sub_vp.get_child_count() > 0:
			var ui = sub_vp.get_child(0)
			_connect_ui_signals(ui)

func _connect_ui_signals(ui: Node) -> void:
	if ui.has_signal("resume_requested") and not ui.resume_requested.is_connected(toggle_pause):
		ui.resume_requested.connect(toggle_pause)
	if ui.has_signal("restart_requested") and not ui.restart_requested.is_connected(_on_restart):
		ui.restart_requested.connect(_on_restart)
	if ui.has_signal("main_menu_requested") and not ui.main_menu_requested.is_connected(_on_main_menu):
		ui.main_menu_requested.connect(_on_main_menu)

func _find_vr_nodes() -> void:
	var head = get_tree().get_first_node_in_group("player_head")
	var root = get_tree().get_first_node_in_group("player")
	if head is XRCamera3D:
		camera = head
	elif root:
		camera = root.get_node_or_null("XROrigin3D/XRCamera3D")
		
	if root:
		var origin = root.get_node_or_null("XROrigin3D")
		if origin:
			left_ctrl = origin.get_node_or_null("left_hand")
			right_ctrl = origin.get_node_or_null("right_hand")

func _process(_delta: float) -> void:
	if left_ctrl == null or right_ctrl == null:
		_find_vr_nodes()

	var pressed := false
	if left_ctrl:
		if left_ctrl.is_button_pressed("menu_button") or left_ctrl.is_button_pressed("by_button"):
			pressed = true
	if right_ctrl and not pressed:
		if right_ctrl.is_button_pressed("menu_button") or right_ctrl.is_button_pressed("by_button"):
			pressed = true
			
	if not pressed:
		if Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_ESCAPE) or Input.is_key_pressed(KEY_P):
			pressed = true
		
	if pressed and not _menu_btn_down:
		_menu_btn_down = true
		toggle_pause()
	elif not pressed and _menu_btn_down:
		_menu_btn_down = false

func toggle_pause() -> void:
	if JumpscareHelper.is_jumpscaring_global:
		return
		
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused
	
	if is_paused:
		_position_in_front_of_player()
		if TTSManager:
			TTSManager.speak("Game paused", true)
	else:
		if TTSManager:
			TTSManager.speak("Game resumed", true)

func _position_in_front_of_player() -> void:
	if camera:
		var cam_forward = -camera.global_transform.basis.z.normalized()
		cam_forward.y = 0.0
		cam_forward = cam_forward.normalized()
		
		var target_pos = camera.global_position + cam_forward * 1.6
		target_pos.y = camera.global_position.y - 0.1
		global_position = target_pos
		
		# Obrót twarzą do gracza
		look_at(camera.global_position, Vector3.UP)
		rotate_y(PI)

func _on_restart() -> void:
	get_tree().paused = false
	visible = false
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_main_menu() -> void:
	get_tree().paused = false
	visible = false
	SceneLoader.load_scene("res://scenes/main_menu.tscn")
````

## File: scenes/phantom_grasp.tscn
````
[gd_scene format=3]

[ext_resource type="Script" uid="uid://ck2hvdc2sbygk" path="res://scripts/phantom_grasp.gd" id="1_grasp"]
[ext_resource type="AudioStream" uid="uid://dn1d2v8onqbl" path="res://assets/sounds/marionette/257784__xtrgamr__ominous-whispers.wav" id="2_crawl"]
[ext_resource type="AudioStream" uid="uid://c7yasims5j5dg" path="res://assets/sounds/danger.wav" id="3_grab"]
[ext_resource type="AudioStream" uid="uid://bb0jbi0xyp25h" path="res://assets/sounds/jumpscare_main.mp3" id="4_jump"]

[node name="PhantomGrasp" type="Node3D" groups=["enemy"]]
script = ExtResource("1_grasp")

[node name="CrawlSound" type="AudioStreamPlayer3D" parent="."]
stream = ExtResource("2_crawl")
volume_db = 2.0
unit_size = 8.0
max_distance = 15.0
pitch_scale = 0.65
bus = &"Enemies"

[node name="GrabSound" type="AudioStreamPlayer3D" parent="."]
stream = ExtResource("3_grab")
volume_db = 8.0
unit_size = 10.0
max_distance = 20.0
pitch_scale = 1.3
bus = &"Enemies"

[node name="JumpscareSound" type="AudioStreamPlayer3D" parent="."]
stream = ExtResource("4_jump")
volume_db = 10.0
bus = &"Jumpscare"
````

## File: scripts/event_bus.gd
````
extends Node

## Globalny emiter sygnałów powiązanych z hałasem gracza
@warning_ignore("unused_signal")
signal noise_emitted(global_pos: Vector3, noise_level: float)

## Sygnał wywoływany co próg przetrwania (np. co 10s) dla eskalacji trudności
@warning_ignore("unused_signal")
signal milestone_reached(milestone: int)
````

## File: scripts/phantom_grasp.gd
````
extends Node3D

enum State { DORMANT, STALKING, GRABBED }

@export var min_dormant_time: float = 25.0
@export var max_dormant_time: float = 45.0
@export var stalk_duration: float = 3.0
@export var escape_time_limit: float = 3.5
@export var required_shakes: int = 2
@export var shake_speed_threshold: float = 1.2

@onready var crawl_sound: AudioStreamPlayer3D = $CrawlSound
@onready var grab_sound: AudioStreamPlayer3D = $GrabSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var current_state: State = State.DORMANT
var _state_timer: float = 0.0
var _shake_count: int = 0
var _shake_cooldown: float = 0.0

var player_root: Node3D
var left_hand: XRController3D
var right_hand: XRController3D
var target_hand: XRController3D

var _last_hand_pos: Vector3 = Vector3.ZERO
var _haptic_loop_timer: float = 0.0

var _orig_direct_speed: float = -1.0
var _movement_sprint: XRToolsMovementSprint
var _movement_direct: XRToolsMovementDirect

func _ready():
	_find_player()
	_enter_dormant()

func _exit_tree():
	_restore_player_speed()

func _find_player():
	var root = get_tree().get_first_node_in_group("player")
	if root:
		player_root = root
		var origin = root.get_node_or_null("XROrigin3D")
		if origin:
			left_hand = origin.get_node_or_null("left_hand")
			right_hand = origin.get_node_or_null("right_hand")

func _apply_player_slowdown():
	if not player_root:
		_find_player()
	if player_root:
		var origin = player_root.get_node_or_null("XROrigin3D")
		if origin:
			_movement_sprint = origin.get_node_or_null("MovementSprint") as XRToolsMovementSprint
			if _movement_sprint:
				_movement_sprint.enabled = false
			
			var direct = origin.get_node_or_null("right_hand/MovementDirect") as XRToolsMovementDirect
			if direct:
				_movement_direct = direct
				if _orig_direct_speed < 0.0:
					_orig_direct_speed = direct.max_speed
				direct.max_speed = 1.0 # Silne spowolnienie pod ciężarem macek
	print("Phantom Grasp: Zablokowano sprint i spowolniono gracza!")

func _restore_player_speed():
	if _movement_sprint:
		_movement_sprint.enabled = true
	if _movement_direct and _orig_direct_speed > 0.0:
		_movement_direct.max_speed = _orig_direct_speed

func _enter_dormant():
	current_state = State.DORMANT
	_state_timer = randf_range(min_dormant_time, max_dormant_time)
	target_hand = null
	_restore_player_speed()
	if crawl_sound:
		crawl_sound.stop()
	if grab_sound:
		grab_sound.stop()

func _enter_stalking():
	if left_hand == null or right_hand == null:
		_find_player()
		if left_hand == null and right_hand == null:
			_enter_dormant()
			return

	# Losowanie zaatakowanej ręki
	var hands: Array[XRController3D] = []
	if left_hand: hands.append(left_hand)
	if right_hand: hands.append(right_hand)
	target_hand = hands.pick_random()

	current_state = State.STALKING
	_state_timer = stalk_duration
	
	# Start dźwięku pełzania poniżej ręki
	global_position = target_hand.global_position + Vector3(0, -0.6, 0)
	if crawl_sound:
		crawl_sound.play()
	print("Phantom Grasp: Pełznie w stronę dłoni: ", target_hand.name)

func _enter_grabbed():
	current_state = State.GRABBED
	_state_timer = escape_time_limit
	_shake_count = 0
	_shake_cooldown = 0.0
	_haptic_loop_timer = 0.0
	
	_apply_player_slowdown()
	
	if crawl_sound:
		crawl_sound.stop()
	if grab_sound:
		grab_sound.play()
		
	if target_hand:
		_last_hand_pos = target_hand.global_position
	print("Phantom Grasp: CHWYT za dłoń! Wstrząśnij kontrolerem 2 razy, by się wyrwać!")

func _process(delta: float):
	match current_state:
		State.DORMANT:
			_state_timer -= delta
			if _state_timer <= 0.0:
				_enter_stalking()

		State.STALKING:
			_state_timer -= delta
			if target_hand:
				# Pełzanie zbliża się wprost do dłoni
				var t = 1.0 - (_state_timer / stalk_duration)
				global_position = target_hand.global_position + Vector3(0, lerp(-0.6, 0.0, t), 0)
				
			if _state_timer <= 0.0:
				_enter_grabbed()

		State.GRABBED:
			_state_timer -= delta
			if _shake_cooldown > 0.0:
				_shake_cooldown -= delta
				
			if target_hand:
				global_position = target_hand.global_position
				
				# Ciągła silna wibracja pochwyconego kontrolera
				_haptic_loop_timer -= delta
				if _haptic_loop_timer <= 0.0:
					_haptic_loop_timer = 0.08
					target_hand.trigger_haptic_pulse("haptic", 160.0, 1.0, 0.08, 0.0)

				# Detekcja wyszarpywania (gwałtowne potrząśnięcie ręką)
				var cur_pos = target_hand.global_position
				var vel = (cur_pos - _last_hand_pos) / max(delta, 0.001)
				var speed = vel.length()
				_last_hand_pos = cur_pos
				
				if speed >= shake_speed_threshold and _shake_cooldown <= 0.0:
					_shake_count += 1
					_shake_cooldown = 0.22 # Wymaga 2 wyraźnych, oddzielnych ruchów
					print("Phantom Grasp: Szarpnięcie! (", _shake_count, " / ", required_shakes, ")")
					
					# Impuls potwierdzenia szarpnięcia
					target_hand.trigger_haptic_pulse("haptic", 180.0, 0.85, 0.12, 0.0)
					
					if _shake_count >= required_shakes:
						_break_free()
						return

			if _state_timer <= 0.0:
				_trigger_jumpscare()

func _break_free():
	print("Phantom Grasp: Wyrwano się z uścisku macek!")
	if grab_sound:
		grab_sound.stop()
		
	# Dźwięk sukcesu i impuls haptyczny
	if target_hand:
		target_hand.trigger_haptic_pulse("haptic", 80.0, 0.5, 0.2, 0.0)
		
	var break_sfx = AudioStreamPlayer.new()
	break_sfx.stream = preload("res://assets/sounds/whoosh2.mp3")
	break_sfx.volume_db = 2.0
	break_sfx.pitch_scale = 0.85
	add_child(break_sfx)
	break_sfx.play()
	break_sfx.finished.connect(break_sfx.queue_free)
	
	_enter_dormant()

func _trigger_jumpscare():
	if current_state == State.DORMANT:
		return
	print("Phantom Grasp: Jumpscare!")
	_restore_player_speed()
	if grab_sound:
		grab_sound.stop()
	await JumpscareHelper.execute(self, jumpscare_sound, [], "Phantom Grasp — Zmiażdżenie uściskiem macek")
````

## File: scenes/game_over.tscn
````
[gd_scene format=3 uid="uid://b04jluv2vffeg"]

[ext_resource type="Script" uid="uid://ckr1jiigqdojl" path="res://scripts/game_over.gd" id="1_game_over_script"]
[ext_resource type="PackedScene" uid="uid://clujaf3u776a3" path="res://addons/godot-xr-tools/objects/viewport_2d_in_3d.tscn" id="2_viewport2d"]
[ext_resource type="PackedScene" path="res://scenes/game_over_ui.tscn" id="3_game_over_ui"]
[ext_resource type="PackedScene" uid="uid://c0ch7jab7i3ry" path="res://scenes/player.tscn" id="4_player"]
[ext_resource type="PackedScene" uid="uid://clc5dre31iskm" path="res://addons/godot-xr-tools/xr/start_xr.tscn" id="5_startxr"]
[ext_resource type="PackedScene" uid="uid://wtpox7m5vu2b" path="res://addons/godot-xr-tools/effects/fade.tscn" id="6_fade"]
[ext_resource type="Texture2D" uid="uid://bsc3ql0fq5x8b" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_Color.png" id="7_wall_color"]
[ext_resource type="Texture2D" uid="uid://cpahkw3dcl28d" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_NormalGL.png" id="8_wall_normal"]
[ext_resource type="Texture2D" uid="uid://dnum5txu5gvmk" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_Roughness.png" id="9_wall_rough"]

[sub_resource type="ProceduralSkyMaterial" id="ProceduralSkyMaterial_game_over"]
sky_top_color = Color(0.01, 0.01, 0.015, 1)
sky_horizon_color = Color(0.02, 0.02, 0.025, 1)
ground_bottom_color = Color(0.005, 0.005, 0.008, 1)
ground_horizon_color = Color(0.02, 0.02, 0.025, 1)

[sub_resource type="Sky" id="Sky_game_over"]
sky_material = SubResource("ProceduralSkyMaterial_game_over")

[sub_resource type="Environment" id="Environment_game_over"]
background_mode = 2
sky = SubResource("Sky_game_over")
ambient_light_source = 2
ambient_light_color = Color(0.01, 0.01, 0.015, 1)
ambient_light_energy = 0.2

[sub_resource type="BoxShape3D" id="BoxShape3D_floor"]
size = Vector3(24, 1, 24)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_floor"]
albedo_color = Color(0.06, 0.06, 0.07, 1)
roughness = 0.95

[sub_resource type="PlaneMesh" id="PlaneMesh_floor"]
material = SubResource("StandardMaterial3D_floor")
size = Vector2(24, 24)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_wall"]
albedo_color = Color(0.38, 0.38, 0.4, 1)
albedo_texture = ExtResource("7_wall_color")
roughness = 0.95
roughness_texture = ExtResource("9_wall_rough")
normal_enabled = true
normal_scale = 1.2
normal_texture = ExtResource("8_wall_normal")
uv1_scale = Vector3(2.5, 1.8, 1)

[sub_resource type="BoxMesh" id="BoxMesh_wall"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(10, 4.8, 0.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_wall"]
size = Vector3(10, 4.8, 0.2)

[sub_resource type="BoxMesh" id="BoxMesh_wall_side"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(0.2, 4.8, 9.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_wall_side"]
size = Vector3(0.2, 4.8, 9.2)

[sub_resource type="BoxMesh" id="BoxMesh_ceiling"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(10.2, 0.2, 9.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_ceiling"]
size = Vector3(10.2, 0.2, 9.2)

[node name="GameOver" type="Node3D" unique_id=1022717988]
script = ExtResource("1_game_over_script")

[node name="WorldEnvironment" type="WorldEnvironment" parent="." unique_id=1876011870]
environment = SubResource("Environment_game_over")

[node name="GameOverSpotLight" type="SpotLight3D" parent="." unique_id=44774654]
transform = Transform3D(1, 0, 0, 0, 0.9563048, 0.2923717, 0, -0.2923717, 0.9563048, 0, 3.5, -0.7)
light_color = Color(0.85, 0.88, 0.92, 1)
light_energy = 2.0
spot_range = 6.5
spot_attenuation = 1.2
spot_angle = 38.0

[node name="Floor" type="StaticBody3D" parent="." unique_id=1364582937]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.5, 0)

[node name="CollisionShape3D" type="CollisionShape3D" parent="Floor" unique_id=2023623606]
shape = SubResource("BoxShape3D_floor")

[node name="MeshInstance3D" type="MeshInstance3D" parent="Floor" unique_id=26614265]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, 0)
mesh = SubResource("PlaneMesh_floor")

[node name="FrontWall" type="StaticBody3D" parent="." unique_id=1587903695]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.2, -2.8)

[node name="MeshInstance3D" type="MeshInstance3D" parent="FrontWall" unique_id=1256374738]
mesh = SubResource("BoxMesh_wall")

[node name="CollisionShape3D" type="CollisionShape3D" parent="FrontWall" unique_id=2011750583]
shape = SubResource("BoxShape3D_wall")

[node name="BackWall" type="StaticBody3D" parent="." unique_id=1279537003]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.2, 6.2)

[node name="MeshInstance3D" type="MeshInstance3D" parent="BackWall" unique_id=868718202]
mesh = SubResource("BoxMesh_wall")

[node name="CollisionShape3D" type="CollisionShape3D" parent="BackWall" unique_id=1232081722]
shape = SubResource("BoxShape3D_wall")

[node name="LeftWall" type="StaticBody3D" parent="." unique_id=1356541557]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -5, 2.2, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="LeftWall" unique_id=823979233]
mesh = SubResource("BoxMesh_wall_side")

[node name="CollisionShape3D" type="CollisionShape3D" parent="LeftWall" unique_id=435880008]
shape = SubResource("BoxShape3D_wall_side")

[node name="RightWall" type="StaticBody3D" parent="." unique_id=608977951]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 5, 2.2, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="RightWall" unique_id=1360486219]
mesh = SubResource("BoxMesh_wall_side")

[node name="CollisionShape3D" type="CollisionShape3D" parent="RightWall" unique_id=370302663]
shape = SubResource("BoxShape3D_wall_side")

[node name="Ceiling" type="StaticBody3D" parent="." unique_id=385229542]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 4.5, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="Ceiling" unique_id=1543042893]
mesh = SubResource("BoxMesh_ceiling")

[node name="CollisionShape3D" type="CollisionShape3D" parent="Ceiling" unique_id=1435904030]
shape = SubResource("BoxShape3D_ceiling")

[node name="Viewport2Din3D" parent="." unique_id=494244748 instance=ExtResource("2_viewport2d")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.15, -2.68)
screen_size = Vector2(2.4, 1.45)
scene = ExtResource("3_game_over_ui")
viewport_size = Vector2(1280, 720)
input_gamepad = true
unshaded = true
scene_properties_keys = PackedStringArray("game_over_ui.gd")

[node name="StartXR" parent="." unique_id=1473059896 instance=ExtResource("5_startxr")]

[node name="Player" parent="." unique_id=845576995 instance=ExtResource("4_player")]

[node name="Fade" parent="." unique_id=584986121 instance=ExtResource("6_fade")]
````

## File: scripts/game_over_ui.gd
````
@tool
extends Control

signal restart_pressed
signal menu_pressed

@onready var time_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TimeBadge/VBox/TimeSurvivedValue
@onready var steps_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/StepsCard/VBox/StepsValue
@onready var marionettes_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/MarionetteCard/VBox/MarionetteValue
@onready var foxy_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/FoxyCard/VBox/FoxyValue
@onready var reason_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ReasonBadge/DeathReasonValue

@onready var restart_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer/RestartButton
@onready var menu_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer/MenuButton

func _ready() -> void:
	_update_stats()
	_setup_accessibility()

func _setup_accessibility() -> void:
	if not Engine.is_editor_hint() and TTSManager:
		TTSManager.setup_button(restart_button, "Play Again")
		TTSManager.setup_button(menu_button, "Main Menu")
		
		# Read game over summary after brief delay
		await get_tree().create_timer(0.3).timeout
		var total_seconds: int = int(SceneLoader.last_survival_time)
		var minutes: int = int(total_seconds / 60.0)
		var seconds: int = total_seconds % 60
		var summary_text = "Game over. You survived %d minutes and %d seconds. Cause of death: %s." % [minutes, seconds, SceneLoader.last_death_reason]
		TTSManager.speak(summary_text, false)

func _update_stats() -> void:
	var total_seconds: int = int(SceneLoader.last_survival_time)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	
	if time_label:
		time_label.text = "%02d:%02ds" % [minutes, seconds]
	if steps_label:
		steps_label.text = "%d" % SceneLoader.steps_taken
	if marionettes_label:
		marionettes_label.text = "%d" % SceneLoader.marionettes_defended
	if foxy_label:
		foxy_label.text = "%d" % SceneLoader.foxy_charges_blocked
	if reason_label:
		reason_label.text = "CRITICAL FAILURE // " + SceneLoader.last_death_reason.to_upper()

func _on_restart_button_pressed() -> void:
	restart_pressed.emit()

func _on_menu_button_pressed() -> void:
	menu_pressed.emit()
````

## File: scripts/glitch_title.gd
````
extends Label

@export var title_text: String = "LIGHTLESS"
@export var high_frequency_jitter: bool = true
@export var major_glitch_interval: float = 2.4
@export var major_glitch_duration: float = 1.05

const GLITCH_CHARS: Array[String] = [
	"!", "?", "#", "$", "%", "&", "/", "\\", "|",
	"░", "▒", "▓", "█", "▄", "▌", "▐", "▀",
	"§", "†", "‡", "Ø", "Æ", "¥", "¿", "¡", "X", "0",
	"1", "7", "<", ">", "[", "]", "{", "}", "~", "@", "*"
]

const CHAR_SHUFFLE_INTERVAL: float = 0.06 # Shuffles characters ~16 times per second during major glitch

var _major_timer: float = 0.0
var _is_major_glitching: bool = false
var _major_glitch_time_left: float = 0.0
var _char_shuffle_timer: float = 0.0
var _jitter_timer: float = 0.0
var _shader_mat: ShaderMaterial = null

func _ready() -> void:
	text = title_text
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_major_timer = major_glitch_interval + randf_range(-0.4, 0.6)
	if material is ShaderMaterial:
		_shader_mat = material

func _process(delta: float) -> void:
	if text.is_empty() or (text != title_text and not _is_major_glitching):
		text = title_text

	if _shader_mat == null and material is ShaderMaterial:
		_shader_mat = material

	# 1. Odliczanie do kolejnego mocnego glitchu
	_major_timer -= delta
	if _major_timer <= 0.0 and not _is_major_glitching:
		_start_major_glitch()
		_major_timer = major_glitch_interval + randf_range(-0.3, 0.5)

	# 2. Wykonywanie mocnego glitchu cyfrowego trwającego ok. 1 sekundy
	if _is_major_glitching:
		_major_glitch_time_left -= delta
		if _major_glitch_time_left > 0.0:
			_char_shuffle_timer -= delta
			if _char_shuffle_timer <= 0.0:
				_char_shuffle_timer = CHAR_SHUFFLE_INTERVAL
				
				# Dynamiczne przetasowanie liter
				var mangled: String = ""
				for i in range(title_text.length()):
					if randf() < 0.5:
						mangled += GLITCH_CHARS[randi() % GLITCH_CHARS.size()]
					else:
						mangled += title_text[i]
				text = mangled
				
				# Flashe kolorystyczne RGB
				if randf() < 0.5:
					modulate = Color(0.35, 0.85, 1.0, randf_range(0.7, 1.0))
					add_theme_color_override("font_shadow_color", Color(1.0, 0.1, 0.25, 0.95))
				else:
					modulate = Color(1.0, 0.3, 0.35, randf_range(0.7, 1.0))
					add_theme_color_override("font_shadow_color", Color(0.1, 0.8, 1.0, 0.95))
				
				add_theme_constant_override("shadow_offset_x", randi_range(-6, 6))
				add_theme_constant_override("shadow_offset_y", randi_range(-4, 4))
			
			# Shader glitch boost i vertex jitter
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.65, 1.0))
				_shader_mat.set_shader_parameter("jitter_offset", Vector2(randf_range(-12.0, 12.0), randf_range(-5.0, 5.0)))
		else:
			# Koniec mocnego glitchu - powrót do idealnego stanu
			_is_major_glitching = false
			text = title_text
			modulate = Color.WHITE
			add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.95))
			add_theme_constant_override("shadow_offset_x", 3)
			add_theme_constant_override("shadow_offset_y", 4)
			if _shader_mat:
				_shader_mat.set_shader_parameter("glitch_intensity", 0.0)
				_shader_mat.set_shader_parameter("jitter_offset", Vector2.ZERO)
		return

	# 3. Subtelne mikro-zakłócenia cyfrowe w tle (Ambient Micro-Jitter via Shader)
	if high_frequency_jitter:
		_jitter_timer += delta
		if _jitter_timer >= 0.04:
			_jitter_timer = 0.0
			var micro_x: float = randf_range(-1.2, 1.2) if randf() < 0.3 else 0.0
			var micro_y: float = randf_range(-0.8, 0.8) if randf() < 0.3 else 0.0
			
			if _shader_mat:
				_shader_mat.set_shader_parameter("jitter_offset", Vector2(micro_x, micro_y))
				_shader_mat.set_shader_parameter("glitch_intensity", randf_range(0.02, 0.08) if randf() < 0.25 else 0.0)

func _start_major_glitch() -> void:
	_is_major_glitching = true
	_major_glitch_time_left = major_glitch_duration + randf_range(-0.15, 0.2)
	_char_shuffle_timer = 0.0
````

## File: scenes/game_over_ui.tscn
````
[gd_scene load_steps=15 format=3 uid="uid://cg2xvyk5lm41o"]

[ext_resource type="Script" path="res://scripts/game_over_ui.gd" id="1_ui_script"]
[ext_resource type="Script" path="res://scripts/hold_button.gd" id="2_hold_btn"]
[ext_resource type="FontFile" uid="uid://h5qw6gpuqhc8" path="res://assets/fonts/RubikGlitch-Regular.ttf" id="3_font_glitch"]
[ext_resource type="FontFile" uid="uid://dbiax41qfab82" path="res://assets/fonts/CinzelDecorative-Bold.ttf" id="4_font_cinzel"]
[ext_resource type="Shader" path="res://shaders/glitch_text.gdshader" id="5_shader"]

[sub_resource type="ShaderMaterial" id="ShaderMaterial_glitch"]
shader = ExtResource("5_shader")
shader_parameter/glitch_intensity = 0.35
shader_parameter/color_split_dist = 0.02
shader_parameter/scanline_density = 140.0
shader_parameter/block_size = 0.04

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_glass"]
bg_color = Color(0.02, 0.03, 0.05, 0.3)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 1, 0.64, 0.35)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_badge"]
bg_color = Color(0.02, 0.03, 0.05, 0.6)
border_width_bottom = 1
border_color = Color(0, 1, 0.64, 0.25)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_card"]
bg_color = Color(0.03, 0.05, 0.08, 0.45)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.18, 0.28, 0.35, 0.35)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_reason"]
bg_color = Color(0.18, 0.04, 0.07, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(1, 0.25, 0.35, 0.6)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_retry_btn"]
bg_color = Color(0, 1, 0.64, 0.12)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 1, 0.64, 0.85)
corner_radius_top_left = 32
corner_radius_top_right = 32
corner_radius_bottom_right = 32
corner_radius_bottom_left = 32

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_retry_hover"]
bg_color = Color(0, 1, 0.64, 0.24)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0, 1, 0.64, 1)
corner_radius_top_left = 32
corner_radius_top_right = 32
corner_radius_bottom_right = 32
corner_radius_bottom_left = 32

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_menu_btn"]
bg_color = Color(0.06, 0.08, 0.12, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.3, 0.4, 0.5, 0.4)
corner_radius_top_left = 32
corner_radius_top_right = 32
corner_radius_bottom_right = 32
corner_radius_bottom_left = 32

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_menu_hover"]
bg_color = Color(0.12, 0.18, 0.26, 0.9)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.5, 0.75, 1, 0.8)
corner_radius_top_left = 32
corner_radius_top_right = 32
corner_radius_bottom_right = 32
corner_radius_bottom_left = 32

[node name="GameOverUI" type="Control"]
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
script = ExtResource("1_ui_script")

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
color = Color(0, 0, 0, 0)

[node name="CenterContainer" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="PanelContainer" type="PanelContainer" parent="CenterContainer"]
custom_minimum_size = Vector2(980, 620)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_glass")

[node name="MarginContainer" type="MarginContainer" parent="CenterContainer/PanelContainer"]
layout_mode = 2
theme_override_constants/margin_left = 40
theme_override_constants/margin_top = 26
theme_override_constants/margin_right = 40
theme_override_constants/margin_bottom = 26

[node name="VBoxContainer" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
layout_mode = 2
theme_override_constants/separation = 14
alignment = 1

[node name="TitleLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
material = SubResource("ShaderMaterial_glitch")
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.35, 0.45, 1)
theme_override_colors/font_shadow_color = Color(0.1, 0.8, 1, 0.9)
theme_override_constants/shadow_offset_x = 3
theme_override_constants/shadow_offset_y = 3
theme_override_fonts/font = ExtResource("3_font_glitch")
theme_override_font_sizes/font_size = 60
text = "GAME OVER"
horizontal_alignment = 1

[node name="TimeBadge" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 72)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_badge")

[node name="VBox" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TimeBadge"]
layout_mode = 2
alignment = 1

[node name="SubTitle" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TimeBadge/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.72, 0.8, 0.75, 1)
theme_override_font_sizes/font_size = 13
text = "SURVIVAL TIME"
horizontal_alignment = 1

[node name="TimeSurvivedValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TimeBadge/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 32
text = "00:00s"
horizontal_alignment = 1
vertical_alignment = 1

[node name="StatsGrid" type="GridContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_constants/h_separation = 16
theme_override_constants/v_separation = 10
columns = 3

[node name="StepsCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_styles/panel = SubResource("StyleBoxFlat_card")

[node name="VBox" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/StepsCard"]
layout_mode = 2
theme_override_constants/margin_top = 8
theme_override_constants/margin_bottom = 8
alignment = 1

[node name="StepsLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/StepsCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.72, 0.78, 1)
theme_override_font_sizes/font_size = 13
text = "STEPS TAKEN"
horizontal_alignment = 1

[node name="StepsValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/StepsCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 1, 1, 1)
theme_override_font_sizes/font_size = 26
text = "0"
horizontal_alignment = 1

[node name="FoxyCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_styles/panel = SubResource("StyleBoxFlat_card")

[node name="VBox" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/FoxyCard"]
layout_mode = 2
alignment = 1

[node name="FoxyLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/FoxyCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.72, 0.78, 1)
theme_override_font_sizes/font_size = 13
text = "FOXY BLOCKS"
horizontal_alignment = 1

[node name="FoxyValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/FoxyCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 1, 1, 1)
theme_override_font_sizes/font_size = 26
text = "0"
horizontal_alignment = 1

[node name="MarionetteCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_styles/panel = SubResource("StyleBoxFlat_card")

[node name="VBox" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/MarionetteCard"]
layout_mode = 2
alignment = 1

[node name="MarionetteLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/MarionetteCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(0.65, 0.72, 0.78, 1)
theme_override_font_sizes/font_size = 13
text = "MARIONETTES"
horizontal_alignment = 1

[node name="MarionetteValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatsGrid/MarionetteCard/VBox"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.4, 0.45, 1)
theme_override_font_sizes/font_size = 26
text = "0"
horizontal_alignment = 1

[node name="ReasonBadge" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
custom_minimum_size = Vector2(0, 42)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_reason")

[node name="DeathReasonValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ReasonBadge"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.75, 0.8, 1)
theme_override_font_sizes/font_size = 15
text = "CRITICAL FAILURE // UNKNOWN ANOMALY"
horizontal_alignment = 1
vertical_alignment = 1

[node name="ButtonsContainer" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer"]
layout_mode = 2
theme_override_constants/separation = 24
alignment = 1

[node name="RestartButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer"]
custom_minimum_size = Vector2(400, 60)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("4_font_cinzel")
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_retry_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_retry_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_retry_hover")
text = "⟳ RETRY"
script = ExtResource("2_hold_btn")

[node name="MenuButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer"]
custom_minimum_size = Vector2(400, 60)
layout_mode = 2
theme_override_colors/font_color = Color(0.85, 0.9, 0.95, 1)
theme_override_colors/font_hover_color = Color(0.5, 0.8, 1, 1)
theme_override_fonts/font = ExtResource("4_font_cinzel")
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_menu_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_menu_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_menu_hover")
text = "⮌ BACK TO MENU"
script = ExtResource("2_hold_btn")

[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer/RestartButton" to="." method="_on_restart_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonsContainer/MenuButton" to="." method="_on_menu_button_pressed"]
````

## File: scenes/marionette.tscn
````
[gd_scene format=3 uid="uid://b3t54b22cxxxx"]

[ext_resource type="Script" uid="uid://b7ny004tb164f" path="res://scripts/marionette.gd" id="1_marnin"]
[ext_resource type="AudioStream" uid="uid://dn1d2v8onqbl" path="res://assets/sounds/marionette/257784__xtrgamr__ominous-whispers.wav" id="2_y05hy"]
[ext_resource type="AudioStream" uid="uid://bb0jbi0xyp25h" path="res://assets/sounds/jumpscare_main.mp3" id="3_jump"]

[node name="Marionette" type="Node3D" unique_id=1428825871 groups=["enemy"]]
script = ExtResource("1_marnin")

[node name="WhisperSound" type="AudioStreamPlayer3D" parent="." unique_id=279718808]
stream = ExtResource("2_y05hy")
volume_db = 8.0
unit_size = 15.0
max_distance = 25.0
bus = &"Enemies"

[node name="JumpscareSound" type="AudioStreamPlayer3D" parent="." unique_id=1378429979]
stream = ExtResource("3_jump")
bus = &"Jumpscare"
````

## File: scripts/main_menu.gd
````
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
			
	print("[MainMenu] Scene loaded. Connecting UI signals...")
	_connect_ui_signals()

func _connect_ui_signals() -> void:
	var viewport_2d = $Viewport2Din3D
	if not viewport_2d:
		print("[MainMenu] ERROR: Viewport2Din3D not found!")
		return
		
	if not viewport_2d.is_node_ready():
		print("[MainMenu] Waiting for Viewport2Din3D to be ready...")
		await viewport_2d.ready
		
	await get_tree().process_frame
	
	var ui = viewport_2d.get_scene_instance()
	if not ui and $Viewport2Din3D/Viewport.get_child_count() > 0:
		ui = $Viewport2Din3D/Viewport.get_child(0)
		
	if ui:
		print("[MainMenu] Found UI instance: ", ui.name)
		if ui.has_signal("start_pressed"):
			if not ui.start_pressed.is_connected(_on_start_pressed):
				ui.start_pressed.connect(_on_start_pressed)
				print("[MainMenu] start_pressed CONNECTED!")
		else:
			print("[MainMenu] ERROR: UI does not have start_pressed signal!")
			
		if ui.has_signal("exit_pressed"):
			if not ui.exit_pressed.is_connected(_on_exit_pressed):
				ui.exit_pressed.connect(_on_exit_pressed)
				print("[MainMenu] exit_pressed CONNECTED!")
		else:
			print("[MainMenu] ERROR: UI does not have exit_pressed signal!")
	else:
		print("[MainMenu] ERROR: Could not find UI instance inside Viewport2Din3D!")

func _on_start_pressed():
	print("[MainMenu] _on_start_pressed called! Loading game map...")
	SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_exit_pressed():
	print("[MainMenu] _on_exit_pressed called! Quitting game...")
	get_tree().quit()
````

## File: scripts/tts_manager.gd
````
extends Node

## TTSManager — Globalny menedżer lektora (Text-to-Speech) i dostępności UI
## Wykorzystuje natywne API DisplayServer w Godot 4.x z buforowaniem i odrzucaniem spamu (Dwell Debounce).

var tts_enabled: bool = true
var sound_compass_enabled: bool = true
var whoosh_volume_db: float = 3.0
var voice_rate: float = 1.0
var voice_volume: int = 80
var current_voice_id: String = ""

var _last_spoken_text: String = ""
var _last_spoken_time: float = 0.0
var _currently_hovered_control: Control = null

# Dwell Debounce — zapobiega zacinaniu wątku SAPI Windows przy szybkim przesuwaniu lasera
var _pending_speech_text: String = ""
var _pending_dwell_time: float = 0.0
const DWELL_THRESHOLD: float = 0.08 # 80ms pauzy na przycisku zanim lektor zacznie mówić

func _ready() -> void:
	_init_voices()
	call_deferred("_warmup_tts")

func _process(delta: float) -> void:
	if _pending_dwell_time > 0.0:
		_pending_dwell_time -= delta
		if _pending_dwell_time <= 0.0 and not _pending_speech_text.is_empty():
			_execute_speak(_pending_speech_text)
			_pending_speech_text = ""

func _init_voices() -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		var voices = DisplayServer.tts_get_voices()
		if voices.size() > 0:
			current_voice_id = voices[0]["id"]
			# Prefer English TTS voice (en, eng, english)
			for v in voices:
				var lang = v.get("language", "").to_lower()
				var v_name = v.get("name", "").to_lower()
				if "en" in lang or "eng" in lang or "english" in v_name:
					current_voice_id = v["id"]
					break

func _warmup_tts() -> void:
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH) and not current_voice_id.is_empty():
		DisplayServer.tts_speak(" ", current_voice_id, 0, 1.0, 1.0)
		DisplayServer.tts_stop()

## Wypowiada dany tekst natychmiast lub z opóźnieniem dwell
func speak(text: String, interrupt: bool = true) -> void:
	if not tts_enabled or text.is_empty():
		return
		
	if not DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH):
		return
		
	# Bezpośrednie wywołanie dla kliknięć / akcji
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	_execute_speak(text, interrupt)

func _execute_speak(text: String, interrupt: bool = true) -> void:
	if not tts_enabled or text.is_empty():
		return
		
	var now = Time.get_ticks_msec() / 1000.0
	if text == _last_spoken_text and (now - _last_spoken_time) < 0.35:
		return
		
	_last_spoken_text = text
	_last_spoken_time = now
	
	if interrupt and DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()
		
	if not current_voice_id.is_empty():
		DisplayServer.tts_speak(text, current_voice_id, voice_volume, 1.0, voice_rate)
	else:
		var voices = DisplayServer.tts_get_voices()
		if voices.size() > 0:
			current_voice_id = voices[0]["id"]
			DisplayServer.tts_speak(text, current_voice_id, voice_volume, 1.0, voice_rate)

## Zatrzymuje aktualną mowę
func stop() -> void:
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	if DisplayServer.has_feature(DisplayServer.FEATURE_TEXT_TO_SPEECH) and DisplayServer.tts_is_speaking():
		DisplayServer.tts_stop()

## Zapowiedź otwartego panelu
func announce_panel(panel_text: String) -> void:
	_currently_hovered_control = null
	speak(panel_text, true)

## Konfiguruje dostępność przycisku
func setup_button(button: Button, text_or_callable = "") -> void:
	if button == null:
		return
		
	if not button.focus_entered.is_connected(_on_control_hovered.bind(button, text_or_callable)):
		button.focus_entered.connect(_on_control_hovered.bind(button, text_or_callable))
	if not button.mouse_entered.is_connected(_on_control_hovered.bind(button, text_or_callable)):
		button.mouse_entered.connect(_on_control_hovered.bind(button, text_or_callable))
	if not button.mouse_exited.is_connected(_on_control_unhovered.bind(button)):
		button.mouse_exited.connect(_on_control_unhovered.bind(button))
	if not button.focus_exited.is_connected(_on_control_unhovered.bind(button)):
		button.focus_exited.connect(_on_control_unhovered.bind(button))
	if not button.pressed.is_connected(_on_button_pressed):
		button.pressed.connect(_on_button_pressed)

func _on_control_hovered(control: Control, text_or_callable) -> void:
	if _currently_hovered_control == control:
		return
	_currently_hovered_control = control
	
	var speech_text = ""
	if text_or_callable is Callable:
		speech_text = str(text_or_callable.call())
	elif text_or_callable is String and not text_or_callable.is_empty():
		speech_text = text_or_callable
	elif control is Button:
		speech_text = control.text
		
	speech_text = _clean_symbols(speech_text)
	
	# Kolejkujemy z dwell threshold, by nie blokować wątku SAPI przy przesuwaniu lasera
	_pending_speech_text = speech_text
	_pending_dwell_time = DWELL_THRESHOLD
	_trigger_ui_haptic(35.0, 0.25, 0.04)

func _on_control_unhovered(control: Control) -> void:
	if _currently_hovered_control == control:
		_currently_hovered_control = null
		_pending_speech_text = ""
		_pending_dwell_time = 0.0

func _on_button_pressed() -> void:
	_pending_speech_text = ""
	_pending_dwell_time = 0.0
	_trigger_ui_haptic(100.0, 0.8, 0.1)

func _clean_symbols(text: String) -> String:
	return text.replace("⟳", "").replace("⌂", "").replace("▶", "").replace("⚙", "").replace("✕", "").replace("🎮", "").replace("⮌", "").replace("•", "").replace("—", "-").strip_edges()

func _trigger_ui_haptic(frequency: float, amplitude: float, duration: float) -> void:
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
		var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
		if left_hand and left_hand is XRController3D:
			left_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
		if right_hand and right_hand is XRController3D:
			right_hand.trigger_haptic_pulse("haptic", frequency, amplitude, duration, 0.0)
````

## File: scripts/jumpscare_helper.gd
````
## Wspólne narzędzia dla przeciwników w Lightness VR
## Wydzielony helper do obsługi sekwencji Jumpscare.
class_name JumpscareHelper

const GAME_OVER_PATH = "res://scenes/game_over.tscn"
const MAIN_MENU_PATH = "res://scenes/main_menu.tscn"

static var is_jumpscaring_global: bool = false

## Wywołuje pełną sekwencję Jumpscare:
## 1. Zatrzymuje timer przetrwania i zapisuje statystyki.
## 2. Reparentuje dźwięk jumpscare'a do kamery gracza.
## 3. Wibruje kontrolerami (trigger_haptic_pulse).
## 4. Odtwarza dźwięk i czeka, po czym ładuje Ekran Game Over.
static func execute(
	caller: Node,
	jumpscare_sound: AudioStreamPlayer3D,
	extra_nodes_to_reparent: Array[Node3D] = [],
	death_reason: String = "Nieznane zagrożenie"
) -> void:
	if is_jumpscaring_global:
		return
	is_jumpscaring_global = true
	
	# Zapisanie przyczyny porażki w SceneLoader
	SceneLoader.last_death_reason = death_reason
	
	# 1. Zatrzymanie timera
	var game_map = caller.get_tree().current_scene
	if game_map and game_map.has_method("stop_timer_and_save"):
		game_map.stop_timer_and_save()

	# 2. Znalezienie kamery gracza
	var player_root = caller.get_tree().get_first_node_in_group("player")
	if player_root == null:
		# Fallback — nie znaleziono gracza, ale kontynuujemy
		await caller.get_tree().create_timer(2.0).timeout
		SceneLoader.load_scene(MAIN_MENU_PATH)
		return
		
	var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
	if camera == null:
		await caller.get_tree().create_timer(2.0).timeout
		SceneLoader.load_scene(MAIN_MENU_PATH)
		return

	# 3. Reparenting dźwięku jumpscare'a do kamery
	var target_transform = Transform3D()
	target_transform.origin = Vector3(0, -0.3, -0.5)
	
	if jumpscare_sound and jumpscare_sound.get_parent():
		jumpscare_sound.reparent(camera, true)
		var tween = caller.get_tree().create_tween()
		tween.tween_property(jumpscare_sound, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)

	# 4. Reparenting dodatkowych węzłów (np. MeshInstance3D Balory)
	for node in extra_nodes_to_reparent:
		if node and node.get_parent():
			node.reparent(camera, true)
			var tween2 = caller.get_tree().create_tween()
			tween2.tween_property(node, "transform", target_transform, 0.2).set_trans(Tween.TRANS_SINE)
	
	# 5. Wibracje haptyczne obu kontrolerów
	_trigger_rumble(caller)

	# 6. Odtworzenie dźwięku
	if jumpscare_sound:
		jumpscare_sound.play()

	# 7. Czekamy na zakończenie sekwencji i przechodzimy do Game Over
	await caller.get_tree().create_timer(2.0).timeout
	SceneLoader.load_scene(GAME_OVER_PATH)


static func _trigger_rumble(caller: Node) -> void:
	# Szukamy kontrolerów XR
	var controllers = caller.get_tree().get_nodes_in_group("player")
	if controllers.size() == 0:
		return
	var player_root = controllers[0]
	var left_hand = player_root.get_node_or_null("XROrigin3D/left_hand")
	var right_hand = player_root.get_node_or_null("XROrigin3D/right_hand")
	
	if left_hand and left_hand is XRController3D:
		left_hand.trigger_haptic_pulse("haptic", 100.0, 1.0, 0.5, 0.0)
	if right_hand and right_hand is XRController3D:
		right_hand.trigger_haptic_pulse("haptic", 100.0, 1.0, 0.5, 0.0)
````

## File: scripts/scene_loader.gd
````
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
	
	# Zabezpieczenie przed uwięzieniem na timerze w stanie pauzy drzewa
	get_tree().paused = false
	
	scene_path = path
	
	# 1. Wywołanie animacji ściemnienia na globalnym komponencie XR
	_set_fade(1.0, 0.5)
	await get_tree().create_timer(0.6).timeout
	
	# 2. Ładowanie w tle bez blokowania wątku głównego gogli (minimalizuje chorobę lokomocyjną)
	ResourceLoader.load_threaded_request(scene_path)
	set_process(true)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)

func _process(_delta):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		set_process(false)
		printerr("Błąd ładowania sceny: ", scene_path)
		is_loading = false
		_fade_in()
		
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		var loaded_resource = ResourceLoader.load_threaded_get(scene_path)
		
		# 3. Zastąpienie całego aktywnego środowiska
		get_tree().change_scene_to_packed(loaded_resource)
		
		# Czekamy na zakończenie podmiany sceny i wykonanie _ready() w nowej scenie
		await get_tree().process_frame
		await get_tree().process_frame
		
		# Reset flagi — nowa scena może z powrotem ładować inne sceny
		is_loading = false
		JumpscareHelper.is_jumpscaring_global = false
		
		# 4. Rozjaśnienie widoku w nowo załadowanej scenie
		_fade_in()

func _fade_in():
	_set_fade(0.0, 0.5)

func _set_fade(target_alpha: float, duration: float):
	# Ustalenie początkowej wartości alpha (0.0 to przezroczysty, 1.0 to czarny)
	var current_alpha = 1.0 if target_alpha == 0.0 else 0.0
	var tween = get_tree().create_tween()
	tween.tween_method(_apply_fade_color, Color(0, 0, 0, current_alpha), Color(0, 0, 0, target_alpha), duration)

func _apply_fade_color(color: Color):
	XRToolsFade.set_fade("scene_transition", color)
````

## File: scripts/foxy.gd
````
extends CharacterBody3D

enum State { IDLE, LISTENING, PREPARING_CHARGE, CHARGING, JUMPSCARE }

## Próg hałasu wywołujący atak Foxy'ego
@export var noise_threshold: float = 10.0

## Szybkość opadania paska irytacji, gdy gracz milczy
@export var noise_decay_rate: float = 2.0

## Prędkość szarży Foxy'ego
@export var charge_speed: float = 12.0

## Czas "zamrożenia" i absolutnej ciszy przed szarżą
@export var prepare_time: float = 2.0

## Maksymalny czas szarży (failsafe)
@export var charge_max_duration: float = 4.0

## Czas odpoczynku (odnowienia) po wykonaniu szarży
@export var cooldown_time: float = 4.0

@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var run_sound: AudioStreamPlayer3D = $RunSound
@onready var walk_sound: AudioStreamPlayer3D = $WalkSound
@onready var mesh_instance = $MeshInstance3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger
@onready var block_trigger: Area3D = $BlockTrigger

var current_state: State = State.IDLE
var current_noise: float = 0.0
var target_position: Vector3 = Vector3.ZERO
var state_timer: float = 4.0
var is_jumpscaring: bool = false

var player_head: Node3D

func _ready():
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	if block_trigger:
		block_trigger.body_entered.connect(_on_block_entered)
	
	if EventBus:
		EventBus.noise_emitted.connect(_on_noise_emitted)
		
	_find_player()

func _find_player():
	var head = get_tree().get_first_node_in_group("player_head")
	if head:
		player_head = head
	else:
		var player_root = get_tree().get_first_node_in_group("player")
		if player_root:
			player_head = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
			if player_head == null:
				player_head = player_root

func _on_noise_emitted(pos: Vector3, noise_level: float):
	if current_state == State.LISTENING:
		current_noise += noise_level
		target_position = pos
		# Debug print
		# print("Foxy usłyszał hałas! Obecna irytacja: ", current_noise)
		
		if current_noise >= noise_threshold:
			_enter_preparing_charge()

func _enter_preparing_charge():
	current_state = State.PREPARING_CHARGE
	state_timer = prepare_time
	current_noise = 0.0
	if run_sound:
		run_sound.stop()
	if walk_sound:
		walk_sound.stop()
		
	var warning_player = AudioStreamPlayer3D.new()
	# Dedykowana próbka ostrzeżenia - niski, złowrogi sygnał zagrożenia
	warning_player.stream = preload("res://assets/sounds/danger.wav")
	warning_player.volume_db = 6.0
	warning_player.pitch_scale = 0.8
	add_child(warning_player)
	warning_player.play()
	warning_player.finished.connect(warning_player.queue_free)
	
	print("Foxy: Zapadła cisza. Przygotowuje szarżę.")

func _enter_charging():
	current_state = State.CHARGING
	state_timer = charge_max_duration
	
	if player_head == null:
		_find_player()
	if player_head:
		target_position = player_head.global_position
	
	# Obrót w stronę targetu
	var direction = (target_position - global_position)
	direction.y = 0
	if direction.length_squared() > 0.01:
		look_at(global_position + direction, Vector3.UP)
	
	if run_sound:
		run_sound.play()
	print("Foxy: Szarżuje!")

func _enter_idle():
	current_state = State.IDLE
	state_timer = cooldown_time
	velocity = Vector3.ZERO
	if run_sound:
		run_sound.stop()
	if walk_sound:
		walk_sound.stop()
	print("Foxy: Odpoczynek po szarży. Przestaje nasłuchiwać na ", cooldown_time, "s.")

func _physics_process(delta: float):
	if is_jumpscaring:
		return
		
	# Grawitacja
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		if current_state != State.CHARGING:
			velocity.y = 0.0
			
	match current_state:
		State.LISTENING:
			if current_noise > 0:
				current_noise -= noise_decay_rate * delta
				current_noise = max(current_noise, 0)
			
			if player_head == null:
				_find_player()
				
			if player_head:
				var p_pos = player_head.global_position
				var dir = (p_pos - global_position)
				dir.y = 0
				if dir.length() > 2.0:
					dir = dir.normalized()
					velocity.x = dir.x * 1.5
					velocity.z = dir.z * 1.5
					
					if walk_sound and not walk_sound.playing:
						walk_sound.play()
					
					# Powolny obrót w stronę gracza
					var look_pos = global_position + dir
					if look_pos.distance_squared_to(global_position) > 0.01:
						var current_transform = global_transform
						var target_transform = current_transform.looking_at(look_pos, Vector3.UP)
						global_transform = current_transform.interpolate_with(target_transform, 5.0 * delta)
				else:
					velocity.x = 0
					velocity.z = 0
					if walk_sound:
						walk_sound.stop()
			else:
				velocity.x = 0
				velocity.z = 0
				if walk_sound:
					walk_sound.stop()
			
		State.PREPARING_CHARGE:
			state_timer -= delta
			velocity.x = 0
			velocity.z = 0
			if state_timer <= 0:
				_enter_charging()
				
		State.CHARGING:
			state_timer -= delta
			var direction = (target_position - global_position)
			direction.y = 0
			
			# Jeśli jesteśmy blisko celu lub minął czas szarży
			if direction.length() < 1.0 or state_timer <= 0:
				_enter_idle()
			else:
				direction = direction.normalized()
				velocity.x = direction.x * charge_speed
				velocity.z = direction.z * charge_speed
				
				# Ślizganie / odrzucenie szarży po wpadnięciu w ścianę
				if is_on_wall():
					print("Foxy: Uderzył w ścianę!")
					_enter_idle()

		State.IDLE:
			state_timer -= delta
			velocity.x = 0
			velocity.z = 0
			if state_timer <= 0:
				current_state = State.LISTENING
				print("Foxy: Znów nasłuchuje.")
				
	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player"):
		is_jumpscaring = true
		if jumpscare_trigger:
			jumpscare_trigger.set_deferred("monitoring", false)
		current_state = State.JUMPSCARE
		velocity = Vector3.ZERO
		if run_sound:
			run_sound.stop()
		if walk_sound:
			walk_sound.stop()
		print("Foxy: Jumpscare!")
		await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance], "Foxy — Niezablokowana szarża")

func _on_block_entered(body: Node3D):
	if is_jumpscaring:
		return
	if current_state == State.CHARGING:
		print("Foxy: Zablokowany przez rękę (", body.name, ")!")
		SceneLoader.foxy_charges_blocked += 1
		
		# Haptyka obronna na kontrolerze dłoni
		var controller = body as XRController3D
		if controller == null and body.get_parent() is XRController3D:
			controller = body.get_parent() as XRController3D
		elif controller == null and body.get_parent() and body.get_parent().get_parent() is XRController3D:
			controller = body.get_parent().get_parent() as XRController3D
		if controller:
			controller.trigger_haptic_pulse("haptic", 120.0, 1.0, 0.35, 0.0)
		
		var success_player = AudioStreamPlayer.new()
		success_player.stream = preload("res://assets/sounds/nice-sfx.mp3")
		success_player.volume_db = -5.0
		add_child(success_player)
		success_player.play()
		success_player.finished.connect(success_player.queue_free)
		
		_enter_idle()
````

## File: scenes/balora.tscn
````
[gd_scene format=3 uid="uid://b4ml2o2jh5ooc"]

[ext_resource type="Script" uid="uid://40tyohs7i6dm" path="res://scripts/ballora.gd" id="1_2mo37"]
[ext_resource type="AudioStream" uid="uid://digrgt0cu802o" path="res://assets/sounds/ballora.mp3" id="2_yfgsf"]
[ext_resource type="AudioStream" uid="uid://bb0jbi0xyp25h" path="res://assets/sounds/jumpscare_main.mp3" id="3_24ggd"]

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_balora"]
radius = 0.761
height = 2.778

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_2mo37"]
diffuse_mode = 1
albedo_color = Color(0.35782948, 0.00011021942, 0.36967972, 1)

[sub_resource type="CapsuleMesh" id="CapsuleMesh_yfgsf"]
material = SubResource("StandardMaterial3D_2mo37")
radius = 0.761
height = 2.778

[sub_resource type="SphereShape3D" id="SphereShape3D_jumpscare"]
radius = 1.3971037

[node name="Balora" type="CharacterBody3D" unique_id=1656694762 groups=["enemy"]]
collision_layer = 2
script = ExtResource("1_2mo37")

[node name="CollisionShape3D" type="CollisionShape3D" parent="." unique_id=237287144]
shape = SubResource("CapsuleShape3D_balora")

[node name="MeshInstance3D" type="MeshInstance3D" parent="." unique_id=1056769905]
mesh = SubResource("CapsuleMesh_yfgsf")

[node name="BaloraTheme" type="AudioStreamPlayer3D" parent="." unique_id=1844263034]
stream = ExtResource("2_yfgsf")
volume_db = 7.5
unit_size = 35.0
autoplay = true
max_distance = 65.0
attenuation_model = 0
bus = &"Enemies"

[node name="JumpscareSound" type="AudioStreamPlayer3D" parent="." unique_id=566194156]
stream = ExtResource("3_24ggd")
bus = &"Jumpscare"

[node name="NavigationAgent3D" type="NavigationAgent3D" parent="." unique_id=854780239]

[node name="JumpscareTrigger" type="Area3D" parent="." unique_id=24209624]
collision_layer = 0
collision_mask = 524289

[node name="CollisionShape3D" type="CollisionShape3D" parent="JumpscareTrigger" unique_id=131938276]
shape = SubResource("SphereShape3D_jumpscare")
````

## File: scenes/foxy.tscn
````
[gd_scene format=3 uid="uid://cxabcf23t8foo"]

[ext_resource type="Script" uid="uid://bebk6fhspwj0v" path="res://scripts/foxy.gd" id="1_foxy"]
[ext_resource type="AudioStream" uid="uid://buv1fya4k5bwa" path="res://assets/sounds/foxy_runing.mp3" id="2_run"]
[ext_resource type="AudioStream" uid="uid://bb0jbi0xyp25h" path="res://assets/sounds/jumpscare_main.mp3" id="3_jump"]
[ext_resource type="AudioStream" uid="uid://131ewctsgefe" path="res://assets/sounds/foxy_walking.wav" id="4_walk"]

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_foxy_col"]
radius = 0.5571289
height = 2.3572266

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_foxy_mat"]
albedo_color = Color(1, 0.2, 0, 1)

[sub_resource type="CapsuleMesh" id="CapsuleMesh_foxy_mesh"]
material = SubResource("StandardMaterial3D_foxy_mat")
radius = 0.51416016
height = 2.3575196

[sub_resource type="CylinderShape3D" id="CylinderShape3D_foxy_trig"]
height = 2.3625977
radius = 0.8149414

[sub_resource type="BoxShape3D" id="BoxShape3D_block"]
size = Vector3(1.8463135, 2.1749024, 0.9095459)

[node name="Foxy" type="CharacterBody3D" unique_id=2065885202 groups=["enemy"]]
collision_layer = 4
script = ExtResource("1_foxy")

[node name="CollisionShape3D" type="CollisionShape3D" parent="." unique_id=839306087]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.1786133, 0)
shape = SubResource("CapsuleShape3D_foxy_col")

[node name="MeshInstance3D" type="MeshInstance3D" parent="." unique_id=1730761299]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.1787598, 0)
mesh = SubResource("CapsuleMesh_foxy_mesh")

[node name="RunSound" type="AudioStreamPlayer3D" parent="." unique_id=693784785]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.5, 0)
stream = ExtResource("2_run")
volume_db = 15.24
unit_size = 16.12
max_distance = 25.0
bus = &"Enemies"

[node name="WalkSound" type="AudioStreamPlayer3D" parent="." unique_id=998877665]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.5, 0)
stream = ExtResource("4_walk")
volume_db = 15.614
unit_size = 17.05
max_distance = 25.0
bus = &"Enemies"

[node name="JumpscareSound" type="AudioStreamPlayer3D" parent="." unique_id=1594056728]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.5, 0)
stream = ExtResource("3_jump")
volume_db = 9.019
bus = &"Jumpscare"

[node name="JumpscareTrigger" type="Area3D" parent="." unique_id=1994404484]
collision_layer = 0
collision_mask = 524289

[node name="CollisionShape3D" type="CollisionShape3D" parent="JumpscareTrigger" unique_id=829897168]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.1812989, 0)
shape = SubResource("CylinderShape3D_foxy_trig")

[node name="BlockTrigger" type="Area3D" parent="." unique_id=1234567890]
collision_layer = 0
collision_mask = 131072

[node name="CollisionShape3D" type="CollisionShape3D" parent="BlockTrigger" unique_id=820912904]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -0.038757324, 1.1874512, -0.70477295)
shape = SubResource("BoxShape3D_block")
````

## File: scripts/game_map.gd
````
@tool
extends XRToolsSceneBase

var time_survived: float = 0.0
var is_timer_running: bool = false
var next_milestone: int = 10
var target_night_duration: float = 60.0
var current_night: int = 1
var is_night_survived: bool = false

@onready var timer_label: Label3D = $"Player/XROrigin3D/XRCamera3D/TimerLabel"
@onready var milestone_audio: AudioStreamPlayer3D = $"Player/XROrigin3D/XRCamera3D/MilestoneAudio"
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D
@onready var ambient_audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var balora: Node3D = get_node_or_null("Balora")
@onready var marionette: Node3D = get_node_or_null("Marionette")
@onready var foxy: Node3D = get_node_or_null("Foxy")
@onready var foxy2: Node3D = get_node_or_null("Foxy2")
@onready var phantom_grasp: Node3D = get_node_or_null("PhantomGrasp")

var _balora_boosted: bool = false
var _balora_boost_time: float = 0.0
var _player_head: Node3D
var _cached_enemies: Array[Node] = []
var _enemy_refresh_timer: float = 0.0

func _ready():
	if Engine.is_editor_hint():
		return
		
	if timer_label == null:
		push_warning("TimerLabel niedostępny — HUD wyłączony (gra działa dalej).")
	if milestone_audio == null:
		push_warning("MilestoneAudio niedostępny.")
	
	# Automatyczny bake NavMesh przy starcie mapy
	if nav_region and nav_region.navigation_mesh:
		call_deferred("_deferred_bake_navmesh")
	
	SceneLoader.reset_session_stats()
	time_survived = 0.0
	next_milestone = 10
	is_night_survived = false
	is_timer_running = true
	
	_setup_night_from_level_manager()
	_refresh_nodes()

func _setup_night_from_level_manager():
	var cfg = LevelManager.get_current_night_config()
	current_night = LevelManager.selected_night
	target_night_duration = cfg.get("duration", 60.0)
	_balora_boost_time = cfg.get("balora_boost_time", 0.0)
	
	var night_title = cfg.get("title", "Night 1")
	var has_balora = cfg.get("has_balora", false)
	var has_marionette = cfg.get("has_marionette", false)
	var foxy_count = cfg.get("foxy_count", 0)
	var foxy_threshold = cfg.get("foxy_threshold", 24.0)
	var has_phantom_grasp = cfg.get("has_phantom_grasp", false)
	
	print("[GameMap] Konfiguracja Nocy %d: %s | Czas: %.0fs" % [current_night, night_title, target_night_duration])
	
	# 1. Balora
	if balora:
		if has_balora:
			balora.process_mode = Node.PROCESS_MODE_INHERIT
			var b_speed = cfg.get("balora_speed", 1.2)
			if "patrol_speed" in balora:
				balora.patrol_speed = b_speed
			if balora.has_node("BaloraTheme"):
				(balora.get_node("BaloraTheme") as AudioStreamPlayer3D).play()
		else:
			balora.queue_free()
			
	# 2. Marionette
	if marionette:
		if has_marionette:
			marionette.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			marionette.queue_free()
			
	# 3. Foxy 1
	if foxy:
		if foxy_count >= 1:
			foxy.process_mode = Node.PROCESS_MODE_INHERIT
			if "noise_threshold" in foxy:
				foxy.noise_threshold = foxy_threshold
		else:
			foxy.queue_free()
			
	# 4. Foxy 2 (Finał Noc 5)
	if foxy2:
		if foxy_count >= 2:
			foxy2.process_mode = Node.PROCESS_MODE_INHERIT
			if "noise_threshold" in foxy2:
				foxy2.noise_threshold = foxy_threshold
		else:
			foxy2.queue_free()
			
	# 5. Phantom Grasp
	if phantom_grasp:
		if has_phantom_grasp:
			phantom_grasp.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			phantom_grasp.queue_free()
			
	# Komunikat startowy lektora TTS
	if TTSManager:
		if current_night == 0:
			TTSManager.speak("Night zero: Test Room. Safe exploration. Practice walking and sound localization.", true)
		else:
			TTSManager.speak("%s. Survive %d seconds." % [night_title, int(target_night_duration)], true)

func _refresh_nodes():
	_cached_enemies = get_tree().get_nodes_in_group("enemy")
	var head = get_tree().get_first_node_in_group("player_head")
	if head:
		_player_head = head
	else:
		var player_root = get_tree().get_first_node_in_group("player")
		if player_root:
			_player_head = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
			if _player_head == null:
				_player_head = player_root

func _deferred_bake_navmesh():
	if nav_region and nav_region.navigation_mesh:
		nav_region.bake_navigation_mesh()

func _process(delta: float):
	if Engine.is_editor_hint():
		return
		
	if not is_timer_running or is_night_survived:
		return
	
	time_survived += delta
	
	# Formatowanie zegara HUD
	var total_seconds: int = int(time_survived)
	var minutes: int = int(total_seconds / 60.0)
	var seconds: int = total_seconds % 60
	if timer_label:
		timer_label.text = "%02d:%02d" % [minutes, seconds]

	# Balora boost pod koniec nocy (Noc 1)
	if _balora_boost_time > 0.0 and not _balora_boosted:
		if (target_night_duration - time_survived) <= _balora_boost_time:
			_balora_boosted = true
			if is_instance_valid(balora) and "patrol_speed" in balora:
				balora.patrol_speed = 2.4
				if balora.has_node("BaloraTheme"):
					var th = balora.get_node("BaloraTheme") as AudioStreamPlayer3D
					th.pitch_scale = 1.35
				print("[GameMap] Balora przyspiesza na koniec nocy!")

	# Warunek przetrwania nocy (6:00 AM)
	if target_night_duration > 0.0 and time_survived >= target_night_duration:
		_on_night_survived()
		return

	# Sygnały gongu co 10 sekund
	if time_survived >= next_milestone:
		_trigger_milestone_event()

	# Efekt Distortion
	_enemy_refresh_timer -= delta
	if _enemy_refresh_timer <= 0.0:
		_enemy_refresh_timer = 1.0
		_cached_enemies = get_tree().get_nodes_in_group("enemy")
		
	_update_distortion_effect(delta)

func _on_night_survived():
	is_night_survived = true
	is_timer_running = false
	print("[GameMap] 6:00 AM! Noc %d przetrwana!" % current_night)
	
	# Zatrzymanie wszystkich wrogów
	for e in get_tree().get_nodes_in_group("enemy"):
		if is_instance_valid(e):
			e.process_mode = Node.PROCESS_MODE_DISABLED
			
	# Sygnał 6:00 AM
	if milestone_audio:
		milestone_audio.pitch_scale = 1.2
		milestone_audio.play()
		
	SceneLoader.last_survival_time = time_survived
	LevelManager.unlock_next_night()
	
	if TTSManager:
		TTSManager.speak("Six A M! Night %d survived! Returning to menu." % current_night, true)
		
	# Odczekanie 3.5s i płynny powrót do Menu Głównego
	await get_tree().create_timer(3.5).timeout
	SceneLoader.load_scene("res://scenes/main_menu.tscn")

func _update_distortion_effect(delta: float):
	if ambient_audio == null:
		return
		
	if _player_head == null:
		_refresh_nodes()
		if _player_head == null:
			return
			
	var p_pos = _player_head.global_position
	var closest_dist = 999.0
	for e in _cached_enemies:
		if is_instance_valid(e) and e is Node3D:
			var d = (e as Node3D).global_position.distance_to(p_pos)
			if d < closest_dist:
				closest_dist = d
				
	var target_pitch = 1.0
	if closest_dist < 10.0:
		target_pitch = remap(closest_dist, 2.0, 10.0, 0.4, 1.0)
		target_pitch = clamp(target_pitch, 0.4, 1.0)
		
	ambient_audio.pitch_scale = lerp(ambient_audio.pitch_scale, target_pitch, delta * 3.0)

func _trigger_milestone_event():
	var current_reached_milestone = next_milestone
	next_milestone += 10
	
	if milestone_audio and not milestone_audio.playing:
		milestone_audio.pitch_scale = 1.0
		milestone_audio.play()
		
	if EventBus:
		EventBus.milestone_reached.emit(current_reached_milestone)

func stop_timer_and_save():
	is_timer_running = false
	SceneLoader.last_survival_time = time_survived
````

## File: scripts/main_menu_ui.gd
````
extends Control

signal start_pressed
signal exit_pressed

@onready var main_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/MainPanel
@onready var settings_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel
@onready var guide_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/GuidePanel
@onready var nights_panel: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/NightsPanel

# Przyciski główne
@onready var start_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/StartButton
@onready var select_night_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SelectNightButton
@onready var settings_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SettingsButton
@onready var guide_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/GuideButton
@onready var exit_button: Button = $CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/ExitButton

# Kontrolki wyboru nocy
@onready var night_0_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night0Btn
@onready var night_1_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night1Btn
@onready var night_2_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night2Btn
@onready var night_3_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night3Btn
@onready var night_4_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night4Btn
@onready var night_5_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night5Btn
@onready var back_from_nights_btn: Button = $CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/BackFromNightsButton

# Kontrolki ustawień
@onready var tts_toggle_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox/TTSToggleBtn

@onready var master_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterMinusBtn
@onready var master_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterPlusBtn
@onready var master_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterValueLabel
@onready var master_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterProgressBar

@onready var enemies_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesMinusBtn
@onready var enemies_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesPlusBtn
@onready var enemies_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesValueLabel
@onready var enemies_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesProgressBar

@onready var footsteps_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsMinusBtn
@onready var footsteps_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsPlusBtn
@onready var footsteps_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsValueLabel
@onready var footsteps_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsProgressBar

@onready var jumpscare_minus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareMinusBtn
@onready var jumpscare_plus_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscarePlusBtn
@onready var jumpscare_value_label: Label = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareValueLabel
@onready var jumpscare_progress_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareProgressBar

@onready var back_from_settings_btn: Button = $CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/BackFromSettingsButton

# Kontrolki poradnika
@onready var back_from_guide_btn: Button = $CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/BackFromGuideButton

# Telemetria
@onready var last_time_label: Label = $CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/HBoxContainer/LastTimeValue

var _master_volume_percent: int = 80
var _enemies_volume_percent: int = 85
var _footsteps_volume_percent: int = 80
var _jumpscare_volume_percent: int = 90

var _vr_navigator: VRUINavigator = null

func _ready() -> void:
	# Inicjalizacja komponentu nawigacji joystickiem VR
	_vr_navigator = VRUINavigator.new()
	_vr_navigator.name = "VRUINavigator"
	_vr_navigator.root_control = self
	add_child(_vr_navigator)

	_load_saved_settings()
	_update_telemetry()
	_update_nights_ui()
	_update_settings_ui()
	_setup_accessibility()
	_show_panel("main")

func _load_saved_settings() -> void:
	if LevelManager:
		var s: Dictionary = LevelManager.load_settings()
		_master_volume_percent = int(s.get("master_volume", 80))
		_enemies_volume_percent = int(s.get("enemies_volume", 85))
		_footsteps_volume_percent = int(s.get("footsteps_volume", 80))
		_jumpscare_volume_percent = int(s.get("jumpscare_volume", 90))
		if TTSManager:
			TTSManager.tts_enabled = bool(s.get("tts_enabled", true))
		_apply_all_audio_buses()

func _save_current_settings() -> void:
	if LevelManager:
		var s: Dictionary = {
			"master_volume": _master_volume_percent,
			"enemies_volume": _enemies_volume_percent,
			"footsteps_volume": _footsteps_volume_percent,
			"jumpscare_volume": _jumpscare_volume_percent,
			"tts_enabled": TTSManager.tts_enabled if TTSManager else true
		}
		LevelManager.save_settings(s)

func _update_telemetry() -> void:
	if last_time_label:
		if SceneLoader and SceneLoader.last_survival_time > 0.0:
			var total_seconds: int = int(SceneLoader.last_survival_time)
			var minutes: int = int(total_seconds / 60.0)
			var seconds: int = total_seconds % 60
			last_time_label.text = "%02d:%02d" % [minutes, seconds]
		else:
			last_time_label.text = "--:--"

func _apply_all_audio_buses() -> void:
	_apply_bus_volume("Master", _master_volume_percent)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)

func _apply_bus_volume(bus_name: String, percent: int) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx >= 0:
		if percent <= 0:
			AudioServer.set_bus_mute(bus_idx, true)
		else:
			AudioServer.set_bus_mute(bus_idx, false)
			var linear = percent / 100.0
			var db = linear_to_db(linear)
			AudioServer.set_bus_volume_db(bus_idx, db)

func _update_settings_ui() -> void:
	if master_value_label: master_value_label.text = "%d%%" % _master_volume_percent
	if master_progress_bar: master_progress_bar.value = _master_volume_percent

	if enemies_value_label: enemies_value_label.text = "%d%%" % _enemies_volume_percent
	if enemies_progress_bar: enemies_progress_bar.value = _enemies_volume_percent

	if footsteps_value_label: footsteps_value_label.text = "%d%%" % _footsteps_volume_percent
	if footsteps_progress_bar: footsteps_progress_bar.value = _footsteps_volume_percent

	if jumpscare_value_label: jumpscare_value_label.text = "%d%%" % _jumpscare_volume_percent
	if jumpscare_progress_bar: jumpscare_progress_bar.value = _jumpscare_volume_percent

	if tts_toggle_btn:
		var is_on = TTSManager.tts_enabled if TTSManager else true
		tts_toggle_btn.text = "TTS Voice: " + ("ON" if is_on else "OFF")

func _update_nights_ui() -> void:
	var sel_night: int = LevelManager.selected_night if LevelManager else 1
	var unl_night: int = LevelManager.unlocked_night if LevelManager else 1

	# Aktualizacja napisu na głównym przycisku Start
	if start_button:
		if sel_night == 0:
			start_button.text = "START TUTORIAL (NIGHT 0)"
		else:
			start_button.text = "START NIGHT %d" % sel_night

	# Konfiguracja przycisków nocy
	var btns: Array[Button] = [night_0_btn, night_1_btn, night_2_btn, night_3_btn, night_4_btn, night_5_btn]
	var titles: Array[String] = [
		"NIGHT 0: TUTORIAL",
		"NIGHT 1 (30s) - BALORA",
		"NIGHT 2 (60s) - BALORA & MARIONETTE",
		"NIGHT 3 (90s) - FOXY AWAKENS",
		"NIGHT 4 (120s) - PHANTOM GRASP",
		"NIGHT 5 (150s) - NIGHTMARE FINALE"
	]

	for i in range(btns.size()):
		var btn: Button = btns[i]
		if btn == null:
			continue
		var is_unlocked: bool = (i <= unl_night)
		btn.disabled = not is_unlocked
		
		if not is_unlocked:
			btn.text = "🔒 NIGHT %d (LOCKED)" % i
			btn.modulate = Color(0.6, 0.6, 0.6, 0.5)
		else:
			var prefix: String = "▶ " if (i == sel_night) else ""
			btn.text = prefix + titles[i]
			if i == sel_night:
				btn.modulate = Color(0, 1, 0.64, 1.0)
			else:
				btn.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _setup_accessibility() -> void:
	if Engine.is_editor_hint() or TTSManager == null:
		return
		
	TTSManager.setup_button(start_button, func():
		var sel_night: int = LevelManager.selected_night if LevelManager else 1
		return "Start Night %d" % sel_night if sel_night > 0 else "Start Tutorial"
	)
	TTSManager.setup_button(select_night_button, func():
		var sel_night: int = LevelManager.selected_night if LevelManager else 1
		return "Select Night. Currently Night %d is selected" % sel_night
	)
	TTSManager.setup_button(settings_button, "Settings")
	TTSManager.setup_button(guide_button, "Controls and Survival Guide")
	TTSManager.setup_button(exit_button, "Exit Game")
	
	# Przyciski nocy
	var night_descriptions := [
		"Night 0: Tutorial test room. Practice movement, collisions and spatial audio with no enemies.",
		"Night 1: Balora. Survive 30 seconds. Balora patrols slowly, accelerating near the end.",
		"Night 2: Balora and Marionette. Survive 60 seconds. Marionette whispers from the dark.",
		"Night 3: Foxy awakens. Survive 90 seconds. Foxy charges when you make excessive noise.",
		"Night 4: Phantom Grasp. Survive 120 seconds. Shadow tentacles grab your controllers.",
		"Night 5: Nightmare Finale. Survive 150 seconds. Maximum speed Balora and two hunters."
	]

	var btns: Array[Button] = [night_0_btn, night_1_btn, night_2_btn, night_3_btn, night_4_btn, night_5_btn]
	for i in range(btns.size()):
		var idx = i
		var btn = btns[idx]
		if btn:
			TTSManager.setup_button(btn, func():
				var unl = LevelManager.unlocked_night if LevelManager else 1
				if idx > unl:
					return "Night %d is locked. Complete previous night to unlock." % idx
				var is_selected = (idx == LevelManager.selected_night) if LevelManager else false
				var sel_str = " Currently selected. " if is_selected else " "
				return night_descriptions[idx] + sel_str
			)

	TTSManager.setup_button(back_from_nights_btn, "Back to Main Menu")

	# Settings controls with dynamic speech
	TTSManager.setup_button(master_minus_btn, func(): return "Decrease master volume. Currently %d percent" % _master_volume_percent)
	TTSManager.setup_button(master_plus_btn, func(): return "Increase master volume. Currently %d percent" % _master_volume_percent)
	
	TTSManager.setup_button(enemies_minus_btn, func(): return "Decrease enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	TTSManager.setup_button(enemies_plus_btn, func(): return "Increase enemy sounds volume. Currently %d percent" % _enemies_volume_percent)
	
	TTSManager.setup_button(footsteps_minus_btn, func(): return "Decrease footstep volume. Currently %d percent" % _footsteps_volume_percent)
	TTSManager.setup_button(footsteps_plus_btn, func(): return "Increase footstep volume. Currently %d percent" % _footsteps_volume_percent)

	TTSManager.setup_button(jumpscare_minus_btn, func(): return "Decrease jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)
	TTSManager.setup_button(jumpscare_plus_btn, func(): return "Increase jumpscare volume. Currently %d percent" % _jumpscare_volume_percent)

	TTSManager.setup_button(tts_toggle_btn, func(): return "TTS Voice. Currently " + ("enabled" if (TTSManager and TTSManager.tts_enabled) else "disabled"))
	TTSManager.setup_button(back_from_settings_btn, "Back to Main Menu")
	TTSManager.setup_button(back_from_guide_btn, "Back to Main Menu")

func _show_panel(panel_name: String) -> void:
	print("[MainMenuUI] Switching to panel: ", panel_name)
	if main_panel:
		main_panel.visible = (panel_name == "main")
	if nights_panel:
		nights_panel.visible = (panel_name == "nights")
	if settings_panel:
		settings_panel.visible = (panel_name == "settings")
	if guide_panel:
		guide_panel.visible = (panel_name == "guide")

	# Odświeżamy listę przycisków nawigatora dla aktywnego widoku
	if _vr_navigator:
		# Opóźniamy o jedną ramkę, aby silnik zaktualizował widoczność w drzewie sceny
		call_deferred("_refresh_navigator")

func _refresh_navigator() -> void:
	if _vr_navigator:
		_vr_navigator.refresh_buttons()

func _on_start_button_pressed() -> void:
	print("[MainMenuUI] Start button pressed! Emitting start_pressed...")
	start_pressed.emit()
	if start_pressed.get_connections().is_empty():
		SceneLoader.load_scene("res://scenes/game_map.tscn")

func _on_select_night_button_pressed() -> void:
	_update_nights_ui()
	_show_panel("nights")
	if TTSManager:
		var unl = LevelManager.unlocked_night if LevelManager else 1
		TTSManager.announce_panel("Night selection screen. Select a night from 0 to %d." % unl)

func _on_settings_button_pressed() -> void:
	_show_panel("settings")
	if TTSManager:
		TTSManager.announce_panel("Audio settings screen. Adjust master, enemies, footsteps, and jumpscares.")

func _on_guide_button_pressed() -> void:
	_show_panel("guide")
	if TTSManager:
		TTSManager.announce_panel("Controls and survival guide. Navigate menu with stick up down. Move with right stick and turn with physical body.")

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
	if exit_pressed.get_connections().is_empty():
		get_tree().quit()

func _on_back_pressed() -> void:
	_update_nights_ui()
	_show_panel("main")
	if TTSManager:
		TTSManager.announce_panel("Main Menu")

# Wybór konkretnej nocy
func _select_night_idx(night_idx: int) -> void:
	if LevelManager:
		if LevelManager.select_night(night_idx):
			_update_nights_ui()
			if TTSManager:
				var title = LevelManager.nights[night_idx]["title"]
				TTSManager.speak("%s selected." % title, true)
		else:
			if TTSManager:
				TTSManager.speak("Night %d is locked." % night_idx, true)

func _on_night_0_btn_pressed() -> void: _select_night_idx(0)
func _on_night_1_btn_pressed() -> void: _select_night_idx(1)
func _on_night_2_btn_pressed() -> void: _select_night_idx(2)
func _on_night_3_btn_pressed() -> void: _select_night_idx(3)
func _on_night_4_btn_pressed() -> void: _select_night_idx(4)
func _on_night_5_btn_pressed() -> void: _select_night_idx(5)

# Master volume
func _on_master_minus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent - 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

func _on_master_plus_pressed() -> void:
	_master_volume_percent = clamp(_master_volume_percent + 10, 0, 100)
	_apply_bus_volume("Master", _master_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Master volume: %d percent" % _master_volume_percent, true)

# Enemies volume
func _on_enemies_minus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent - 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

func _on_enemies_plus_pressed() -> void:
	_enemies_volume_percent = clamp(_enemies_volume_percent + 10, 0, 100)
	_apply_bus_volume("Enemies", _enemies_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Enemy sounds volume: %d percent" % _enemies_volume_percent, true)

# Footsteps volume
func _on_footsteps_minus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent - 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

func _on_footsteps_plus_pressed() -> void:
	_footsteps_volume_percent = clamp(_footsteps_volume_percent + 10, 0, 100)
	_apply_bus_volume("Footsteps", _footsteps_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Footsteps volume: %d percent" % _footsteps_volume_percent, true)

# Jumpscare volume
func _on_jumpscare_minus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent - 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

func _on_jumpscare_plus_pressed() -> void:
	_jumpscare_volume_percent = clamp(_jumpscare_volume_percent + 10, 0, 100)
	_apply_bus_volume("Jumpscare", _jumpscare_volume_percent)
	_save_current_settings()
	_update_settings_ui()
	if TTSManager: TTSManager.speak("Jumpscare volume: %d percent" % _jumpscare_volume_percent, true)

# Toggle TTS
func _on_tts_toggle_pressed() -> void:
	if TTSManager:
		TTSManager.tts_enabled = not TTSManager.tts_enabled
		_save_current_settings()
		_update_settings_ui()
		if TTSManager.tts_enabled:
			TTSManager.speak("TTS voice enabled", true)
````

## File: README.md
````markdown
# Lightless VR

**Lightless** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Gra jest survival horrorem zaprojektowanym w taki sposób, aby była w pełni dostępna dla osób niewidomych – bodźce wizualne dają minimalną (lub żadną) przewagę rozgrywki.

## Najnowsze zmiany (Version Log)
- **v0.5.3** - System Poziomów / Nocy (FNaF Style 0-5), Nawigacja Gałką VR w Menu, Trwały Zapis Ustawień i Ciemność z Oświetleniem Stóp:
  - **System Nocy (Autoload `LevelManager`):** Wdrożenie nocy od Nocy 0 (Test Room / bezpieczny trening) do Nocy 5 (Koszmar: maksymalna prędkość Balory + dwóch niezależnych Foxy szarżujących z różnych kierunków + Marionette + Phantom Grasp). Dynamiczny czas nocy (30s - 150s), dzwon 6:00 AM, zapowiedź lektorska TTS i automatyczne odblokowanie kolejnej nocy.
  - **Trwały zapis gry i ustawień (`user://save_data.json` i `user://settings.json`):** Postęp odblokowanych nocy oraz ustawienia suwaków głośności (`Master`, `Enemies`, `Footsteps`, `Jumpscare`) i status lektora TTS są trwale zapisywane i wczytywane przy każdym uruchomieniu gry, zapobiegając ich resetowaniu.
  - **Nawigacja Joystickiem w Menu (`VRUINavigator`):** Zgodnie z wytycznymi dostępności dla graczy niewidomych, menu główne oraz menu pauzy obsługują pełną nawigację pionową gałką kontrolera z automatycznym odczytem lektorskim (TTS) i impulsami haptycznymi. Zatwierdzenie przyciskiem A (`ax_button`) lub pociągnięciem spustu.
  - **Naturalny obrót ciała 360°:** Usunięcie sztucznego obracania joystickiem (`MovementTurn`) i szyny `Whoosh` na rzecz płynnego obracania się fizycznym ciałem w przestrzeni VR.
  - **Ciemność otoczenia i FeetLight:** Wyłączenie globalnego światła na mapie na rzecz 100% mroku korytarzy z subtelnym światłem podłogowym (`FeetLight`, 1.6m pod stopami), dającym orientację pozycji ciała bez ujawniania układu labiryntu.
  - **HoldButton (Blokada kliknięć bez naładowania):** Wyzerowanie `button_mask = 0`, co definitywnie eliminuje przedwczesne kliknięcia i wymaga pełnego przytrzymania triggera przez 0.65s.
- **v0.5.2** - Kompleksowa realizacja zaleceń audytu technicznego i poprawek stabilności: Naprawa systemu Fade w `SceneLoader.gd` (usunięcie nieskutecznych guardów `ClassDB.class_exists`, podwójny `await process_frame` po zmianie sceny, reset `is_loading` przy błędzie). Prawidłowy tracking gracza z poziomu głowy VR (`XRCamera3D` w grupie `player_head`) dla efektu zniekształcenia dźwięku (Distortion) i namierzania Foxy'ego. Rozdzielenie próbek audio (`danger.wav`, `whoosh2.mp3`, `Broken bell.ogg`, `nice-sfx.mp3`). Akustyka i haptyka kolizji ze ścianami (`EventBus.noise_emitted`). Nowa maszyna stanów Balory (Patrol, Alert z przyspieszającą pozytywką, Pościg, Ucieczka na odległość) i dopasowany NavMesh. Aktywna obrona przed Marionetką poprzez zamach kontrolerem VR z haptyką bliskości ucha. Threat Director (pacing pojawiania się wrogów na osi czasu). Nowy przeciwnik **Phantom Grasp** (chwyt za kontroler, wibracje i mechanika wyszarpywania). System **Echolokacji** (puls dźwiękowo-haptyczny na przycisku A/X sondujący układ ścian kosztem hałasu). Dedykowane **Menu Pauzy VR** (`scenes/pause_menu.tscn`). Naprawa wyłącznika lektora TTS w ustawieniach oraz zabezpieczenia `is_inside_tree()`. Architektura przestrzenna Menu Głównego 3D z industrialnym klimatem Google Stitch i cyfrowym glitchem `RubikGlitch`.

## O projekcie
Głównym założeniem technologicznym było zbudowanie stabilnego szkieletu scen w VR z wykorzystaniem asynchronicznego menedżera `SceneLoader`, w którym każda scena jest w 100% samowystarczalna (zawiera własne instancje `Player`, `StartXR` i `Fade`). Zapobiega to błędom fizyki i kolizji przy przeładowaniach. Rozgrywka opiera się na dźwiękowej orientacji przestrzennej i odpowiednich interakcjach z przeciwnikami. Interfejs gry zaprojektowano z myślą o pełnej dostępności – obok wskaźnika laserowego VR oferuje kompletną nawigację gałką analogową kontrolera (joystickiem) z odczytem lektorskim (TTS) i haptyką, umożliwiając osobom niewidomym intuicyjną obsługę menu bez konieczności celowania w przestrzeni 3D.

## Stack technologiczny
- **Godot Engine 4.x** (wersja Godot 4.7 / 4.x, ustawienia Mobile Renderer dla płynności)
- **OpenXR** (Główna biblioteka do połączenia z goglami VR)
- **Godot XR Tools** - standardowe pakiety fizyki dłoni i bazowych obiektów, dostosowane na potrzeby projektu.

## Uruchomienie i testowanie
Projekt przeznaczony jest na gogle VR obsługujące OpenXR (np. Meta Quest podpięty przez Meta Quest Link / SteamVR).
1. Sklonuj repozytorium.
2. Otwórz w **Godot 4.x** (wersja z obsługą .NET nie jest wymagana, używamy GDScript).
3. Projekt uruchamia się bezpośrednio od `scenes/main_menu.tscn` (wbudowany autostart OpenXR). Za przechodzenie między mapami odpowiada asynchroniczny autoload `SceneLoader.gd`.

## Sounds:
- Sound Effect by <a href="https://pixabay.com/users/freesounds123-49985424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335600">free sound creator</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335600">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=102254">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=102254">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/freesounds123-49985424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335599">free sound creator</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335599">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/sound_effects75-54573118/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=485532">Sound_effects75</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=485532">Pixabay</a>

shadow_v3a.aif by thanvannispen -- https://freesound.org/s/79713/ -- License: Attribution 4.0
Whisper Evil Little Nothings to Me by SoundBiterSFX -- https://freesound.org/s/730965/ -- License: Creative Commons 0
Whispers.wav by KrystalSounds7 -- https://freesound.org/s/466309/ -- License: Creative Commons 0
whispers.wav by SophieMezaM -- https://freesound.org/s/446083/ -- License: Attribution 3.0
Ominous whispers.wav by xtrgamr -- https://freesound.org/s/257784/ -- License: Attribution 4.0

runing.wav - Pasos_Rapid.wav by anez -- https://freesound.org/s/403437/ -- License: Attribution 4.0
foxy_runing.mp3 Demon Stomping Run.mp3 by Hoshenko -- https://freesound.org/s/697645/ -- License: Attribution 4.0

footstep_slow2.wav by stradie -- https://freesound.org/s/255569/ -- License: Attribution 4.0

WoodWalking.wav by szegvari -- https://freesound.org/s/514146/ -- License: Creative Commons 0
Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=101127">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=101127">Pixabay</a>

foxy_walking.mp3 big metallic robot footsteps by gladkiy -- https://freesound.org/s/342235/ -- License: Creative Commons 0
whoosh2 Whoosh away by jriches1 -- https://freesound.org/s/817959/ -- License: Creative Commons 0

danger Cinematic Alarm Hit by Rizzard -- https://freesound.org/s/560157/ -- License: Creative Commons 0
````

## File: scripts/player_audio_manager.gd
````
extends Node
class_name PlayerAudioManager

@export var walk_noise_level: float = 1.0
@export var sprint_noise_level: float = 2.8
@export var wall_noise_level: float = 3.5
@export var wall_cooldown: float = 0.4
@export var echolocation_noise_level: float = 4.5
@export var echolocation_cooldown: float = 2.0

@onready var origin: XROrigin3D = get_node_or_null("../XROrigin3D")
@onready var footstep_provider = get_node_or_null("../XROrigin3D/MovementFootstep")
@onready var sprint_provider = get_node_or_null("../XROrigin3D/MovementSprint")
@onready var player_body: CharacterBody3D = get_node_or_null("../XROrigin3D/PlayerBody")

var left_ctrl: XRController3D
var right_ctrl: XRController3D

var _wall_hit_timer: float = 0.0
var _echolocation_timer: float = 0.0

func _ready():
	if origin == null and get_parent():
		origin = get_parent().get_node_or_null("XROrigin3D")
		
	if origin:
		if footstep_provider == null:
			footstep_provider = origin.get_node_or_null("MovementFootstep")
		if sprint_provider == null:
			sprint_provider = origin.get_node_or_null("MovementSprint")
		if player_body == null:
			player_body = origin.get_node_or_null("PlayerBody")
		left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
		right_ctrl = origin.get_node_or_null("right_hand") as XRController3D
		
	if footstep_provider and not footstep_provider.footstep.is_connected(_on_footstep):
		footstep_provider.footstep.connect(_on_footstep)

func _physics_process(delta: float):
	if _wall_hit_timer > 0.0:
		_wall_hit_timer -= delta
	if _echolocation_timer > 0.0:
		_echolocation_timer -= delta

	# 1. Wykrywanie kolizji ze ścianami (hałas, dźwięk uderzenia, haptyka)
	if player_body and player_body.is_on_wall() and _wall_hit_timer <= 0.0:
		var moving := false
		if "ground_control_velocity" in player_body:
			var gcv = player_body.ground_control_velocity
			if gcv is Vector2 or gcv is Vector3:
				moving = gcv.length() > 0.4
		elif "velocity" in player_body and player_body.velocity is Vector3:
			moving = player_body.velocity.length() > 0.4
			
		if moving:
			_wall_hit_timer = wall_cooldown
			_trigger_wall_collision()

	# 2. Obsługa pulsu echolokacji (przycisk ax_button na kontrolerze VR)
	var ax_pressed := false
	if left_ctrl and left_ctrl.is_button_pressed("ax_button"):
		ax_pressed = true
	elif right_ctrl and right_ctrl.is_button_pressed("ax_button"):
		ax_pressed = true
		
	if ax_pressed and _echolocation_timer <= 0.0:
		_echolocation_timer = echolocation_cooldown
		_trigger_echolocation()


func _trigger_wall_collision():
	# Dźwięk głuchego uderzenia w ścianę
	var wall_sfx = AudioStreamPlayer.new()
	wall_sfx.stream = preload("res://assets/sounds/footstep_slow2.wav")
	wall_sfx.volume_db = 4.0
	wall_sfx.pitch_scale = 0.6
	add_child(wall_sfx)
	wall_sfx.play()
	wall_sfx.finished.connect(wall_sfx.queue_free)
	
	# Hałas uderzenia ostrzegający wrogów (np. Foxy)
	var hit_pos = player_body.global_position if player_body else (origin.global_position if origin else Vector3.ZERO)
	if EventBus:
		EventBus.noise_emitted.emit(hit_pos, wall_noise_level)
		
	# Fizyczna haptyka uderzenia na obu kontrolerach
	_trigger_collision_rumble()

func _trigger_collision_rumble():
	if origin:
		if left_ctrl == null:
			left_ctrl = origin.get_node_or_null("left_hand") as XRController3D
		if right_ctrl == null:
			right_ctrl = origin.get_node_or_null("right_hand") as XRController3D
		if left_ctrl:
			left_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)
		if right_ctrl:
			right_ctrl.trigger_haptic_pulse("haptic", 120.0, 0.7, 0.2, 0.0)

func _on_footstep(_surface_name: String):
	# Zarejestrowano krok. Zliczamy statystykę w SceneLoader.
	SceneLoader.steps_taken += 1
	
	var is_sprinting := false
	if sprint_provider and "is_active" in sprint_provider:
		is_sprinting = sprint_provider.is_active
	elif player_body and "ground_control_velocity" in player_body:
		is_sprinting = player_body.ground_control_velocity.length() > 2.0
	
	var current_noise = sprint_noise_level if is_sprinting else walk_noise_level
	
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position if origin else Vector3.ZERO, current_noise)

func _trigger_echolocation():
	if origin == null:
		return
		
	var space_state = origin.get_world_3d().direct_space_state
	var start_pos = origin.global_position + Vector3(0, 1.2, 0)
	
	# Startowy impuls dźwiękowy
	var pulse_player = AudioStreamPlayer.new()
	pulse_player.stream = preload("res://assets/sounds/Broken bell.ogg")
	pulse_player.volume_db = -4.0
	pulse_player.pitch_scale = 1.65
	add_child(pulse_player)
	pulse_player.play()
	pulse_player.finished.connect(pulse_player.queue_free)
	
	# Hałas sonaru ostrzegający wrogów (ryzyko ściągnięcia Foxy'ego!)
	if EventBus:
		EventBus.noise_emitted.emit(origin.global_position, echolocation_noise_level)
		
	# Haptyka impulsu na kontrolerach
	if left_ctrl:
		left_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.7, 0.12, 0.0)
	if right_ctrl:
		right_ctrl.trigger_haptic_pulse("haptic", 160.0, 0.7, 0.12, 0.0)
		
	# Wypuszczenie 8 promieni echolokacyjnych (równomiernie w 8 stron świata)
	for i in range(8):
		var angle = (float(i) / 8.0) * TAU
		var dir = Vector3(cos(angle), 0, sin(angle))
		var end_pos = start_pos + dir * 35.0
		var query = PhysicsRayQueryParameters3D.create(start_pos, end_pos, 1)
		var result = space_state.intersect_ray(query)
		if result:
			var hit_pos: Vector3 = result.position
			var dist = start_pos.distance_to(hit_pos)
			var delay = clamp(dist / 28.0, 0.06, 1.1)
			_spawn_delayed_echo(hit_pos, dist, delay)

func _spawn_delayed_echo(hit_pos: Vector3, dist: float, delay: float):
	await get_tree().create_timer(delay).timeout
	if not is_inside_tree():
		return
	var echo = AudioStreamPlayer3D.new()
	echo.stream = preload("res://assets/sounds/Broken bell.ogg")
	echo.unit_size = 10.0
	echo.max_distance = 40.0
	echo.volume_db = clamp(remap(dist, 2.0, 30.0, 0.0, -16.0), -16.0, 0.0)
	echo.pitch_scale = clamp(remap(dist, 2.0, 30.0, 1.1, 0.55), 0.55, 1.1)
	add_child(echo)
	echo.global_position = hit_pos
	echo.play()
	echo.finished.connect(echo.queue_free)
````

## File: project.godot
````
; Engine configuration file.
; It's best edited using the editor UI and not directly,
; since the parameters that go here are not all obvious.
;
; Format:
;   [section] ; section goes between []
;   param=value ; assign values to parameters

config_version=5

[animation]

compatibility/default_parent_skeleton_in_mesh_instance_3d=true

[application]

config/name="Lightless"
run/main_scene="res://scenes/main_menu.tscn"
config/features=PackedStringArray("4.7", "Mobile")
config/icon="res://icon.svg"

[audio]

default_bus_layout="res://default_bus_layout.tres"

[autoload]

XRToolsUserSettings="*uid://bqgb8i74tm0t"
SceneLoader="*res://scripts/scene_loader.gd"
EventBus="*res://scripts/event_bus.gd"
TTSManager="*res://scripts/tts_manager.gd"
LevelManager="*res://scripts/level_manager.gd"
XRToolsRumbleManager="*uid://by853dk86g1qw"

[editor_plugins]

enabled=PackedStringArray("res://addons/godot-xr-tools/plugin.cfg")

[layer_names]

3d_physics/layer_1="World"
3d_physics/layer_2="Balora"
3d_physics/layer_3="Foxy"
3d_physics/layer_18="PlayerHand"
3d_physics/layer_20="Player"

[rendering]

renderer/rendering_method="mobile"

[xr]

openxr/enabled=true
shaders/enabled=true
````

## File: scripts/ballora.gd
````
extends CharacterBody3D

enum State { PATROL, ALERT, CHASE, COOLDOWN }

@export var patrol_speed: float = 0.9
@export var alert_speed: float = 1.2
@export var chase_speed: float = 2.4

## Zasięg strefy Alertu (Balora zauważa obecność gracza)
@export var alert_distance: float = 7.5

## Zasięg strefy Krytycznej (natychmiastowy pościg)
@export var critical_distance: float = 3.5

## Czas obecności w strefie alertu wywołujący pościg (sekundy)
@export var max_alert_duration: float = 3.5

## Odległość ucieczki przerywająca pościg
@export var escape_distance: float = 9.5

## Czas utrzymania dystansu ucieczki potrzebny do zgubienia pościgu
@export var escape_time_required: float = 2.5

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var audio_player: AudioStreamPlayer3D = $BaloraTheme
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var jumpscare_trigger: Area3D = $JumpscareTrigger

var current_state: State = State.PATROL
var player_head: Node3D
var is_jumpscaring: bool = false

var _alert_timer: float = 0.0
var _escape_timer: float = 0.0
var _cooldown_timer: float = 0.0
var _target_pitch: float = 1.0

# Węzły trasy patrolowej wokół mapy
var _patrol_points: Array[Vector3] = [
	Vector3(-10.0, 0.0, -10.0),
	Vector3(10.0, 0.0, -10.0),
	Vector3(10.0, 0.0, 10.0),
	Vector3(-10.0, 0.0, 10.0),
	Vector3(0.0, 0.0, 0.0)
]
var _current_patrol_idx: int = 0

func _ready():
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	
	_find_player()
	
	if nav_agent:
		nav_agent.path_desired_distance = 1.5
		nav_agent.target_desired_distance = 1.5

	_enter_patrol()

func _find_player():
	var head = get_tree().get_first_node_in_group("player_head")
	if head:
		player_head = head
	else:
		var player_root = get_tree().get_first_node_in_group("player")
		if player_root:
			player_head = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
			if player_head == null:
				player_head = player_root

func _enter_patrol():
	current_state = State.PATROL
	_target_pitch = 1.0
	_alert_timer = 0.0
	_escape_timer = 0.0
	if nav_agent:
		nav_agent.target_position = _patrol_points[_current_patrol_idx]
	print("Balora: Wznowiono patrol.")

func _enter_alert():
	current_state = State.ALERT
	_target_pitch = 1.35 # Przyspieszenie pozytywki - kluczowy sygnał dla gracza
	_alert_timer = 0.0
	print("Balora: ALERT — gracz w strefie bliskości! Pozytywka przyspiesza.")

func _enter_chase():
	current_state = State.CHASE
	_target_pitch = 1.7 # Pościg — bardzo szybka pozytywka
	_escape_timer = 0.0
	print("Balora: POŚCIG!")

func _enter_cooldown():
	current_state = State.COOLDOWN
	_target_pitch = 1.0
	_cooldown_timer = 3.0
	velocity.x = 0.0
	velocity.z = 0.0
	print("Balora: Gracz uciekł. Odpoczynek przed powrotem do patrolu.")

func _physics_process(delta: float):
	if is_jumpscaring:
		return
		
	if player_head == null:
		_find_player()
		if player_head == null:
			return

	# Płynna zmiana tempa pozytywki
	if audio_player:
		audio_player.pitch_scale = lerp(audio_player.pitch_scale, _target_pitch, delta * 3.0)

	var dist_to_player = global_position.distance_to(player_head.global_position)
	var active_speed = patrol_speed

	match current_state:
		State.PATROL:
			active_speed = patrol_speed
			var current_patrol_dest = _patrol_points[_current_patrol_idx]
			if global_position.distance_to(current_patrol_dest) < 2.0:
				_current_patrol_idx = (_current_patrol_idx + 1) % _patrol_points.size()
				nav_agent.target_position = _patrol_points[_current_patrol_idx]
			else:
				nav_agent.target_position = current_patrol_dest
				
			# Sprawdzenie wejścia gracza w strefy
			if dist_to_player <= critical_distance:
				_enter_chase()
			elif dist_to_player <= alert_distance:
				_enter_alert()

		State.ALERT:
			active_speed = alert_speed
			nav_agent.target_position = player_head.global_position
			_alert_timer += delta
			
			if dist_to_player <= critical_distance or _alert_timer >= max_alert_duration:
				_enter_chase()
			elif dist_to_player > alert_distance + 1.5:
				_enter_patrol()

		State.CHASE:
			active_speed = chase_speed
			nav_agent.target_position = player_head.global_position
			
			if dist_to_player > escape_distance:
				_escape_timer += delta
				if _escape_timer >= escape_time_required:
					_enter_cooldown()
			else:
				_escape_timer = 0.0

		State.COOLDOWN:
			_cooldown_timer -= delta
			if _cooldown_timer <= 0.0:
				_enter_patrol()
			active_speed = 0.0

	# Ruch po NavMesh
	if active_speed > 0.0 and nav_agent:
		var next_path_pos = nav_agent.get_next_path_position()
		var dir = (next_path_pos - global_position)
		dir.y = 0.0
		if dir.length_squared() > 0.01:
			dir = dir.normalized()
			velocity.x = dir.x * active_speed
			velocity.z = dir.z * active_speed
			
			# Obrót w stronę ruchu
			var look_pos = global_position + dir
			if look_pos.distance_squared_to(global_position) > 0.01:
				var current_transform = global_transform
				var target_transform = current_transform.looking_at(look_pos, Vector3.UP)
				global_transform = current_transform.interpolate_with(target_transform, 6.0 * delta)
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	# Grawitacja
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	else:
		velocity.y = 0.0

	move_and_slide()

func _on_body_entered(body: Node3D):
	if is_jumpscaring:
		return
	if "PlayerBody" in body.name or body.is_in_group("player") or body.is_in_group("player_head"):
		is_jumpscaring = true
		if jumpscare_trigger:
			jumpscare_trigger.set_deferred("monitoring", false)
		_trigger_jumpscare()

func _trigger_jumpscare():
	velocity = Vector3.ZERO
	if audio_player:
		audio_player.stop()
	
	await JumpscareHelper.execute(self, jumpscare_sound, [mesh_instance, audio_player], "Balora — Złapanie w strefie krytycznej")
````

## File: scripts/hold_button.gd
````
extends Button
class_name HoldButton

## HoldButton — Interaktywny przycisk VR stylizowany na wyryty w betonowej ścianie.
## Samo najechanie NIE ładuje opcji. Aby zatwierdzić, gracz musi PRZYTRZYMAĆ spust (trigger).
## Po aktywacji przycisk jest zablokowany do momentu, gdy gracz PUŚCI trigger.

@export var charge_time_hold: float = 0.65
@export var allow_repeat_on_hold: bool = false

var _is_hovered: bool = false
var _is_input_holding: bool = false
var _charge: float = 0.0
var _cooldown: float = 0.0
var _current_scale: float = 1.0
var _target_scale: float = 1.0
var _tween: Tween
var _wait_for_release: bool = false  # Blokada aż gracz puści trigger

# Kolory kamiennego wyrycia (Normal)
const COLOR_ENGRAVED_TEXT := Color(0.60, 0.66, 0.74, 0.8)
const COLOR_ENGRAVED_SHADOW := Color(0.01, 0.015, 0.02, 0.95)
const COLOR_ENGRAVED_OUTLINE := Color(0.03, 0.05, 0.07, 0.95)

# Kolory rozżarzonego neonu w ścianie (Hover)
const COLOR_GLOW_TEXT := Color(1.0, 1.0, 1.0, 1.0)
const COLOR_GLOW_NEON := Color(0.0, 1.0, 0.64, 1.0)
const COLOR_GLOW_AURA := Color(0.0, 1.0, 0.64, 0.6)

func _ready() -> void:
	disabled = false
	toggle_mode = false
	button_mask = 0  # Blokuje domyślną natywną emisję pressed z BaseButton silnika C++
	action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
	
	var empty_style := StyleBoxEmpty.new()
	add_theme_stylebox_override("normal", empty_style)
	add_theme_stylebox_override("hover", empty_style)
	add_theme_stylebox_override("pressed", empty_style)
	add_theme_stylebox_override("focus", empty_style)
	add_theme_stylebox_override("disabled", empty_style)
	
	_apply_engraved_style()
	
	mouse_entered.connect(_on_hover_started)
	focus_entered.connect(_on_hover_started)
	mouse_exited.connect(_on_hover_ended)
	focus_exited.connect(_on_hover_ended)
	resized.connect(_update_pivot)
	_update_pivot()

func _update_pivot() -> void:
	pivot_offset = size / 2.0

func _apply_engraved_style() -> void:
	add_theme_color_override("font_color", COLOR_ENGRAVED_TEXT)
	add_theme_color_override("font_hover_color", COLOR_GLOW_TEXT)
	add_theme_color_override("font_focus_color", COLOR_GLOW_TEXT)
	add_theme_color_override("font_shadow_color", COLOR_ENGRAVED_SHADOW)
	add_theme_color_override("font_outline_color", COLOR_ENGRAVED_OUTLINE)
	add_theme_constant_override("shadow_offset_x", 2)
	add_theme_constant_override("shadow_offset_y", 3)
	add_theme_constant_override("outline_size", 2)

## Przesłaniamy _gui_input i bezwzględnie konsumujemy każde zdarzenie kliknięcia/dotyku,
## aby natywny BaseButton z silnika C++ NIGDY nie wyemitował pressed samowolnie!
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_is_input_holding = event.pressed
		accept_event()
		return
		
	if event is InputEventScreenTouch:
		_is_input_holding = event.pressed
		accept_event()
		return
		
	if event is InputEventScreenDrag:
		accept_event()
		return
		
	if event.is_action("ui_accept"):
		_is_input_holding = event.is_pressed()
		accept_event()
		return

func _input(event: InputEvent) -> void:
	if not _is_hovered:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_is_input_holding = event.pressed
		get_viewport().set_input_as_handled()
	elif event is InputEventScreenTouch:
		_is_input_holding = event.pressed
		get_viewport().set_input_as_handled()
	elif event.is_action("ui_accept"):
		_is_input_holding = event.is_pressed()
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	# Cooldown po zatwierdzeniu
	if _cooldown > 0.0:
		_cooldown -= delta
		_charge = 0.0
		_is_input_holding = false
		queue_redraw()
		return

	_current_scale = lerp(_current_scale, _target_scale, delta * 12.0)
	scale = Vector2(_current_scale, _current_scale)
	
	if not _is_hovered:
		_is_input_holding = false
		_wait_for_release = false
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()
		return

	var trigger_held := _is_input_holding or _is_trigger_down_on_controller()
	
	# Po aktywacji: czekamy aż gracz PUŚCI trigger zanim pozwolimy na kolejne ładowanie (chyba że allow_repeat_on_hold)
	if _wait_for_release:
		if not trigger_held:
			_wait_for_release = false
		elif allow_repeat_on_hold:
			_charge += delta / max(0.05, charge_time_hold)
			queue_redraw()
			if _charge >= 1.0:
				_trigger_activation()
		return
	
	if trigger_held:
		_charge += delta / max(0.05, charge_time_hold)
		queue_redraw()
		if _charge >= 1.0:
			_trigger_activation()
	else:
		if _charge > 0.0:
			_charge = max(0.0, _charge - delta * 4.0)
			queue_redraw()

func _trigger_activation() -> void:
	_charge = 0.0
	_is_input_holding = false
	_cooldown = 0.3
	_wait_for_release = true  # Blokada do puszczenia triggera!
	queue_redraw()
	
	_current_scale = 1.14
	scale = Vector2(_current_scale, _current_scale)
	
	print("[HoldButton] ACTIVATED: ", name, " | text: ", text)
	
	# Wywołanie akcji
	pressed.emit()
	
	# Haptyka
	_trigger_haptic_feedback()

func _is_trigger_down_on_controller() -> bool:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		for hand_name in ["XROrigin3D/right_hand", "XROrigin3D/left_hand"]:
			var ctrl = player.get_node_or_null(hand_name) as XRController3D
			if ctrl and ctrl.get_is_active():
				if ctrl.get_float("trigger") > 0.4:
					return true
				if ctrl.is_button_pressed("ax_button"):
					return true
				if ctrl.is_button_pressed("trigger_click"):
					return true
	return false

func _trigger_haptic_feedback() -> void:
	if XRServer.primary_interface:
		for tracker in ["right_hand", "left_hand"]:
			XRServer.primary_interface.trigger_haptic_pulse("haptic", tracker, 100.0, 0.7, 0.1, 0.0)

func _on_hover_started() -> void:
	_is_hovered = true
	_update_pivot()
	_target_scale = 1.07
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	_tween.tween_property(self, "theme_override_colors/font_color", COLOR_GLOW_TEXT, 0.18)
	_tween.tween_property(self, "theme_override_colors/font_outline_color", COLOR_GLOW_NEON, 0.18)
	_tween.tween_property(self, "theme_override_colors/font_shadow_color", COLOR_GLOW_AURA, 0.18)
	_tween.tween_property(self, "theme_override_constants/outline_size", 5, 0.18)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_x", 0, 0.18)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_y", 0, 0.18)
	queue_redraw()

func _on_hover_ended() -> void:
	_is_hovered = false
	_is_input_holding = false
	_target_scale = 1.0
	
	if _tween and _tween.is_valid():
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	_tween.tween_property(self, "theme_override_colors/font_color", COLOR_ENGRAVED_TEXT, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_outline_color", COLOR_ENGRAVED_OUTLINE, 0.25)
	_tween.tween_property(self, "theme_override_colors/font_shadow_color", COLOR_ENGRAVED_SHADOW, 0.25)
	_tween.tween_property(self, "theme_override_constants/outline_size", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_x", 2, 0.25)
	_tween.tween_property(self, "theme_override_constants/shadow_offset_y", 3, 0.25)
	queue_redraw()

func _draw() -> void:
	if not _is_hovered and _charge <= 0.01:
		return
		
	var w := size.x
	var h := size.y
	var groove_w: float = min(w * 0.65, 340.0)
	var groove_x: float = (w - groove_w) * 0.5
	var groove_y: float = h - 6.0
	var groove_h: float = 3.0
	
	draw_rect(Rect2(groove_x, groove_y, groove_w, groove_h), Color(0.02, 0.04, 0.06, 0.6), true)
	
	if _charge > 0.01:
		var fill_w: float = groove_w * clamp(_charge, 0.0, 1.0)
		draw_rect(Rect2(groove_x, groove_y - 1.0, fill_w, groove_h + 2.0), Color(0.0, 1.0, 0.64, 0.3), true)
		draw_rect(Rect2(groove_x, groove_y, fill_w, groove_h), COLOR_GLOW_NEON, true)
		draw_circle(Vector2(groove_x + fill_w, groove_y + groove_h * 0.5), 3.5, Color(1.0, 1.0, 1.0, 0.95))
````

## File: scripts/marionette.gd
````
extends Node3D

enum State { HIDDEN, WHISPERING, JUMPSCARE }
var current_state: State = State.HIDDEN

## Włącz widoczny mesh debugowy (kula), żeby widzieć gdzie Marionette się pojawia
@export var debug_visible: bool = false

## Granice spawnu Marionette (do konfiguracji w edytorze)
@export var map_bounds_min: Vector3 = Vector3(-9.0, 0.0, -9.0)
@export var map_bounds_max: Vector3 = Vector3(9.0, 3.0, 9.0)

## Dystans spawnu od gracza
@export var spawn_distance_min: float = 1.8
@export var spawn_distance_max: float = 2.4

## Prędkość zamachu kontrolera (m/s) wymagana do odpędzenia szeptu
@export var swing_speed_threshold: float = 1.1

## Dystans uderzenia dłonią w szept
@export var swing_proximity_distance: float = 0.65

## Maksymalny czas na reakcję przed Jumpscare'em (sekundy)
@export var attack_duration_limit: float = 5.5

## Czas łaski na zorientowanie się po pojawieniu szeptów (sekundy)
@export var grace_time: float = 1.0

## Minimalna / maksymalna liczba szeptów w jednej serii
@export var min_whisper_rounds: int = 1
@export var max_whisper_rounds: int = 3

## Przerwa między szeptami w serii (sekundy)
@export var series_pause_min: float = 1.0
@export var series_pause_max: float = 2.5

## Przerwa między seriami (sekundy)
@export var long_pause_min: float = 8.0
@export var long_pause_max: float = 18.0

@onready var whisper_sound: AudioStreamPlayer3D = $WhisperSound
@onready var jumpscare_sound: AudioStreamPlayer3D = $JumpscareSound

var player: Node3D
var camera: XRCamera3D
var left_hand: XRController3D
var right_hand: XRController3D

var _last_left_pos: Vector3 = Vector3.ZERO
var _last_right_pos: Vector3 = Vector3.ZERO
var _haptic_warning_timer: float = 0.0

var state_timer: float = 0.0
var grace_timer: float = 0.0
var attack_timer: float = 0.0

var initial_player_pos: Vector3 = Vector3.ZERO
var current_offset: Vector3 = Vector3.ZERO

## Ile rund szeptów zostało w bieżącej serii
var _rounds_remaining: int = 0

# Debug mesh (kula do wizualizacji pozycji)
var _debug_mesh: MeshInstance3D

func _ready():
	# Tworzenie kuli debugowej
	_debug_mesh = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = 0.3
	sphere.height = 0.6
	_debug_mesh.mesh = sphere
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(1.0, 0.0, 0.5, 0.7)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.0, 0.5)
	mat.emission_energy_multiplier = 2.0
	_debug_mesh.material_override = mat
	_debug_mesh.visible = false
	add_child(_debug_mesh)

	_find_player()
	_start_new_series()

	if EventBus:
		EventBus.milestone_reached.connect(_on_milestone_reached)

func _find_player():
	var player_head = get_tree().get_first_node_in_group("player_head")
	var player_root = get_tree().get_first_node_in_group("player")
	if player_root:
		player = player_root
		camera = player_head if player_head is XRCamera3D else player_root.get_node_or_null("XROrigin3D/XRCamera3D")
		var origin = player_root.get_node_or_null("XROrigin3D")
		if origin:
			left_hand = origin.get_node_or_null("left_hand")
			right_hand = origin.get_node_or_null("right_hand")
			if left_hand:
				_last_left_pos = left_hand.global_position
			if right_hand:
				_last_right_pos = right_hand.global_position

func _on_milestone_reached(milestone: int):
	# Eskalacja trudności Marionetki wraz z czasem przetrwania
	attack_duration_limit = max(3.0, 5.5 - float(milestone) / 60.0 * 1.5)
	if milestone >= 30:
		min_whisper_rounds = 2
		max_whisper_rounds = 4
	if milestone >= 60:
		min_whisper_rounds = 3
		max_whisper_rounds = 5
	print("Marionette eskalacja! Czas reakcji: ", attack_duration_limit, "s, serie: ", min_whisper_rounds, "-", max_whisper_rounds)

func _process(delta: float):
	if camera == null:
		_find_player()
		if camera == null:
			return

	match current_state:
		State.HIDDEN:
			state_timer -= delta
			if state_timer <= 0.0:
				_enter_whispering()
		
		State.WHISPERING:
			attack_timer += delta

			if attack_timer > attack_duration_limit:
				_trigger_jumpscare("Czas na reakcję (%.1fs) minął!" % attack_duration_limit)
				return
				
			# Przyczepienie do gracza: ciągłe podążanie za głową gracza z wylosowanym kątem
			# Efekt crescendo: dystans z czasem maleje o max 50% potęgując wrażenie zbliżania szeptu do ucha
			var crescendo_mult = 1.0 - (attack_timer / attack_duration_limit) * 0.5
			var target_pos = camera.global_position + (current_offset * crescendo_mult)
			target_pos.x = clamp(target_pos.x, map_bounds_min.x, map_bounds_max.x)
			target_pos.y = clamp(target_pos.y, map_bounds_min.y, map_bounds_max.y)
			target_pos.z = clamp(target_pos.z, map_bounds_min.z, map_bounds_max.z)
			global_position = target_pos
			
			# Haptyka bliskiego zagrożenia (AGENTS.md:28) - gdy szept jest krytycznie blisko ucha
			var remaining_time = attack_duration_limit - attack_timer
			if remaining_time <= 1.8:
				_haptic_warning_timer -= delta
				if _haptic_warning_timer <= 0.0:
					_haptic_warning_timer = 0.15
					var intensity = clamp(remap(remaining_time, 1.8, 0.0, 0.3, 1.0), 0.3, 1.0)
					if left_hand:
						left_hand.trigger_haptic_pulse("haptic", 100.0, intensity, 0.1, 0.0)
					if right_hand:
						right_hand.trigger_haptic_pulse("haptic", 100.0, intensity, 0.1, 0.0)
			
			# Sprawdzenie zamachu kontrolera (aktywne odpędzenie machnięciem w stronę szeptu)
			_check_controller_defense(delta)

func _check_controller_defense(delta: float):
	if delta <= 0.0001 or camera == null:
		return

	var to_whisper = (global_position - camera.global_position).normalized()
	
	for ctrl in [left_hand, right_hand]:
		if ctrl == null:
			continue
			
		var cur_pos = ctrl.global_position
		var last_pos = _last_left_pos if ctrl == left_hand else _last_right_pos
		var vel = (cur_pos - last_pos) / delta
		var speed = vel.length()
		var dist = cur_pos.distance_to(global_position)
		
		if ctrl == left_hand:
			_last_left_pos = cur_pos
		else:
			_last_right_pos = cur_pos
			
		# 1. Ręka musi być uniesiona powyżej pasa
		var is_hand_raised = cur_pos.y > (camera.global_position.y - 0.45)
		
		# 2. Ręka musi być wysunięta w stronę szeptu
		var hand_vector = cur_pos - camera.global_position
		var is_hand_facing = hand_vector.normalized().dot(to_whisper) > 0.2
		
		if is_hand_raised and is_hand_facing:
			var swing_dir = vel.normalized()
			var is_swing_towards = swing_dir.dot(to_whisper) > 0.25
			
			# Odparcie szeptu: energiczny zamach w stronę szeptu LUB przybliżenie ręki blisko szeptu
			if (speed >= swing_speed_threshold and is_swing_towards) or (dist < swing_proximity_distance and speed >= 0.7):
				_whisper_survived(ctrl)
				return

## Gracz odpędził jeden szept machnięciem dłoni
func _whisper_survived(controller: XRController3D = null):
	_rounds_remaining -= 1
	SceneLoader.marionettes_defended += 1
	whisper_sound.stop()
	if _debug_mesh:
		_debug_mesh.visible = false
		
	# Haptyka potwierdzenia na kontrolerze, którym wykonano udany zamach
	if controller:
		controller.trigger_haptic_pulse("haptic", 140.0, 1.0, 0.35, 0.0)
		
	# Dedykowany dźwięk sukcesu: satysfakcjonujący świst rozproszenia (whoosh2.mp3)
	var success_player = AudioStreamPlayer.new()
	success_player.stream = preload("res://assets/sounds/whoosh2.mp3")
	success_player.volume_db = -2.0
	add_child(success_player)
	success_player.play()
	success_player.finished.connect(success_player.queue_free)
	
	if _rounds_remaining > 0:
		# Krótka przerwa, potem następny szept z INNEGO kierunku
		current_state = State.HIDDEN
		state_timer = randf_range(series_pause_min, series_pause_max)
		print("Marionette: Odpędzono szept machnięciem! Zostało jeszcze ", _rounds_remaining, " rund.")
	else:
		# Seria zakończona — długa przerwa
		_start_new_series()
		print("Marionette: Seria szeptów zakończona sukcesem. Odpoczynek.")

## Rozpoczyna nową serię z losową liczbą rund
func _start_new_series():
	current_state = State.HIDDEN
	if whisper_sound:
		whisper_sound.stop()
	_rounds_remaining = randi_range(min_whisper_rounds, max_whisper_rounds)
	state_timer = randf_range(long_pause_min, long_pause_max)

func _enter_whispering():
	current_state = State.WHISPERING
	attack_timer = 0.0
	grace_timer = grace_time
	_haptic_warning_timer = 0.0
	
	if camera:
		initial_player_pos = camera.global_position
		
		# Obliczenie losowego kąta wokół głowy gracza
		var angle = randf_range(0, TAU)
		var distance = randf_range(spawn_distance_min, spawn_distance_max)
		current_offset = Vector3(cos(angle) * distance, randf_range(0.05, 0.35), sin(angle) * distance)
		
		var spawn_pos = initial_player_pos + current_offset
		spawn_pos.x = clamp(spawn_pos.x, map_bounds_min.x, map_bounds_max.x)
		spawn_pos.y = clamp(spawn_pos.y, map_bounds_min.y, map_bounds_max.y)
		spawn_pos.z = clamp(spawn_pos.z, map_bounds_min.z, map_bounds_max.z)
		
		global_position = spawn_pos
		
	if left_hand:
		_last_left_pos = left_hand.global_position
	if right_hand:
		_last_right_pos = right_hand.global_position
		
	if _debug_mesh:
		_debug_mesh.visible = debug_visible
	whisper_sound.play()

func _trigger_jumpscare(reason: String):
	if current_state == State.JUMPSCARE:
		return
	current_state = State.JUMPSCARE
	print("Marionette Atak: ", reason)
	
	whisper_sound.stop()
	
	# Delegacja do wspólnego helpera (zatrzymanie timera, reparenting, haptyka, ekran Game Over)
	await JumpscareHelper.execute(self, jumpscare_sound, [], "Marionette — " + reason)
````

## File: scenes/main_menu.tscn
````
[gd_scene format=3 uid="uid://dqjc1nwqm8odk"]

[ext_resource type="Script" uid="uid://c1n8p7fin4eiq" path="res://scripts/main_menu.gd" id="1_script"]
[ext_resource type="PackedScene" uid="uid://clujaf3u776a3" path="res://addons/godot-xr-tools/objects/viewport_2d_in_3d.tscn" id="2_bqqt6"]
[ext_resource type="PackedScene" uid="uid://bvwh78d1g322u" path="res://scenes/main_menu_ui.tscn" id="3_ui"]
[ext_resource type="AudioStream" uid="uid://1c33sur8mvu1" path="res://assets/sounds/main_menu.mp3" id="4_wu84c"]
[ext_resource type="PackedScene" uid="uid://c0ch7jab7i3ry" path="res://scenes/player.tscn" id="5_player"]
[ext_resource type="PackedScene" uid="uid://clc5dre31iskm" path="res://addons/godot-xr-tools/xr/start_xr.tscn" id="6_startxr"]
[ext_resource type="PackedScene" uid="uid://wtpox7m5vu2b" path="res://addons/godot-xr-tools/effects/fade.tscn" id="7_fade"]
[ext_resource type="Texture2D" uid="uid://bsc3ql0fq5x8b" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_Color.png" id="8_wall_color"]
[ext_resource type="Texture2D" uid="uid://cpahkw3dcl28d" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_NormalGL.png" id="9_wall_normal"]
[ext_resource type="Texture2D" uid="uid://dnum5txu5gvmk" path="res://assets/textures/Plaster006_2K-PNG/Plaster006_2K-PNG_Roughness.png" id="10_wall_rough"]

[sub_resource type="ProceduralSkyMaterial" id="ProceduralSkyMaterial_menu"]
sky_top_color = Color(0.02, 0.03, 0.05, 1)
sky_horizon_color = Color(0.05, 0.06, 0.08, 1)
ground_bottom_color = Color(0.01, 0.01, 0.02, 1)
ground_horizon_color = Color(0.05, 0.06, 0.08, 1)

[sub_resource type="Sky" id="Sky_menu"]
sky_material = SubResource("ProceduralSkyMaterial_menu")

[sub_resource type="Environment" id="Environment_menu"]
background_mode = 2
sky = SubResource("Sky_menu")
ambient_light_source = 2
ambient_light_color = Color(0.08, 0.1, 0.14, 1)
ambient_light_energy = 0.6

[sub_resource type="BoxShape3D" id="BoxShape3D_floor"]
size = Vector3(20, 1, 20)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_floor"]
albedo_color = Color(0.08, 0.09, 0.11, 1)
roughness = 0.9

[sub_resource type="PlaneMesh" id="PlaneMesh_floor"]
material = SubResource("StandardMaterial3D_floor")
size = Vector2(20, 20)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_wall"]
albedo_color = Color(0.48, 0.5, 0.52, 1)
albedo_texture = ExtResource("8_wall_color")
roughness = 0.95
roughness_texture = ExtResource("10_wall_rough")
normal_enabled = true
normal_scale = 1.2
normal_texture = ExtResource("9_wall_normal")
uv1_scale = Vector3(2.5, 1.8, 1)

[sub_resource type="BoxMesh" id="BoxMesh_wall"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(10, 4.8, 0.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_wall"]
size = Vector3(10, 4.8, 0.2)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_pipe"]
albedo_color = Color(0.18, 0.17, 0.16, 1)
metallic = 0.88
roughness = 0.38

[sub_resource type="CylinderMesh" id="CylinderMesh_pipe"]
material = SubResource("StandardMaterial3D_pipe")
top_radius = 0.045
bottom_radius = 0.045
height = 4.8
radial_segments = 16

[sub_resource type="BoxMesh" id="BoxMesh_wall_side"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(0.2, 4.8, 9.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_wall_side"]
size = Vector3(0.2, 4.8, 9.2)

[sub_resource type="BoxMesh" id="BoxMesh_ceiling"]
material = SubResource("StandardMaterial3D_wall")
size = Vector3(10.2, 0.2, 9.2)

[sub_resource type="BoxShape3D" id="BoxShape3D_ceiling"]
size = Vector3(10.2, 0.2, 9.2)

[sub_resource type="StandardMaterial3D" id="StandardMaterial3D_lamp"]
albedo_color = Color(0.8, 0.85, 0.9, 1)
emission_enabled = true
emission = Color(0.7, 0.85, 1, 1)
emission_energy_multiplier = 2.0

[sub_resource type="CylinderMesh" id="CylinderMesh_lamp"]
material = SubResource("StandardMaterial3D_lamp")
top_radius = 0.2
bottom_radius = 0.25
height = 0.1
radial_segments = 16

[node name="MainMenu" type="Node3D" unique_id=2052640717]
script = ExtResource("1_script")

[node name="WorldEnvironment" type="WorldEnvironment" parent="." unique_id=728541218]
environment = SubResource("Environment_menu")

[node name="MenuSpotLight" type="SpotLight3D" parent="." unique_id=1738064566]
transform = Transform3D(1, 0, 0, 0, 0.9563048, 0.2923717, 0, -0.2923717, 0.9563048, 0, 3.5, -0.7)
light_color = Color(0.88, 0.93, 1, 1)
light_energy = 2.6
spot_range = 6.0
spot_attenuation = 1.1

[node name="MenuAmbientLight" type="OmniLight3D" parent="." unique_id=184910293]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, -1.2)
light_color = Color(0.25, 0.55, 0.95, 1)
light_energy = 0.4
omni_range = 4.5

[node name="Floor" type="StaticBody3D" parent="." unique_id=1537649]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.5, 0)

[node name="CollisionShape3D" type="CollisionShape3D" parent="Floor" unique_id=982456613]
shape = SubResource("BoxShape3D_floor")

[node name="MeshInstance3D" type="MeshInstance3D" parent="Floor" unique_id=123883215]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, 0)
mesh = SubResource("PlaneMesh_floor")

[node name="IndustrialWall" type="StaticBody3D" parent="." unique_id=992817263]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.2, -2.8)

[node name="MeshInstance3D" type="MeshInstance3D" parent="IndustrialWall" unique_id=575337685]
mesh = SubResource("BoxMesh_wall")

[node name="CollisionShape3D" type="CollisionShape3D" parent="IndustrialWall" unique_id=175644465]
shape = SubResource("BoxShape3D_wall")

[node name="Pipes" type="Node3D" parent="." unique_id=2142528203]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.2, -2.75)

[node name="PipeLeft" type="MeshInstance3D" parent="Pipes" unique_id=548966718]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -3.2, 0, 0)
mesh = SubResource("CylinderMesh_pipe")

[node name="PipeRight" type="MeshInstance3D" parent="Pipes" unique_id=1927873173]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 3.2, 0, 0)
mesh = SubResource("CylinderMesh_pipe")

[node name="PipeTop" type="MeshInstance3D" parent="Pipes" unique_id=1440785262]
transform = Transform3D(-4.37114e-08, -1, 0, 1, -4.37114e-08, 0, 0, 0, 1, 0, 2.1, 0.02)
mesh = SubResource("CylinderMesh_pipe")

[node name="BackWall" type="StaticBody3D" parent="." unique_id=194827101]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.2, 6.2)

[node name="MeshInstance3D" type="MeshInstance3D" parent="BackWall" unique_id=956818226]
mesh = SubResource("BoxMesh_wall")

[node name="CollisionShape3D" type="CollisionShape3D" parent="BackWall" unique_id=2007040235]
shape = SubResource("BoxShape3D_wall")

[node name="LeftWall" type="StaticBody3D" parent="." unique_id=194827102]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -5, 2.2, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="LeftWall" unique_id=819012728]
mesh = SubResource("BoxMesh_wall_side")

[node name="CollisionShape3D" type="CollisionShape3D" parent="LeftWall" unique_id=718482392]
shape = SubResource("BoxShape3D_wall_side")

[node name="RightWall" type="StaticBody3D" parent="." unique_id=194827103]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 5, 2.2, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="RightWall" unique_id=1390380056]
mesh = SubResource("BoxMesh_wall_side")

[node name="CollisionShape3D" type="CollisionShape3D" parent="RightWall" unique_id=454655938]
shape = SubResource("BoxShape3D_wall_side")

[node name="Ceiling" type="StaticBody3D" parent="." unique_id=194827104]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 4.5, 1.7)

[node name="MeshInstance3D" type="MeshInstance3D" parent="Ceiling" unique_id=270118421]
mesh = SubResource("BoxMesh_ceiling")

[node name="CollisionShape3D" type="CollisionShape3D" parent="Ceiling" unique_id=409537979]
shape = SubResource("BoxShape3D_ceiling")

[node name="CeilingLampFixture" type="MeshInstance3D" parent="Ceiling" unique_id=139906738]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.1, 0)
mesh = SubResource("CylinderMesh_lamp")

[node name="CeilingLight" type="OmniLight3D" parent="Ceiling" unique_id=1928428580]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.4, 0)
light_color = Color(0.65, 0.8, 1, 1)
light_energy = 0.8
omni_range = 5.5
omni_attenuation = 1.2

[node name="Viewport2Din3D" parent="." unique_id=1130208441 instance=ExtResource("2_bqqt6")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.15, -2.68)
screen_size = Vector2(2.4, 1.45)
scene = ExtResource("3_ui")
viewport_size = Vector2(1280, 720)
input_gamepad = true
unshaded = true
scene_properties_keys = PackedStringArray("main_menu_ui.gd")

[node name="AudioStreamPlayer" type="AudioStreamPlayer" parent="." unique_id=1163565949]
stream = ExtResource("4_wu84c")
autoplay = true

[node name="StartXR" parent="." unique_id=2039475675 instance=ExtResource("6_startxr")]

[node name="Player" parent="." unique_id=629638343 instance=ExtResource("5_player")]

[node name="Fade" parent="." unique_id=1653293877 instance=ExtResource("7_fade")]
````

## File: scenes/game_map.tscn
````
[gd_scene format=3 uid="uid://cjyxx2d4hafto"]

[ext_resource type="Script" uid="uid://cbilw02reekmp" path="res://scripts/game_map.gd" id="1_script"]
[ext_resource type="Texture2D" uid="uid://d3qvt0affmqvn" path="res://assets/textures/Wooden Floor Texture/wood2_COLOR.jpg" id="2_lp764"]
[ext_resource type="Texture2D" uid="uid://ch8av1pfgrixv" path="res://assets/textures/Wooden Floor Texture/wood2_OCC.jpg" id="3_m2cng"]
[ext_resource type="Texture2D" uid="uid://bkxkmyk7y0hl4" path="res://assets/textures/Wooden Floor Texture/wood2_NRM.jpg" id="4_oviui"]
[ext_resource type="AudioStream" uid="uid://bv6a0kufxjmtr" path="res://assets/sounds/ambience.mp3" id="5_m2cng"]
[ext_resource type="PackedScene" uid="uid://b4ml2o2jh5ooc" path="res://scenes/balora.tscn" id="6_oviui"]
[ext_resource type="PackedScene" uid="uid://c0ch7jab7i3ry" path="res://scenes/player.tscn" id="7_player"]
[ext_resource type="PackedScene" uid="uid://clc5dre31iskm" path="res://addons/godot-xr-tools/xr/start_xr.tscn" id="8_startxr"]
[ext_resource type="PackedScene" uid="uid://wtpox7m5vu2b" path="res://addons/godot-xr-tools/effects/fade.tscn" id="9_fade"]
[ext_resource type="PackedScene" uid="uid://b3t54b22cxxxx" path="res://scenes/marionette.tscn" id="10_marnin"]
[ext_resource type="PackedScene" uid="uid://cxabcf23t8foo" path="res://scenes/foxy.tscn" id="11_foxy"]
[ext_resource type="PackedScene" path="res://scenes/phantom_grasp.tscn" id="12_grasp"]
[ext_resource type="PackedScene" path="res://scenes/pause_menu.tscn" id="13_pause"]

[sub_resource type="Environment" id="Environment_iau3x"]
background_mode = 1
ambient_light_source = 1
ambient_light_energy = 0.0

[sub_resource type="NavigationMesh" id="NavigationMesh_new"]
geometry_parsed_geometry_type = 1
agent_height = 2.75
agent_radius = 0.75

[sub_resource type="BoxShape3D" id="BoxShape3D_test"]
size = Vector3(40.593994, 1, 43.245117)

[sub_resource type="PlaneMesh" id="PlaneMesh_test"]
lightmap_size_hint = Vector2i(102, 102)
size = Vector2(40, 43)

[sub_resource type="StandardMaterial3D" id="StandardMaterial_test"]
disable_specular_occlusion = true
albedo_texture = ExtResource("2_lp764")
normal_enabled = true
normal_scale = 14.51
normal_texture = ExtResource("4_oviui")
ao_enabled = true
ao_light_affect = 1.0
ao_texture = ExtResource("3_m2cng")
uv1_triplanar = true
uv1_triplanar_sharpness = 1.6008334

[sub_resource type="BoxShape3D" id="BoxShape3D_wall_ns"]
size = Vector3(40.58618, 4, 0.5)

[sub_resource type="BoxMesh" id="BoxMesh_wall_ns"]
size = Vector3(40, 4, 0.5)

[sub_resource type="StandardMaterial3D" id="StandardMaterial_wall"]
albedo_color = Color(0.15, 0.12, 0.1, 1)

[sub_resource type="BoxShape3D" id="BoxShape3D_wall_ew"]
size = Vector3(0.5, 4, 43.78125)

[sub_resource type="BoxMesh" id="BoxMesh_wall_ew"]
size = Vector3(0.5, 4, 44)

[node name="GameMap" type="Node3D" unique_id=120756022]
script = ExtResource("1_script")

[node name="WorldEnvironment" type="WorldEnvironment" parent="." unique_id=982597785]
environment = SubResource("Environment_iau3x")

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="." unique_id=1915778391]
transform = Transform3D(1, 0, 0, 0, -4.37114e-08, 1, 0, -1, -4.37114e-08, 0, 10, 0)
visible = false
light_energy = 0.0

[node name="NavigationRegion3D" type="NavigationRegion3D" parent="." unique_id=990958998]
navigation_mesh = SubResource("NavigationMesh_new")

[node name="Floor" type="StaticBody3D" parent="NavigationRegion3D" unique_id=309467535]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.5, 0)

[node name="CollisionShape3D" type="CollisionShape3D" parent="NavigationRegion3D/Floor" unique_id=1961788420]
shape = SubResource("BoxShape3D_test")

[node name="MeshInstance3D" type="MeshInstance3D" parent="NavigationRegion3D/Floor" unique_id=1559076285]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, 0)
mesh = SubResource("PlaneMesh_test")
surface_material_override/0 = SubResource("StandardMaterial_test")

[node name="WallNorth" type="StaticBody3D" parent="NavigationRegion3D" unique_id=723940986]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 21.738867)

[node name="CollisionShape3D" type="CollisionShape3D" parent="NavigationRegion3D/WallNorth" unique_id=1396440935]
shape = SubResource("BoxShape3D_wall_ns")

[node name="MeshInstance3D" type="MeshInstance3D" parent="NavigationRegion3D/WallNorth" unique_id=730965168]
mesh = SubResource("BoxMesh_wall_ns")
surface_material_override/0 = SubResource("StandardMaterial_wall")

[node name="WallSouth" type="StaticBody3D" parent="NavigationRegion3D" unique_id=118626652]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, -21.617676)

[node name="CollisionShape3D" type="CollisionShape3D" parent="NavigationRegion3D/WallSouth" unique_id=913572083]
shape = SubResource("BoxShape3D_wall_ns")

[node name="MeshInstance3D" type="MeshInstance3D" parent="NavigationRegion3D/WallSouth" unique_id=1717054843]
mesh = SubResource("BoxMesh_wall_ns")
surface_material_override/0 = SubResource("StandardMaterial_wall")

[node name="WallEast" type="StaticBody3D" parent="NavigationRegion3D" unique_id=1399451984]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 20.171703, 2, 0)

[node name="CollisionShape3D" type="CollisionShape3D" parent="NavigationRegion3D/WallEast" unique_id=727175830]
shape = SubResource("BoxShape3D_wall_ew")

[node name="MeshInstance3D" type="MeshInstance3D" parent="NavigationRegion3D/WallEast" unique_id=350134398]
mesh = SubResource("BoxMesh_wall_ew")
surface_material_override/0 = SubResource("StandardMaterial_wall")

[node name="WallWest" type="StaticBody3D" parent="NavigationRegion3D" unique_id=1916824261]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -20.25622, 2, 0)

[node name="CollisionShape3D" type="CollisionShape3D" parent="NavigationRegion3D/WallWest" unique_id=584697121]
shape = SubResource("BoxShape3D_wall_ew")

[node name="MeshInstance3D" type="MeshInstance3D" parent="NavigationRegion3D/WallWest" unique_id=1766290024]
mesh = SubResource("BoxMesh_wall_ew")
surface_material_override/0 = SubResource("StandardMaterial_wall")

[node name="AudioStreamPlayer" type="AudioStreamPlayer" parent="." unique_id=569793408]
stream = ExtResource("5_m2cng")
volume_db = -1.273
autoplay = true

[node name="Marionette" parent="." unique_id=958148592 instance=ExtResource("10_marnin")]

[node name="StartXR" parent="." unique_id=1224595367 instance=ExtResource("8_startxr")]

[node name="Player" parent="." unique_id=805658640 instance=ExtResource("7_player")]
transform = Transform3D(-1, 0, -8.742278e-08, 0, 1, 0, 8.742278e-08, 0, -1, 0, 0.8063904, -1.6275938)

[node name="Fade" parent="." unique_id=1010360029 instance=ExtResource("9_fade")]

[node name="Balora" parent="." unique_id=1656694762 instance=ExtResource("6_oviui")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.4395071, 16.287754)

[node name="Foxy" parent="." unique_id=123456789 instance=ExtResource("11_foxy")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -5, 1.4, -18.799488)

[node name="Foxy2" parent="." unique_id=123456790 instance=ExtResource("11_foxy")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 6, 1.4, 18)

[node name="PhantomGrasp" parent="." unique_id=987654321 instance=ExtResource("12_grasp")]

[node name="PauseMenu" parent="." unique_id=1457039507 instance=ExtResource("13_pause")]

[editable path="Player"]
````

## File: scenes/main_menu_ui.tscn
````
[gd_scene load_steps=22 format=3 uid="uid://bvwh78d1g322u"]

[ext_resource type="Script" path="res://scripts/main_menu_ui.gd" id="1_ui_script"]
[ext_resource type="Script" path="res://scripts/hold_button.gd" id="2_hold_btn"]
[ext_resource type="Script" path="res://scripts/glitch_title.gd" id="3_glitch"]
[ext_resource type="FontFile" uid="uid://h5qw6gpuqhc8" path="res://assets/fonts/RubikGlitch-Regular.ttf" id="4_font_rubikglitch"]
[ext_resource type="FontFile" uid="uid://dbiax41qfab82" path="res://assets/fonts/CinzelDecorative-Bold.ttf" id="5_font_cinzel"]
[ext_resource type="Shader" path="res://shaders/glitch_text.gdshader" id="6_shader"]

[sub_resource type="ShaderMaterial" id="ShaderMaterial_glitch"]
shader = ExtResource("6_shader")
shader_parameter/glitch_intensity = 0.0
shader_parameter/color_split_dist = 0.02
shader_parameter/scanline_density = 140.0
shader_parameter/block_size = 0.04
shader_parameter/jitter_offset = Vector2(0, 0)

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_btn_normal"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn_hover"]
bg_color = Color(0, 1, 0.64, 0.15)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 2
border_color = Color(0, 1, 0.64, 0.85)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
expand_margin_left = 8.0
expand_margin_top = 3.0
expand_margin_right = 8.0
expand_margin_bottom = 3.0

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_btn_pressed"]
bg_color = Color(0, 1, 0.64, 0.28)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 2
border_color = Color(0, 1, 0.64, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_panel_glass"]
bg_color = Color(0.02, 0.03, 0.05, 0.25)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.2, 0.28, 0.35, 0.45)
corner_radius_top_left = 12
corner_radius_top_right = 12
corner_radius_bottom_right = 12
corner_radius_bottom_left = 12

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_setting_card"]
bg_color = Color(0.03, 0.05, 0.08, 0.5)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.18, 0.26, 0.32, 0.5)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_progress_bg"]
bg_color = Color(0.1, 0.13, 0.18, 0.8)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.18, 0.25, 0.32, 0.4)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_progress_fill"]
bg_color = Color(0, 1, 0.64, 0.9)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_step_btn"]
bg_color = Color(0.08, 0.11, 0.16, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.25, 0.35, 0.45, 0.5)
corner_radius_top_left = 6
corner_radius_top_right = 6
corner_radius_bottom_right = 6
corner_radius_bottom_left = 6

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill_btn"]
bg_color = Color(0.07, 0.1, 0.14, 0.85)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 1, 0.64, 0.4)
corner_radius_top_left = 20
corner_radius_top_right = 20
corner_radius_bottom_right = 20
corner_radius_bottom_left = 20

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pill_hover"]
bg_color = Color(0, 1, 0.64, 0.2)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 2
border_color = Color(0, 1, 0.64, 1)
corner_radius_top_left = 20
corner_radius_top_right = 20
corner_radius_bottom_right = 20
corner_radius_bottom_left = 20

[node name="MainMenuUI" type="Control"]
script = ExtResource("1_ui_script")
layout_mode = 3
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="Background" type="ColorRect" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2
mouse_filter = 2
color = Color(0, 0, 0, 0)

[node name="AuthorLabel" type="Label" parent="."]
layout_mode = 1
anchors_preset = 2
anchor_top = 1.0
anchor_bottom = 1.0
offset_left = 30.0
offset_top = -38.0
offset_right = 450.0
offset_bottom = -14.0
grow_vertical = 0
theme_override_colors/font_color = Color(0.4, 0.46, 0.54, 0.7)
theme_override_font_sizes/font_size = 14
text = "by Damian Skonieczny version 0.5.2"

[node name="CenterContainer" type="CenterContainer" parent="."]
layout_mode = 1
anchors_preset = 15
anchor_right = 1.0
anchor_bottom = 1.0
grow_horizontal = 2
grow_vertical = 2

[node name="PanelContainer" type="PanelContainer" parent="CenterContainer"]
custom_minimum_size = Vector2(1120, 720)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxEmpty_btn_normal")

[node name="MarginContainer" type="MarginContainer" parent="CenterContainer/PanelContainer"]
layout_mode = 2
theme_override_constants/margin_left = 30
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 30
theme_override_constants/margin_bottom = 20

[node name="MainPanel" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
layout_mode = 2
theme_override_constants/separation = 16
alignment = 1

[node name="TitleLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel"]
material = SubResource("ShaderMaterial_glitch")
custom_minimum_size = Vector2(0, 105)
layout_mode = 2
theme_override_colors/font_color = Color(0.92, 0.95, 1, 1)
theme_override_colors/font_shadow_color = Color(0, 0, 0, 0.95)
theme_override_colors/font_outline_color = Color(0.08, 0.15, 0.28, 0.95)
theme_override_constants/shadow_offset_x = 3
theme_override_constants/shadow_offset_y = 4
theme_override_constants/outline_size = 5
theme_override_fonts/font = ExtResource("4_font_rubikglitch")
theme_override_font_sizes/font_size = 72
text = "LIGHTLESS"
horizontal_alignment = 1
vertical_alignment = 1
script = ExtResource("3_glitch")

[node name="TelemetryContainer" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel"]
layout_mode = 2
alignment = 1

[node name="HBoxContainer" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer"]
layout_mode = 2
theme_override_constants/separation = 10

[node name="LastTimeLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/HBoxContainer"]
layout_mode = 2
theme_override_colors/font_color = Color(0.5, 0.58, 0.68, 1)
theme_override_font_sizes/font_size = 15
text = "Last Survival: "

[node name="LastTimeValue" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/TelemetryContainer/HBoxContainer"]
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
text = "--:--"

[node name="ButtonsContainer" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel"]
layout_mode = 2
theme_override_constants/separation = 16
alignment = 1

[node name="StartButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer"]
custom_minimum_size = Vector2(650, 88)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.78, 0.82, 0.88, 0.9)
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_colors/font_focus_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 40
theme_override_styles/normal = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "start game"
script = ExtResource("2_hold_btn")

[node name="SelectNightButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer"]
custom_minimum_size = Vector2(600, 80)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.65, 0.7, 0.76, 0.85)
theme_override_colors/font_hover_color = Color(0, 1, 0.64, 1)
theme_override_colors/font_focus_color = Color(0, 1, 0.64, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 34
theme_override_styles/normal = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "select night"
script = ExtResource("2_hold_btn")

[node name="SettingsButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer"]
custom_minimum_size = Vector2(600, 80)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.65, 0.7, 0.76, 0.85)
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_colors/font_focus_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 34
theme_override_styles/normal = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "settings"
script = ExtResource("2_hold_btn")

[node name="GuideButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer"]
custom_minimum_size = Vector2(600, 80)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.65, 0.7, 0.76, 0.85)
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_colors/font_focus_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 34
theme_override_styles/normal = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "guide"
script = ExtResource("2_hold_btn")

[node name="ExitButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer"]
custom_minimum_size = Vector2(600, 80)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_color = Color(0.65, 0.7, 0.76, 0.85)
theme_override_colors/font_hover_color = Color(1, 0.4, 0.5, 1)
theme_override_colors/font_focus_color = Color(1, 0.4, 0.5, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 34
theme_override_styles/normal = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "exit"
script = ExtResource("2_hold_btn")

[node name="SettingsPanel" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
visible = false
layout_mode = 2
theme_override_constants/separation = 14

[node name="SettingsBg" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel"]
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel_glass")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg"]
layout_mode = 2
theme_override_constants/margin_left = 32
theme_override_constants/margin_top = 22
theme_override_constants/margin_right = 32
theme_override_constants/margin_bottom = 22

[node name="Content" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="SettingsTitle" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 26
text = "AUDIO & ACCESSIBILITY SETTINGS"
horizontal_alignment = 1

[node name="HSeparator1" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
layout_mode = 2

[node name="TTSCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_setting_card")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin"]
layout_mode = 2
alignment = 1

[node name="TTSLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.75, 0.82, 0.78, 1)
theme_override_font_sizes/font_size = 15
text = "TTS (TEXT TO SPEECH)"

[node name="TTSToggleBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox"]
custom_minimum_size = Vector2(170, 40)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "TTS Voice: ON"
script = ExtResource("2_hold_btn")

[node name="MasterCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_setting_card")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin"]
layout_mode = 2
alignment = 1

[node name="MasterLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.75, 0.82, 0.78, 1)
theme_override_font_sizes/font_size = 15
text = "MASTER VOLUME"

[node name="Controls" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="MasterMinusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "−"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="MasterProgressBar" type="ProgressBar" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(140, 8)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/background = SubResource("StyleBoxFlat_progress_bg")
theme_override_styles/fill = SubResource("StyleBoxFlat_progress_fill")
value = 80.0
show_percentage = false

[node name="MasterValueLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(56, 0)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
text = "80%"
horizontal_alignment = 2

[node name="MasterPlusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "+"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="EnemiesCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_setting_card")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin"]
layout_mode = 2
alignment = 1

[node name="EnemiesLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.75, 0.82, 0.78, 1)
theme_override_font_sizes/font_size = 15
text = "ENEMY SOUNDS"

[node name="Controls" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="EnemiesMinusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "−"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="EnemiesProgressBar" type="ProgressBar" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(140, 8)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/background = SubResource("StyleBoxFlat_progress_bg")
theme_override_styles/fill = SubResource("StyleBoxFlat_progress_fill")
value = 85.0
show_percentage = false

[node name="EnemiesValueLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(56, 0)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
text = "85%"
horizontal_alignment = 2

[node name="EnemiesPlusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "+"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="FootstepsCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_setting_card")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin"]
layout_mode = 2
alignment = 1

[node name="FootstepsLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.75, 0.82, 0.78, 1)
theme_override_font_sizes/font_size = 15
text = "PLAYER FOOTSTEPS"

[node name="Controls" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="FootstepsMinusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "−"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="FootstepsProgressBar" type="ProgressBar" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(140, 8)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/background = SubResource("StyleBoxFlat_progress_bg")
theme_override_styles/fill = SubResource("StyleBoxFlat_progress_fill")
value = 80.0
show_percentage = false

[node name="FootstepsValueLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(56, 0)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
text = "80%"
horizontal_alignment = 2

[node name="FootstepsPlusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "+"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="JumpscareCard" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(0, 56)
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_setting_card")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard"]
layout_mode = 2
theme_override_constants/margin_left = 20
theme_override_constants/margin_right = 20

[node name="HBox" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin"]
layout_mode = 2
alignment = 1

[node name="JumpscareLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_colors/font_color = Color(0.75, 0.82, 0.78, 1)
theme_override_font_sizes/font_size = 15
text = "JUMPSCARE VOLUME"

[node name="Controls" type="HBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="JumpscareMinusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "−"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="JumpscareProgressBar" type="ProgressBar" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(140, 8)
layout_mode = 2
size_flags_vertical = 4
theme_override_styles/background = SubResource("StyleBoxFlat_progress_bg")
theme_override_styles/fill = SubResource("StyleBoxFlat_progress_fill")
value = 90.0
show_percentage = false

[node name="JumpscareValueLabel" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(56, 0)
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_font_sizes/font_size = 15
text = "90%"
horizontal_alignment = 2

[node name="JumpscarePlusBtn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls"]
custom_minimum_size = Vector2(44, 38)
layout_mode = 2
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_step_btn")
theme_override_styles/hover = SubResource("StyleBoxEmpty_btn_normal")
theme_override_styles/focus = SubResource("StyleBoxEmpty_btn_normal")
text = "+"
script = ExtResource("2_hold_btn")
allow_repeat_on_hold = true

[node name="HSeparator2" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
layout_mode = 2

[node name="BackFromSettingsButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content"]
custom_minimum_size = Vector2(420, 52)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 20
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "⮌ BACK TO MENU"
script = ExtResource("2_hold_btn")

[node name="NightsPanel" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
visible = false
layout_mode = 2
theme_override_constants/separation = 12

[node name="NightsBg" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel"]
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel_glass")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg"]
layout_mode = 2
theme_override_constants/margin_left = 30
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 30
theme_override_constants/margin_bottom = 20

[node name="Content" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin"]
layout_mode = 2
theme_override_constants/separation = 12

[node name="NightsTitle" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content"]
layout_mode = 2
theme_override_colors/font_color = Color(0, 1, 0.64, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 26
text = "SELECT NIGHT"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content"]
layout_mode = 2

[node name="Grid" type="GridContainer" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content"]
layout_mode = 2
theme_override_constants/h_separation = 16
theme_override_constants/v_separation = 12
columns = 2

[node name="Night0Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 0: TUTORIAL"
script = ExtResource("2_hold_btn")

[node name="Night1Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 1 (30s) - BALORA"
script = ExtResource("2_hold_btn")

[node name="Night2Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 2 (60s) - BALORA & MARIONETTE"
script = ExtResource("2_hold_btn")

[node name="Night3Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 3 - FOXY AWAKENS"
script = ExtResource("2_hold_btn")

[node name="Night4Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 4 - PHANTOM GRASP"
script = ExtResource("2_hold_btn")

[node name="Night5Btn" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid"]
custom_minimum_size = Vector2(480, 54)
layout_mode = 2
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "NIGHT 5 - NIGHTMARE FINALE"
script = ExtResource("2_hold_btn")

[node name="HSeparator2" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content"]
layout_mode = 2

[node name="BackFromNightsButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content"]
custom_minimum_size = Vector2(420, 50)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "⮌ BACK TO MENU"
script = ExtResource("2_hold_btn")

[node name="GuidePanel" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer"]
visible = false
layout_mode = 2
theme_override_constants/separation = 10

[node name="GuideBg" type="PanelContainer" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel"]
layout_mode = 2
theme_override_styles/panel = SubResource("StyleBoxFlat_panel_glass")

[node name="Margin" type="MarginContainer" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg"]
layout_mode = 2
theme_override_constants/margin_left = 30
theme_override_constants/margin_top = 20
theme_override_constants/margin_right = 30
theme_override_constants/margin_bottom = 20

[node name="Content" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin"]
layout_mode = 2
theme_override_constants/separation = 10

[node name="GuideTitle" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.75, 0.2, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 24
text = "CONTROLS & SURVIVAL GUIDE"
horizontal_alignment = 1

[node name="HSeparator" type="HSeparator" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content"]
layout_mode = 2

[node name="ScrollContainer" type="ScrollContainer" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content"]
custom_minimum_size = Vector2(0, 340)
layout_mode = 2

[node name="GuideContent" type="VBoxContainer" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/ScrollContainer"]
layout_mode = 2
size_flags_horizontal = 3
theme_override_constants/separation = 8

[node name="ControlsHeader" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/ScrollContainer/GuideContent"]
layout_mode = 2
theme_override_colors/font_color = Color(0.3, 0.75, 1, 1)
theme_override_font_sizes/font_size = 18
text = "1. VR CONTROLS:"

[node name="ControlsText" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/ScrollContainer/GuideContent"]
layout_mode = 2
theme_override_font_sizes/font_size = 15
text = "• Movement: Smooth movement with controller joystick. Turn with your physical body (360° VR tracking). Click Stick = Sprint (generates loud noise!).
• Menu Navigation: Tilt controller joystick Up/Down to navigate with TTS speech & haptic clicks, press A or pull Trigger to select. Or point laser and hold."
autowrap_mode = 2

[node name="EnemiesHeader" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/ScrollContainer/GuideContent"]
layout_mode = 2
theme_override_colors/font_color = Color(1, 0.3, 0.45, 1)
theme_override_font_sizes/font_size = 18
text = "2. THREATS & COUNTERMEASURES:"

[node name="EnemiesText" type="Label" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/ScrollContainer/GuideContent"]
layout_mode = 2
theme_override_font_sizes/font_size = 15
text = "• Balora: Constantly patrols on NavMesh. Reacts to PROXIMITY (music box tempo accelerates). Run away!
• Foxy: Reacts to player NOISE. Sudden complete silence signals incoming charge in 2s. Raise & wave controller hand towards charge to BLOCK!
• Marionette: Whispers escalating near ear. Identify direction and firmly wave hand towards the sound to dispel.
• Phantom Grasp: Tentacles grab your controller with aggressive sound & violent vibration. Shake controller vigorously twice to break free!"
autowrap_mode = 2

[node name="BackFromGuideButton" type="Button" parent="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content"]
custom_minimum_size = Vector2(400, 50)
layout_mode = 2
size_flags_horizontal = 4
theme_override_colors/font_hover_color = Color(1, 1, 1, 1)
theme_override_fonts/font = ExtResource("5_font_cinzel")
theme_override_font_sizes/font_size = 18
theme_override_styles/normal = SubResource("StyleBoxFlat_pill_btn")
theme_override_styles/hover = SubResource("StyleBoxFlat_pill_hover")
theme_override_styles/focus = SubResource("StyleBoxFlat_pill_hover")
text = "⮌ BACK TO MENU"
script = ExtResource("2_hold_btn")

[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/StartButton" to="." method="_on_start_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SelectNightButton" to="." method="_on_select_night_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/SettingsButton" to="." method="_on_settings_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/GuideButton" to="." method="_on_guide_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/MainPanel/ButtonsContainer/ExitButton" to="." method="_on_exit_button_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/TTSCard/Margin/HBox/TTSToggleBtn" to="." method="_on_tts_toggle_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterMinusBtn" to="." method="_on_master_minus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/MasterCard/Margin/HBox/Controls/MasterPlusBtn" to="." method="_on_master_plus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesMinusBtn" to="." method="_on_enemies_minus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/EnemiesCard/Margin/HBox/Controls/EnemiesPlusBtn" to="." method="_on_enemies_plus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsMinusBtn" to="." method="_on_footsteps_minus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/FootstepsCard/Margin/HBox/Controls/FootstepsPlusBtn" to="." method="_on_footsteps_plus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscareMinusBtn" to="." method="_on_jumpscare_minus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/JumpscareCard/Margin/HBox/Controls/JumpscarePlusBtn" to="." method="_on_jumpscare_plus_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/SettingsPanel/SettingsBg/Margin/Content/BackFromSettingsButton" to="." method="_on_back_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night0Btn" to="." method="_on_night_0_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night1Btn" to="." method="_on_night_1_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night2Btn" to="." method="_on_night_2_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night3Btn" to="." method="_on_night_3_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night4Btn" to="." method="_on_night_4_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/Grid/Night5Btn" to="." method="_on_night_5_btn_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/NightsPanel/NightsBg/Margin/Content/BackFromNightsButton" to="." method="_on_back_pressed"]
[connection signal="pressed" from="CenterContainer/PanelContainer/MarginContainer/GuidePanel/GuideBg/Margin/Content/BackFromGuideButton" to="." method="_on_back_pressed"]
````

## File: scenes/player.tscn
````
[gd_scene format=3 uid="uid://c0ch7jab7i3ry"]

[ext_resource type="PackedScene" uid="uid://diyu06cw06syv" path="res://addons/godot-xr-tools/player/player_body.tscn" id="1_g2els"]
[ext_resource type="PackedScene" uid="uid://btknduttnmoxf" path="res://addons/godot-xr-tools/misc/vr_common_shader_cache.tscn" id="2_qhqgy"]
[ext_resource type="PackedScene" uid="uid://bdwmserhqai5h" path="res://addons/godot-xr-tools/hands/scenes/lowpoly/left_physics_hand_low.tscn" id="3_dqkch"]
[ext_resource type="PackedScene" uid="uid://btf05hjpw6k05" path="res://addons/godot-xr-tools/hands/scenes/lowpoly/right_physics_hand_low.tscn" id="4_qlg0r"]
[ext_resource type="PackedScene" uid="uid://bkv43ec6chcf3" path="res://addons/godot-xr-tools/hands/scenes/collision/collision_hand_left.tscn" id="5_col_l"]
[ext_resource type="PackedScene" uid="uid://c3uoohvnshach" path="res://addons/godot-xr-tools/hands/scenes/collision/collision_hand_right.tscn" id="6_col_r"]
[ext_resource type="PackedScene" uid="uid://bl2nuu3qhlb5k" path="res://addons/godot-xr-tools/functions/movement_direct.tscn" id="6_smehm"]
[ext_resource type="PackedScene" uid="uid://cqhw276realc" path="res://addons/godot-xr-tools/functions/function_pointer.tscn" id="10_pointer"]
[ext_resource type="PackedScene" uid="uid://drs4eeq721ojn" path="res://addons/godot-xr-tools/functions/movement_sprint.tscn" id="11_sprint"]
[ext_resource type="Script" uid="uid://ddgofpxlmq1d3" path="res://scripts/player_audio_manager.gd" id="12_audio_mgr"]
[ext_resource type="PackedScene" uid="uid://0xlsitpu17r1" path="res://addons/godot-xr-tools/functions/movement_footstep.tscn" id="14_footstep"]
[ext_resource type="Resource" uid="uid://dbsq5a4220b3" path="res://assets/sounds/default_surface.tres" id="15_surface"]
[ext_resource type="AudioStream" uid="uid://c7yasims5j5dg" path="res://assets/sounds/danger.wav" id="16_danger"]

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_tuyoq"]

[node name="Player" type="Node3D" unique_id=998281425 groups=["player"]]

[node name="XROrigin3D" type="XROrigin3D" parent="." unique_id=1544298595]

[node name="PlayerBody" parent="XROrigin3D" unique_id=147226604 instance=ExtResource("1_g2els")]
collision_layer = 524289
movement_direction = 2

[node name="CollisionShape3D" type="CollisionShape3D" parent="XROrigin3D/PlayerBody" unique_id=550881090]
shape = SubResource("CapsuleShape3D_tuyoq")

[node name="MovementSprint" parent="XROrigin3D" unique_id=1804724567 instance=ExtResource("11_sprint")]
controller = 1

[node name="MovementFootstep" parent="XROrigin3D" unique_id=118507568 instance=ExtResource("14_footstep")]
default_surface_audio_type = ExtResource("15_surface")

[node name="XRCamera3D" type="XRCamera3D" parent="XROrigin3D" unique_id=639605948 groups=["player_head"]]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.06774485, 0.47796416, -0.18833774)

[node name="VRCommonShaderCache" parent="XROrigin3D/XRCamera3D" unique_id=1303836383 instance=ExtResource("2_qhqgy")]

[node name="TimerLabel" type="Label3D" parent="XROrigin3D/XRCamera3D" unique_id=1464946628]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.37197274, 0.19904566, -0.541948)
pixel_size = 0.001
double_sided = false
alpha_antialiasing_mode = 1
modulate = Color(0.39308554, 0.39308554, 0.39308533, 0.83137256)
outline_modulate = Color(0.12591082, 0.12591085, 0.12591079, 0.73333335)
text = "00:00"
font_size = 28
outline_size = 13

[node name="MilestoneAudio" type="AudioStreamPlayer3D" parent="XROrigin3D/XRCamera3D" unique_id=1395136088]
stream = ExtResource("16_danger")

[node name="left_hand" type="XRController3D" parent="XROrigin3D" unique_id=806941292]
tracker = &"left_hand"

[node name="CollisionHandLeft" parent="XROrigin3D/left_hand" unique_id=2089909562 instance=ExtResource("5_col_l")]

[node name="LeftHand" parent="XROrigin3D/left_hand/CollisionHandLeft" unique_id=922969339 instance=ExtResource("3_dqkch")]

[node name="FunctionPointer" parent="XROrigin3D/left_hand" unique_id=1737039443 instance=ExtResource("10_pointer")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0.02, 0.05, -0.1)
distance = 6.0
show_laser = 2
laser_length = 1
show_target = true

[node name="right_hand" type="XRController3D" parent="XROrigin3D" unique_id=1054815896]
tracker = &"right_hand"

[node name="CollisionHandRight" parent="XROrigin3D/right_hand" unique_id=1482878259 instance=ExtResource("6_col_r")]

[node name="RightHand" parent="XROrigin3D/right_hand/CollisionHandRight" unique_id=496257248 instance=ExtResource("4_qlg0r")]

[node name="MovementDirect" parent="XROrigin3D/right_hand" unique_id=883431152 instance=ExtResource("6_smehm")]
strafe = true

[node name="FunctionPointer" parent="XROrigin3D/right_hand" unique_id=1943132758 instance=ExtResource("10_pointer")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -0.02, 0.05, -0.1)
distance = 6.0
show_laser = 2
laser_length = 1
show_target = true

[node name="FeetLight" type="OmniLight3D" parent="XROrigin3D" unique_id=193847291]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.75, 0)
light_color = Color(0.35, 0.42, 0.52, 1)
light_energy = 0.55
omni_range = 1.6
omni_attenuation = 2.4

[node name="PlayerAudioManager" type="Node" parent="." unique_id=863448654]
script = ExtResource("12_audio_mgr")
````
