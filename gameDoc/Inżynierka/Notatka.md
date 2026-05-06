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

