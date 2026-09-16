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

*Ostatnia aktualizacja:* v0.5.2 — Realizacja audytu technicznego i poprawek stabilności (Fade, tracking kamery gracza, semantyka audio, kolizje ze ścianami, stany Balory, odpędzanie Marionetki, Phantom Grasp, Echolokacja, Menu Pauzy VR, wyłącznik TTS, failsafe pauzy).