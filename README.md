# Lightless VR

**Lightless** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Gra jest survival horrorem zaprojektowanym w taki sposób, aby była w pełni dostępna dla osób niewidomych – bodźce wizualne dają minimalną (lub żadną) przewagę rozgrywki.

## Najnowsze zmiany (Version Log)
- **v0.5.2** - Architektura przestrzenna Menu Głównego 3D (pełnowymiarowe industrialne pomieszczenie, zbalansowane oświetlenie `SpotLight3D` skupione na interaktywnej ścianie UI, wygaszenie reszty pokoju). Udoskonalony tytuł "LIGHTLESS" z cyfrową czcionką `RubikGlitch` i wydłużonym do ~1s efektem intensywnego glitcha. Ekrany Settings i Game Over zintegrowane ze stylistyką Google Stitch (napisy wyryte w ścianie, przyciemnione tła bez przesadnej czerwieni). Angielski lektor TTS (`TTSManager`). Pełna naprawa łańcucha sygnałów w `Viewport2Din3D` (przywrócenie powiązania skryptu UI `main_menu_ui.gd`, naprawa nawigacji Start/Settings/Exit) oraz ochrona przed wielokrotnym odpaleniem w `HoldButton`.
- **v0.5.1** - Przebudowa Menu Głównego na styl industrialnej ściany 3D z wyrytymi napisami (inspirowane projektem z Google Stitch), dynamiczny efekt animacji glitch tytułu "LIGHTLESS", komponent `HoldButton` (Hold-to-Click 0.6s), eliminacja lagów TTS przez Dwell Debounce (80ms), fizyczne blokowanie rąk gracza (`CollisionHand`), subtelniejsze wskaźniki laserowe VR w chłodnej błękitnej tonacji oraz podpis autorski.
- **v0.5.0** - Wdrożenie dedykowanego ekranu Game Over (`scenes/game_over.tscn`), systemu śledzenia telemetrii sesji w `SceneLoader` (czas przetrwania, statystyki obrony, powód porażki) oraz integracji z Google Stitch i `DESIGN.md`.
- **v0.4.0** - Optymalizacja audio przy starcie mapy, wdrożenie "Kompasu Dźwiękowego", efekt zniekształcenia dźwięku Ambient (Distortion) w zależności od bliskości wrogów oraz re-balans AI (naprawa kolizji między wrogami, crescendo dla Marionetki, wibracje haptyczne HMD).
- **v0.3.0** - Wdrożenie logiki przeciwników (Balora, Marionette) bazującej na wektorach kierunkowych (VR) i systemie punktów nawigacyjnych (NavMesh) oraz wspólnego systemu JumpscareHelper.
- **v0.2.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (SceneLoader) rozwiązującego problemy fizyki XR podczas przeładowywania map.

## Znane błędy i uwagi techniczne (Known Issues)
- **Ruch gracza po Jumpscare**: Po wyzwoleniu jumpscare gracz zachowuje częściową możliwość poruszania się, co pozwala na minimalny ruch i potencjalne wywołanie drugiego jumpscare'a.
- **Przełącznik TTS**: Opcja wyłączenia TTS w panelu ustawień aktualnie nie blokuje odczytu syntezatora mowy.
- **Kliknięcie vs Przytrzymanie**: W bieżącej wersji przyciski reagują zarówno na natychmiastowe kliknięcie triggera, jak i na przytrzymanie do napełnienia paska – planowane jest usunięcie animacji ładowania paska na rzecz bezpośredniej reakcji na spust.

## O projekcie
Głównym założeniem technologicznym było zbudowanie stabilnego szkieletu scen w VR z wykorzystaniem asynchronicznego menedżera `SceneLoader`, w którym każda scena jest w 100% samowystarczalna (zawiera własne instancje `Player`, `StartXR` i `Fade`). Zapobiega to błędom fizyki i kolizji przy przeładowaniach. Rozgrywka opiera się na dźwiękowej orientacji przestrzennej i odpowiednich interakcjach z przeciwnikami.

## Stack technologiczny
- **Godot Engine 4.x** (wersja Godot 4.7 / 4.x, ustawienia Mobile Renderer dla płynności)
- **OpenXR** (Główna biblioteka do połączenia z goglami VR)
- **Godot XR Tools** - standardowe pakiety fizyki dłoni i bazowych obiektów, dostosowane na potrzeby projektu.

## Uruchomienie i testowanie
Projekt przeznaczony jest na gogle VR obsługujące OpenXR (np. Meta Quest podpięty przez Meta Quest Link / SteamVR).
1. Sklonuj repozytorium.
2. Otwórz w **Godot 4.x** (wersja z obsługą .NET nie jest wymagana, używamy GDScript).
3. Projekt uruchamia się bezpośrednio od `scenes/main_menu.tscn` (wbudowany autostart OpenXR). Za przechodzenie między mapami odpowiada asynchroniczny autoload `SceneLoader.gd`.

## Sounds:
- Sound Effect by <a href="https://pixabay.com/users/freesounds123-49985424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335600">free sound creator</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335600">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=102254">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=102254">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/freesounds123-49985424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335599">free sound creator</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=335599">Pixabay</a>
- Sound Effect by <a href="https://pixabay.com/users/sound_effects75-54573118/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=485532">Sound_effects75</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=485532">Pixabay</a>

shadow_v3a.aif by thanvannispen -- https://freesound.org/s/79713/ -- License: Attribution 4.0
Whisper Evil Little Nothings to Me by SoundBiterSFX -- https://freesound.org/s/730965/ -- License: Creative Commons 0
Whispers.wav by KrystalSounds7 -- https://freesound.org/s/466309/ -- License: Creative Commons 0
whispers.wav by SophieMezaM -- https://freesound.org/s/446083/ -- License: Attribution 3.0
Ominous whispers.wav by xtrgamr -- https://freesound.org/s/257784/ -- License: Attribution 4.0

runing.wav - Pasos_Rapid.wav by anez -- https://freesound.org/s/403437/ -- License: Attribution 4.0
foxy_runing.mp3 Demon Stomping Run.mp3 by Hoshenko -- https://freesound.org/s/697645/ -- License: Attribution 4.0

footstep_slow2.wav by stradie -- https://freesound.org/s/255569/ -- License: Attribution 4.0

WoodWalking.wav by szegvari -- https://freesound.org/s/514146/ -- License: Creative Commons 0
Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=101127">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=101127">Pixabay</a>

foxy_walking.mp3 big metallic robot footsteps by gladkiy -- https://freesound.org/s/342235/ -- License: Creative Commons 0
whoosh2 Whoosh away by jriches1 -- https://freesound.org/s/817959/ -- License: Creative Commons 0

danger Cinematic Alarm Hit by Rizzard -- https://freesound.org/s/560157/ -- License: Creative Commons 0