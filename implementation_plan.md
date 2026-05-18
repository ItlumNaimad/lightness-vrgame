# Implementacja i Workflow Rozwoju "Lightness VR"

Plan ten precyzuje kroki (workflow) niezbędne do zrealizowania wymienionych przez Ciebie założeń projektowych. Został ułożony tak, by praca układała się w sposób iteracyjny, od fundamentów (menu, obsługa dostępności), poprzez rozwój głównego trybu (świat, fizyka, dźwięk), aż po dodawanie sztucznej inteligencji kolejnych wrogów.

## User Review Required
1. **TTS czy Nagrane sample w Menu:** Użytkownik wspomniał o wykorzystaniu syntezatora mowy (Text-To-Speech) Godota lub gotowych nagrań. Na tym etapie plan zakłada zbudowanie hybrydowego API w Godocie pozwalające wgrać własnego `.wav` lub jeśli go nie ma - przeczytać z TTS z systemu, do ustalenia na później.
2. **Rozpoznawanie gestów i interakcji u wrogów:** System np. "odwracania głowy od źródła szeptu przyległych do ściany dla Marionette" i "wyciągnięcia ręki w stronę ładującego wprost w nas Foxy'iego" wymaga precyzyjnych obliczeń wektorowych (Dot product). To bardzo dobre dla gry dla niewidomych, lecz trzeba upewnić się, w jakim zakresie gra uznaje zachowanie za udane. (np. odwrócenie głowy minimum 90 stopni).

---

## 🛠️ Faza 1: Interfejs, Przejścia i Dostępność w Godocie

Główny cel tej fazy to zapewnienie graczowi, szczególnie osobom niewidomym, łatwej kontroli przed wejściem do samej rozgrywki.

### 1. Rozbudowa Ekranu Głównego (`main_menu.tscn`) i Ekranu Ładowania
- Wsparcie dla Godotowego modułu `Control` (Buttonów UI).
- System, w którym gałka (joystick) przewija **`focus`** pomiędzy poszczególnymi Buttonami bez przymusu interakcji "Laser pointerem" dłoni.
- Po wejściu w *focus* danego elementu menu - odtwarza się dźwięk i lektor (np. „Rozpocznij Grę”, „Wyjście”). Odpowiedni kod spina do tego węzeł `AudioStreamPlayer`.
- Wyłączenie lokomocji/chodzenia postaci podczas bycia w menu głónym oraz podczas loading screenu.

### 2. Loading i Game Over (Zarządzanie Stanami)
- Skrypt w `GameController / Staging` w centralnym pliku zarządcy.
- Po wciśnięciu *Start*, scena `game_map.tscn` wczytuje się w tle (Background Resource Loading). Na czas ładowania zmieniam środowisko na prosty *Loading Screen* z jakimś sygnałem (np. tykający cichy zegar), żeby całkowicie odciąć wizję.
- System wejścia w ekran *Game Over* z możliwością resetu poziomu lub powrotu do Menu – to zapewni bezproblemowy pętlowy system gry.

---

## 🏃 Faza 2: Logika Gracza i "Hałas" w VR

Musimy dać graczowi uwarunkowania, by mógł poruszać się po świecie oraz tworzyć zjawisko głośności.

### 1. Różnicowanie Ruchu (Chód / Sprint)
- Integracja VR Player z Godot XR Tools na mapie gry (Movement Providers).
- Detekcja odchylenia gałki analogowej kontrolera - wychylenie > 80% to "Sprint".
- Kiedy gracz sprintuje, krok jest odtwarzany głośniej, a w kodzie rośnie licznik "Player_Noise = High". Poniżej = "Player_Noise = Normal". Służy to dla systemów SI Foxy'ego.

### 2. Detekcja uderzeń w ściany (Bump / Crash)
- Zastosowanie węzłów koliderów głowy (Head/Body `CharacterBody3D` bądz RigidBody Player).
- Zastosowanie fizyki uderzania np. `KinematicCollision3D`. Kiedy gracz napotka twardą kolizję w ruchu (ślepą ścianę/zasłonę) - generuje silny impuls dźwiękowy (Player_Noise = Crash). Zastosowanie audio oraz natychmiastowe wezwanie do alarmu dla Foxy!

---

## 👻 Faza 3: Przeciwnicy - Rozkład AI i Czas (Game Loop) 

Trójca wrogów zostanie wprowadzona do świata. Zamiast wprowadzać wszystkie jednocześnie, należy dobudowywać wrogów i testować osobno.

### 1. Główny GameManager i Odmierzanie Czasu (Surviving)
- Zaimplementowanie licznika czasu w węźle nadrzędnym Sceny Rozgrywki (sekundy na Przeżycie).
- W miarę wzrostu czasu -> szybkość wrogów stopniowo wzrasta, ewentualnie nowe stany ich bytu wkraczają.

### 2. Balora (The Chaser)
- Zwykły cykl ścieżek na `NavigationRegion3D` i węzła `NavigationAgent3D`.
- Funkcja detekcji Area3D: Gdy gracz zderzy się z dużym niewidzialnym obszarem okalającym Balorę wywoła się funkcja, która zmienia muzykę tła i Balora przerywa patrol i obiera pozycję za graczem, zaczynając szaleńczą gonitwę by wywołać Jumpscare. 
- Logika zgubienia Balory: Gracz musi wyjść z pierwotnej szerokiej strefy przez X sekund.

### 3. Marionette (The Whispers)
- Timer odradzający na zewnątrz mapy lub pod ścianami.
- Emituje potężne Audio 3D wokół gracza - `AudioStreamPlayer3D` by ułatwić lokalizację na uszy.
- Sprawdzanie wektora: Obliczenie `Camera3D.global_basis.z` względem strefy Marionette używając matematyki wektorowej (Dot Product).
- Jeśli kąt zaczyna zbiegać się z dźwiękiem - Marionette atakuje po krótkim czasie. Gracz ma obowiązek stać w miejscu z odwróconą głową, by ją wykończyć. Jeśli wykryje sprint podczas jej pobytu, to również uderza.

### 4. Foxy (The Dasher)
- Przebywa na uboczu poza strefą. Skrypt podłączony do rzucanego globalnego sygnału `EventBus.player_made_loud_noise(global_position)`.
- Reakcja: Wyłącza dźwięki chodu. Oblicza drogę by uderzyć jako "Szarsża" (sprint in straight line).
- Podczas szarżowania - sprawdzanie dystansu gracza oraz wektora wyciągniętej ręki (`XRController3D`), by np. zastopować jego atak jeśli wymierzymy ręką w ten front uderzeniowy.

---

## 🎙️ Faza 4: Dźwięk 3D i Optymalizacja Szlifów Audio

To gra dla niewidokmych - projektowanie musi objąć udane formaty Audio.

1. Wdrożenie i sparametryzowanie odległości tłumienia i nakładania się efektów HRTF na wszystkie odległe węzły dźwięków 3D po stronie silnika Godot (Upewnienie się w Godot Project Settings, że dźwięk przestrzenny jest skalibrowany i silnik połyka dobrze zróżnicowanie ucha lewego z prawym).
2. Dodanie odgłosów własnych kroków w reakcji w interakcją z różnymi podłożami oraz dotykaniem/przesunięciem przedmiotów co stwarza sygnał przestrzenny (Echo zrzucenia przedmiotu po prawej stronie).

## Open Questions

- Czy ten plan na ewolucję jest dobry i gotów by za niego usiąść z pierwszą fazą (Implementacja UI na Joystick we wsparciu tekstowym dla niewidomych)?
- W których elementach gry widzisz luki lub obawiasz się, że pomysł może zawieść m.in podczas fizycznych kolizji dla gracza bez percepcji wzroku? 

## Verification Plan

Ze względu, że projekt opiera się mocno o testy Hardware (Gogle Quest), po każdej dużej zmianie będziemy weryfikować zachowania logując stany do konsoli, a Twoim zadaniem będzie puszczenie gry na samych goglach by weryfikować poprawność odczuć (Audio 3D i obsługa ślepej mapy ze środowiskiem w czasie rzeczywistym).
