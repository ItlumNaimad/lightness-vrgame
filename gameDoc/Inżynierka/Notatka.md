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

### Zadania do wykonania

| Priorytet | Zadanie                                                                                       | Status       |
| --------- | --------------------------------------------------------------------------------------------- | ------------ |
| 🟡 WYSOKI | Ekran Game Over (dedykowana scena / UI)                                                       | Do zrobienia |
| 🟡 WYSOKI | System TTS / lektora w menu (Accessibility) + menu wybierane kontrolerem                      | Do zrobienia |
| 🟡 WYSOKI | Zaawansowane dźwięki kroków gracza (zależne od powierzchni podłogi + triggery dla Foxy)       | Zrobione     |
| 🟡 WYSOKI | Dźwiękowa informacja zwrotna przy obracaniu się joystickiem (zapobieganie utracie orientacji) | Zrobione     |
| 🔵 NISKI  | Nazwa projektu "Inżynierka" → "Lightness" w `project.godot`                                   | Do zrobienia |
| 🔵 NISKI  | Nazwy warstw kolizji w `project.godot`                                                        | Do zrobienia |
