# Workspace - Progress Tracking

## Completed Tasks
- [x] Repository initialization
- [x] README creation
- [x] Workspace tracking initialization

## Wykonany Plan Naprawczy (2026-03-11)

### 1. Przebudowa Gracza (`scenes/player.tscn`)
- **Zmiana:** Zmieniono główny węzeł (root) z `Node3D` na `XROrigin3D`.
- **Dlaczego:** Skrypt `Staging.gd` szuka węzła `XROrigin3D` wśród swoich bezpośrednich dzieci. Poprzednia struktura (XROrigin3D jako dziecko Node3D) uniemożliwiała automatyczne wykrycie gracza przez system Staging bez modyfikacji kodu addonów.
- **Dodatki:** Poprawiono parametry `SpotLight3D` (latarki), aby była skierowana przed gracza i miała sensowny zasięg.

### 2. Naprawa Mapy (`scenes/game_map.tscn`)
- **Zmiana:** Usunięto instancję `Player` ze sceny mapy.
- **Dlaczego:** Gracz jest teraz zarządzany przez `Staging` w `main.tscn`. Pozostawienie go na mapie powodowało konflikt "Double Player" i błędy inicjalizacji XR.
- **Zmiana:** Zamieniono `Area3D` podłogi na `StaticBody3D` i dodano `MeshInstance3D` (Plane).
- **Dlaczego:** `Area3D` nie zapewnia fizycznego oparcia dla `PlayerBody`. `StaticBody3D` pozwala na stanie na podłodze, a Mesh sprawia, że jest ona widoczna w goglach.

### 3. Usunięcie pętli w `scenes/main.tscn`
- **Zmiana:** Ustawiono `main_scene` w węźle `Staging` na `res://scenes/game_map.tscn`.
- **Dlaczego:** Wcześniej scena ładowała samą siebie (`main.tscn`), co prowadziło do nieskończonej pętli.
- **Integracja:** Wstawiono scenę `player.tscn` bezpośrednio do `Staging` i wyłączono domyślne węzły origin/camera, aby system korzystał z Twojego spersonalizowanego gracza.

## Poprawki Błędów i Rozwój (2026-03-11 - Sesja 4)

### 1. Poprawa priorytetu Gracza w Staging
- **Zmiana:** W `main.tscn` ustawiono instancję `Player` na pierwszym indeksie (`index=0`).
- **Dlaczego:** Aby wymusić na skrypcie `Staging.gd` wybranie spersonalizowanego gracza zamiast domyślnego węzła.

### 2. Dodanie podstawowego sterowania
- **Zmiana:** Do `player.tscn` dodano `MovementDirect` (lewy kontroler) oraz `MovementTurn` (prawy kontroler).
- **Dlaczego:** Umożliwienie poruszania się i obracania w przestrzeni VR oraz potwierdzenie działania kontrolerów.

## Implementacja Menu Głównego (2026-03-11)

### 1. Struktura UI 2D (`scenes/main_menu_ui.tscn`)
- **Zmiana:** Stworzono kompletną scenę UI z tłem, tytułem i przyciskami (Start, Settings, Exit).
- **Skrypt:** Dodano `scripts/main_menu_ui.gd` do obsługi sygnałów przycisków.

### 2. Integracja Menu 3D (`scenes/main_menu.tscn`)
- **Zmiana:** Wykorzystano `Viewport2Din3D` do wyświetlenia UI w przestrzeni VR.
- **Skrypt:** Dodano `scripts/main_menu.gd` (dziedziczący po `XRToolsSceneBase`), który odbiera sygnały z UI i komunikuje się ze `Staging` (ładowanie mapy, wyjście z gry).
- **Środowisko:** Dodano `WorldEnvironment` i oświetlenie, aby menu nie było zawieszone w próżni.

### 3. Ulepszenia Gracza (`scenes/player.tscn`)
- **Zmiana:** Dodano `FunctionPointer` (laser) do prawego kontrolera, co umożliwia interakcję z menu.

### 4. Konfiguracja Staging (`scenes/main.tscn`)
- **Zmiana:** Ustawiono `main_menu.tscn` jako scenę startową.

## Reorganizacja Architektury i Naprawa Systemu Ładowania (2026-03-17)

### 1. Naprawa błędów "Node not found" (`scripts/main_menu.gd`, `scripts/game_map.gd`)
- **Zmiana:** Nadpisano funkcję `scene_loaded(_user_data)` pustą implementacją w skryptach scen.
- **Dlaczego:** Klasa bazowa `XRToolsSceneBase` domyślnie szuka węzła `XROrigin3D/XRCamera3D` wewnątrz ładowanej sceny. Ponieważ Gracz jest teraz zarządzany globalnie w `main.tscn`, sceny te nie posiadają własnego Origin, co powodowało błędy "null instance". Nadpisanie funkcji wyłącza to problematyczne wyszukiwanie.

### 2. Nowy Kontroler Scen (`scripts/main.gd`)
- **Zmiana:** Utworzono skrypt `Main.gd` zarządzający cyklem życia gry, zastępujący automatykę addonu `Staging`.
- **Dlaczego:** Aby zapewnić pełną kontrolę nad procesem ładowania i zagwarantować trwałość (persistence) Gracza między poziomami. Skrypt obsługuje sygnały przejścia, zarządza wątkowym ładowaniem zasobów oraz płynnymi efektami `Fade`.

### 3. Przebudowa Sceny Głównej (`scenes/main.tscn`)
- **Zmiana:** Usunięto węzeł `Staging` (z addona) na rzecz przejrzystej struktury: `Player` (trwały), `World` (kontener na poziomy), `LoadingScreen`, `StartXR` oraz `Fade`.
- **Dlaczego:** Uproszczenie hierarchii. Gracz jest teraz stałym elementem sceny głównej, co eliminuje błędy z gubieniem referencji do kamery XR przy zmianie scen. Poziomy są teraz dynamicznie wczytywane do węzła `World`.

### 4. Personalizacja Ekranu Ładowania
- **Zmiana:** Zintegrowano mechanizm "Hold trigger to continue" z oryginalnego systemu ładowania Godot XR Tools bezpośrednio w kontrolerze `Main.gd`.
- **Dlaczego:** Realizacja prośby o dedykowany ekran ładowania z manualnym potwierdzeniem przejścia, przy jednoczesnym zachowaniu płynności wizualnej (fading).

### 5. Radykalne uproszczenie i stabilizacja ruchu (Sesja 17.03 - Final Fix)
- **Zmiana:** Całkowite wyczyszczenie `scenes/main.tscn` z kolizji. Scena ta jest teraz wyłącznie pustym zarządcą.
- **Dlaczego:** Poprzednie próby dodawania podłogi do `Main` powodowały "podwójne kolizje" z wczytywanymi mapami, co wyrzucało gracza z ogromną prędkością w przestrzeń.
- **Zmiana:** Dodanie solidnej podłogi (`StaticBody3D` z `BoxShape3D`) bezpośrednio do `scenes/main_menu.tscn`.
- **Dlaczego:** Gracz musi stać na oparciu od pierwszej klatki wczytania menu. Brak podłogi w menu powodował spadanie, które silnik XRTools próbował korygować, nadając graczowi niekontrolowany pęd.
- **Zmiana:** Pełny reset `scenes/player.tscn` do ustawień domyślnych Godot XR Tools.
- **Dlaczego:** Usunięcie wszelkich niestandardowych modyfikacji fizyki i kształtów kolizji, aby przywrócić naturalne i przewidywalne sterowanie joystickiem.
- **Zmiana:** Zwiększenie opóźnienia startowego w `scripts/main.gd` do 1 sekundy.
- **Dlaczego:** Zapewnienie pełnej stabilizacji systemu śledzenia VR przed aktywacją pierwszej sceny gry.


## Current Focus
- Testowanie stabilności przejść między Menu a Mapą w nowej architekturze.

## Upcoming Tasks
- Main Menu implementation.
- Player scene refinement.
- Game room creation.
- Enemy logic (Ballora, Enemy 2).
- Mechanics (Generators, Pickups).
- Audio (SFX, floor sounds for orientation).
