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

### Zadania do wykonania

| Priorytet | Zadanie                                                                                       | Status       |
| --------- | --------------------------------------------------------------------------------------------- | ------------ |
| 🟢 WYSOKI | Ekran Game Over (dedykowana scena / UI / telemetria)                                         | Zrobione     |
| 🟢 WYSOKI | System TTS / lektora w menu (Accessibility z Dwell Debounce) + HoldButton                      | Zrobione     |
| 🟢 WYSOKI | Przebudowa Menu Głównego (industrialna ściana 3D + glitch "LIGHTLESS")                       | Zrobione     |
| 🟢 WYSOKI | Rozbudowa pokoju Menu Głównego do pełnego 3D (v0.5.2)                                         | Zrobione     |
| 🟢 WYSOKI | Naprawa łańcucha sygnałów UI i odblokowanie nawigacji menu (v0.5.2)                            | Zrobione     |
| 🟢 WYSOKI | Lektor TTS w języku angielskim (v0.5.2)                                                       | Zrobione     |
| 🟢 WYSOKI | Fizyczne blokowanie rąk gracza (`CollisionHand`)                                             | Zrobione     |
| 🟢 WYSOKI | Zaawansowane dźwięki kroków gracza (zależne od powierzchni podłogi + triggery dla Foxy)       | Zrobione     |
| 🟢 WYSOKI | Dźwiękowa informacja zwrotna przy obracaniu się joystickiem (Whoosh + Kompas Dźwiękowy)       | Zrobione     |
| 🟢 WYSOKI | Subtelne wskaźniki VR w chłodnym błękicie (`FunctionPointer`)                                | Zrobione     |
| 🟢 NISKI  | Nazwa projektu → "Lightless" w `project.godot` i dokumentacji                                 | Zrobione     |
| 🟢 NISKI  | Nazwy warstw kolizji w `project.godot`                                                        | Zrobione     |
| 🔴 PILNE  | Blokada ruchu po Jumpscare (eliminacja szczątkowego ruchu i podwójnego jumpscare'a)           | Do zrobienia |
| 🔴 PILNE  | Naprawa wyłącznika TTS w panelu Settings (pełna blokada mowy lektora)                         | Do zrobienia |
| 🟡 WYSOKI | Uproszczenie przycisków VR (usunięcie animacji paska HoldButton na rzecz kliknięcia)         | Do zrobienia |
| 🟡 WYSOKI | Threat Director (pacing wrogów: Balora 0:20, Marionette 0:50, Foxy 1:30)                      | Do zrobienia |
| 🟡 WYSOKI | Nowy przeciwnik Phantom Grasp (macki / chwyt kontrolera i wyszarpywanie)                      | Do zrobienia |
| 🟡 ŚREDNI | Menu Pauzy w grze (`scenes/pause_menu.tscn`)                                                  | Do zrobienia |