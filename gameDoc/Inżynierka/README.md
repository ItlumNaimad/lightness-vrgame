# Dziennik projektu i Kontekst "Lightless VR"

> Ten plik służy jako dziennik procesu powstawania gry, dokumentujący workflow, log zmian i aktualny plan działania. Poniżej znajduje się kontekst projektu dla szybkiego wczytania ułatwiającego powrót do pracy po przerwie.

## 📝 Kontekst i Założenia Gry
**Lightless VR** to gra (survival horror) dostępna w pełni dla osób niewidomych – bodźce wizualne nie dają przewagi, a gracz polega w 100% na informacjach dźwiękowych (i haptycznych). Czas odmierzany jest według przetrwanych sekwencji (surviving timer/clock).
- **Zasada ogólna**: Gra podzielona jest na sekcje Menu -> Gra -> (Game Over) -> Menu.
- **Nawigacja w menu i ustawieniach**: Interfejs wkomponowany w industrialną ścianę 3D w przestronnym pomieszczeniu, z oświetleniem skupionym punktowo wyłącznie na interaktywnej strefie GUI. Obsługiwany wskaźnikiem VR (`FunctionPointer`) za pomocą spustu kontrolera (trigger). Każdy element jest automatycznie udźwiękowiony przez lektora TTS w języku angielskim (`TTSManager`) z buforowaniem Dwell Debounce zapobiegającym lagom.
- **Zderzenia / Game Over**: Popełnienie błędu (np. zignorowanie atakującego przeciwnika lub kolizja z nim) kończy grę głośnym Jumpscarem i przenosi na ekran Game Over, gdzie prezentowana jest telemetria (czas, statystyki, powód śmierci).

## 🚀 Log Zmian (Changelog)
- **v0.5.2** - Przebudowa geometrii i klimatu Menu Głównego (rozszerzenie do pełnowymiarowego pomieszczenia 3D 10x9.2m, wygaszenie reszty pokoju, oświetlenie `SpotLight3D` skupione na ścianie UI). Udoskonalony efekt cyfrowego glitcha tytułu "LIGHTLESS" (czcionka `RubikGlitch`, wydłużenie czasu trwania mocnego glitcha do ~1s). Wdrożenie ekranów Settings i Game Over zgodnie z projektami Google Stitch (napisy wtopione w betonową ścianę, złagodzenie czerwonego oświetlenia w Game Over). Domyślny lektor TTS w języku angielskim. Pełna naprawa łańcucha sygnałów w `Viewport2Din3D` (wykrycie i naprawa braku przypisania skryptu `main_menu_ui.gd` do korzenia sceny UI, przywrócenie sygnałów `start_pressed` i `exit_pressed`) oraz blokada `_wait_for_release` w `HoldButton`.
- **v0.5.1** - Przebudowa Menu Głównego na styl industrialnej ściany 3D z wyrytymi napisami (inspirowane projektem z Google Stitch), dynamiczny efekt animacji glitch tytułu "LIGHTLESS", komponent `HoldButton` (Hold-to-Click 0.6s) na wszystkich przyciskach, eliminacja lagów TTS przez Dwell Debounce (80ms), fizyczne blokowanie rąk gracza (`CollisionHandLeft`/`CollisionHandRight`), nowy subtelny wskaźnik VR w chłodnej błękitnej tonacji (`FunctionPointer`), zmiana nazwy projektu na Lightless.
- **v0.5.0** - Wdrożenie dedykowanego ekranu Game Over (`scenes/game_over.tscn`), systemu telemetrii w `SceneLoader` i integracji z `DESIGN.md`.
- **v0.4.0** - Wdrożenie poprawek ułatwiających nawigację (Kompas Dźwiękowy, Whoosh) oraz ulepszenia Audio (efekt Distortion w tle). Rebalans przeciwników, kolizji oraz wsparcie natywnych wibracji XR.
- **v0.3.0** - Wdrożenie logiki przeciwników (Balora, Marionette) ze sztuczną inteligencją reagującą na akcje, wektory wzroku, odległość i hałas. Powstanie globalnych menadżerów zdarzeń.
- **v0.2.0** - Przebudowa architektury na system **SceneLoader**. Rezygnacja z węzła nadrzędnego `Main` na rzecz pełnej podmiany scen (`change_scene_to_packed`). Rozwiązanie problemów z fizyką XR i stabilnością gracza podczas przeładowywania map.
- **v0.1.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (Staging).

## ⚠️ Znane Problemy i Dług Techniczny (Known Bugs)
1. **Szczątkowy ruch po Jumpscare (Podwójny jumpscare)**:
   - Po wystąpieniu jumpscare'a gracz zachowuje częściową możliwość poruszania się (ruch nie jest natychmiastowo blokowany w 100%). Może to doprowadzić do kolejnej kolizji i zainicjowania drugiego jumpscare'a przed zakończeniem przejścia do ekranu Game Over.
2. **Niedziałający przełącznik TTS (Brak wyłączenia lektora)**:
   - Opcja przełączania TTS w panelu Settings (`TTSToggleBtn`) zmienia tekst na przycisku, lecz sam syntezator mowy w `TTSManager` nadal odczytuje teksty i nie respektuje globalnego wyłączenia głosu.
3. **Dualizm aktywacji przycisków VR (Kliknięcie vs Przytrzymanie)**:
   - Przyciski reagują na bezpośrednie wciśnięcie triggera (`trigger_click`) oraz na napełnienie paska ładowania `HoldButton`. Skoro do aktywacji wystarcza samo kliknięcie, pasek ładowania jest wizualnie mylący i planowane jest usunięcie animacji ładowania na rzecz bezpośredniej aktywacji na kliknięcie.

## 👻 Przeciwnicy
### 1. Balora
- **Zachowanie**: Patroluje mapę po wyznaczonej siatce NavMesh.
- **Sygnał**: Pozytywka (music box). Gdy gracz wejdzie w strefę Alertu, tempo pozytywki przyspiesza, a Balora idzie w jego stronę.
- **Kontra**: Należy natychmiast uciec na większą odległość sprintem, aby Balora wróciła do patrolu. Jej uwaga bazuje wyłącznie na bliskości gracza, nie na hałasie.

### 2. Marionette
- **Zachowanie**: Pojawia się w przestrzeni blisko gracza i emituje szepty otaczające. Dźwięk narasta i przybliża się do ucha (efekt crescendo).
- **Sygnał**: Szepty do ucha i narastające napięcie.
- **Kontra**: Należy zlokalizować źródło dźwięku i zdecydowanie machnąć ręką (kontrolerem) w jego stronę, aby odpędzić Marionetkę. Sukces nagradzany jest unikalnym dźwiękiem rozproszenia.

### 3. Foxy
- **Zachowanie**: Skupia się na impulsach skumulowanego hałasu gracza (sprint, zderzenia ze ścianami).
- **Sygnał**: Po przekroczeniu progu hałasu Foxy nagle całkowicie milknie na ~2 sekundy (sygnał ostrzegawczy), po czym następuje gwałtowna szarża w linii prostej na lokację gracza.
- **Kontra**: Po usłyszeniu ciszy należy wykonać odskok w bok LUB wystawić dłoń z kontrolerem w stronę szarży, wykonując blok. Udany blok emituje dźwięk odrzucenia.

---

## 🛠️ Plan Działania / Workflow (To-Do)

### Faza 1: Interfejs i Przejścia (Foundation)
- [x] **Accessibility Menu System**: Zaprojektowanie struktury menu obsługującego VR-Pointer z Godot XR Tools i dodatkowo wejścia D-pada/Joysticka. Zintegrowanie z Godot UI oraz systemem TextToSpeech (`TTSManager`) z buforowaniem Dwell Debounce (80ms).
- [x] **HoldButton Component**: Komponent obsługi przycisków VR z zabezpieczeniem `_wait_for_release` przed zapętleniem.
- [x] **Scene Staging / SceneLoader**: Wdrożenie asynchronicznego ładowania scen z przejściami Fade (`SceneLoader.gd`).
- [x] **Ekran Game Over**: Dedykowany interfejs z telemetrią sesji i opcją restartu / powrotu do menu (`scenes/game_over.tscn`), dopasowany do motywu industrialnego Google Stitch.
- [x] **Industrialne Menu Główne 3D**: Pełne trójwymiarowe pomieszczenie (10x9.2m) z ukierunkowanym oświetleniem punktowym na GUI, cyfrowy glitch tytułu "LIGHTLESS" (RubikGlitch, czas ~1s).
- [x] **Naprawa błędu braku skryptu UI**: Przywrócenie powiązania `main_menu_ui.gd` do korzenia sceny 2D i odblokowanie nawigacji Start/Settings.
- [ ] **Uproszczenie interakcji przycisków**: Usunięcie animacji ładowania paska w `HoldButton` na rzecz natychmiastowego kliknięcia triggerem.
- [ ] **Naprawa wyłączenia TTS**: Zapewnienie pełnej blokady mowy lektora po przełączeniu opcji na "OFF".

### Faza 2: Kontroler Gracza Rozszerzony
- [x] Obsługa logiki generowania dźwięków gracza (podział cichy uchył, chód, sprint powodujący alarm).
- [x] Rozpoznawanie uderzeń (kolizje ciała i uderzenia w ściany dla mechaniki hałasu dla Foxy'ego).
- [x] Fizyczne blokowanie rąk gracza (`CollisionHandLeft`/`CollisionHandRight`) zapobiegające przenikaniu przez ściany i interfejsy.
- [x] Subtelne wskaźniki VR (`FunctionPointer`) w chłodnej błękitnej tonacji z bezpośrednim trigger_click.
- [ ] **Blokada ruchu w trakcie Jumpscare**: Natychmiastowe zamrożenie fizyki i wejść gracza w momencie ataku potwora (eliminacja podwójnego jumpscare'a).

### Faza 3: SI Przeciwników
- [x] **Balora**: NavMeshAgent do swobodnego chodzenia - System detekcji proximity i wywołanie stanu Jumpscare. Kolizja oddzielona na odrębną warstwę.
- [x] **Marionette**: Logika szeptów kierunkowych i mechanika odpędzania machnięciem kontrolera.
- [x] **Foxy**: System alertowy na głośne dźwięki -> nagła cisza -> szarża w linii prostej. Obsługa detekcji ręki do przerwania szarży z dźwiękową nagrodą.

### Faza 4: Threat Director i Pacing
- [ ] Oś czasu pojawiania się wrogów (0:20 Balora, 0:50 Marionette, 1:30 Foxy).
- [ ] Stopniowe podbijanie trudności (np. wielokrotne szepty Marionette, szybsza Balora).
- [ ] Nowy przeciwnik **Phantom Grasp** (macki chwytające kontroler, wibracje i wyszarpywanie).
- [ ] Menu Pauzy w grze (`scenes/pause_menu.tscn`).

*Ostatnia aktualizacja:* v0.5.2 — Pełna synchronizacja dokumentacji po przebudowie pokoju 3D, naprawie łańcucha sygnałów UI i inwentaryzacji błędów.