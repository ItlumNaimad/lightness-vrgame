# Dziennik projektu i Kontekst "Lightness VR"

> Ten plik służy jako dziennik procesu powstawania gry, dokumentujący workflow, log zmian i aktualny plan działania. Poniżej znajduje się kontekst projektu dla szybkiego wczytania ułatwiającego powrót do pracy po przerwie.

## 📝 Kontekst i Założenia Gry
**Lightness VR** to gra (survival horror) dostępna w pełni dla osób niewidomych – bodźce wizualne nie dają przewagi, a gracz polega w 100% na informacjach dźwiękowych (i haptycznych). Czas odmierzany jest według przetrwanych sekwencji (surviving timer/clock).
- **Zasada ogólna**: Gra podzielona jest na sekcje Menu -> Ekran Ładowania (Loading) -> Gra -> (Game Over) -> Menu.
- **Nawigacja w menu i ekranie ładowania**: Ograniczona mobilność (brak chodu). Interfejs obsługiwany wskazaniem wirtualnej dłoni lub (co ważne dla sprawności działania) obsługiwany joystickiem kontrolera, po którym porusza się lektor (nagrany dźwięk lub syntezator TTS odczytujący zaznaczony tekst).
- **Zderzenia / Game Over**: Popełnienie błędu (np. zignorowanie atakującego przeciwnika lub kolizja z nim) kończy grę głośnym Jumpscarem. Na Ekranie Game Over gracz wybiera czy spróbować ponownie, czy powrócić do menu głównego.

## 🚀 Log Zmian (Changelog)
- **v0.2.0** - Przebudowa architektury na system **SceneLoader**. Rezygnacja z węzła nadrzędnego `Main` na rzecz pełnej podmiany scen (`change_scene_to_packed`). Rozwiązanie problemów z fizyką XR i stabilnością gracza podczas przeładowywania map.
- **v0.1.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (Staging).

## 👻 Przeciwnicy
### 1. Balora
- **Zachowanie**: Patruje / Chodzi po pokoju.
- **Sygnał**: Gdy gracz wejdzie w określony promień detekcji, odtwarzana jest przyspieszona muzyka oznaczająca początek gonitwy.
- **Kontra**: Należy natychmiast uciec na większą odległość, aby Balora zgubiła "trop". Jej słuch bazuje na naszej bliskości. 

### 2. Marionette
- **Zachowanie**: Śledzi z pozycji obrzeża mapy (ściany). Powoli otacza gracza i w końcu wydaje szepty otaczające.
- **Sygnał**: Szepty, lub bliżej nieokreślony losowy dźwięk niepokoju blisko głowy gracza.
- **Kontra**: Należy zatrzymać się w miejscu, po czym odwrócić głowę od głównego źródła szeptów (unikać patrzenia na źródło dźwięku). Brak jakiejkolwiek wymuszonej interakcji lub zbyt długie zwlekanie skutkuje atakiem.

### 3. Foxy
- **Zachowanie**: Skupia się na impulsach hałasu.
- **Sygnał**: Wydać głośny dźwięk np. poprzez zaczenie sprintu (bieganie głośniejsze niż chodzenie) lub poprzez kolizję ze ścianą czy istotną przeszkodą. Wówczas jego własne dźwięki całkowicie się wyciszają. Następuje szarża w linii prostej na lokację gracza w której doszło do rzekomego dźwięku.
- **Kontra**: Po nasłuchaniu ciszy Foxy'ego należy zrobić krok z dala od ścieżki uderzenia ORAZ/ALBO skutecznie wyciągnąć kontroler (jako osłonę / odepchnięcie / nakierowanie z dystansu) w stronę nadbiegającej szarży by zanegować uderzenie.

---

## 🛠️ Plan Działania / Workflow (To-Do)

### Faza 1: Interfejs i Przejścia (Foundation)
- [ ] **Accessibility Menu System**: Zaprojektowanie struktury menu obsługującego VR-Pointer z Godot XR Tools i dodatkowo wejścia D-pada/Joysticka. Zintegrowanie z Godot UI oraz systemem TextToSpeech / AudioStreamPlayer wymawiającym buttony.
- [x] **Scene Staging / SceneLoader**: Wdrożenie asynchronicznego ładowania scen z przejściami Fade.
- [ ] **Ekran Game Over**: Interfejs z logicznym powrotem dający możliwość na reset gry.

### Faza 2: Kontroler Gracza Rozszerzony
- [ ] Obsługa logiki generowania dźwięków gracza (podział cichy uchył, chód, sprint powodujący alarm).
- [ ] Rozpoznawanie uderzeń (Body kolizje i uderzenia w ściany dla mechaniki hałasu dla Foxiego).

### Faza 3: SI Przeciwników
- [x] **Balora**: NavMeshAgent do swobodnego chodzenia - System detekcji proximity i wywołanie stanu Jumpscare.
- [x] **Marionette**: Logika Spawnów przyległych do ściany -> system orientacyjny kierunku wzroku na głowie gracza (wektory XRCamera3D) oraz badanie dystansu w poziomie.
- [ ] **Foxy**: System alertowy na głośne dźwięki -> zatrzymanie Audio -> szarża wektorem prostej ze ślepej strugi. Obsługa detekcji ręki do przerwania szarży.

### Faza 4: Gameplay Loop i Audio
- [ ] Główny Menadzer przetrwania i timera (liczenie czasu z narastającą presją przeciwników).
- [ ] Globalne zasoby audio (SFX chodzenia, ambisentów, jumpscareów upewnienie się co do pozycjonowania dźwięku).

*Ostatnia aktualizacja:* Plik roboczy dopasowany do planu deweloperskiego dla spójności pracy inżynierskiej.
