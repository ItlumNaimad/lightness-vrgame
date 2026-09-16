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


