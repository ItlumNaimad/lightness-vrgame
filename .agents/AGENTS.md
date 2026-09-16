
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