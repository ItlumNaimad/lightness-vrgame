# Lightless VR

**Lightless** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Gra jest survival horrorem zaprojektowanym w taki sposób, aby była w pełni dostępna dla osób niewidomych – bodźce wizualne dają minimalną (lub żadną) przewagę rozgrywki.

## Najnowsze zmiany (Version Log)
- **v0.5.3** - System Poziomów / Nocy (FNaF Style 0-5), Nawigacja Gałką VR w Menu, Trwały Zapis Ustawień i Ciemność z Oświetleniem Stóp:
  - **System Nocy (Autoload `LevelManager`):** Wdrożenie nocy od Nocy 0 (Test Room / bezpieczny trening) do Nocy 5 (Koszmar: maksymalna prędkość Balory + dwóch niezależnych Foxy szarżujących z różnych kierunków + Marionette + Phantom Grasp). Dynamiczny czas nocy (30s - 150s), dzwon 6:00 AM, zapowiedź lektorska TTS i automatyczne odblokowanie kolejnej nocy.
  - **Trwały zapis gry i ustawień (`user://save_data.json` i `user://settings.json`):** Postęp odblokowanych nocy oraz ustawienia suwaków głośności (`Master`, `Enemies`, `Footsteps`, `Jumpscare`) i status lektora TTS są trwale zapisywane i wczytywane przy każdym uruchomieniu gry, zapobiegając ich resetowaniu.
  - **Nawigacja Joystickiem w Menu (`VRUINavigator`):** Zgodnie z wytycznymi dostępności dla graczy niewidomych, menu główne oraz menu pauzy obsługują pełną nawigację pionową gałką kontrolera z automatycznym odczytem lektorskim (TTS) i impulsami haptycznymi. Zatwierdzenie przyciskiem A (`ax_button`) lub pociągnięciem spustu.
  - **Naturalny obrót ciała 360°:** Usunięcie sztucznego obracania joystickiem (`MovementTurn`) i szyny `Whoosh` na rzecz płynnego obracania się fizycznym ciałem w przestrzeni VR.
  - **Ciemność otoczenia i FeetLight:** Wyłączenie globalnego światła na mapie na rzecz 100% mroku korytarzy z subtelnym światłem podłogowym (`FeetLight`, 1.6m pod stopami), dającym orientację pozycji ciała bez ujawniania układu labiryntu.
  - **HoldButton (Blokada kliknięć bez naładowania):** Wyzerowanie `button_mask = 0`, co definitywnie eliminuje przedwczesne kliknięcia i wymaga pełnego przytrzymania triggera przez 0.65s.
- **v0.5.2** - Kompleksowa realizacja zaleceń audytu technicznego i poprawek stabilności: Naprawa systemu Fade w `SceneLoader.gd` (usunięcie nieskutecznych guardów `ClassDB.class_exists`, podwójny `await process_frame` po zmianie sceny, reset `is_loading` przy błędzie). Prawidłowy tracking gracza z poziomu głowy VR (`XRCamera3D` w grupie `player_head`) dla efektu zniekształcenia dźwięku (Distortion) i namierzania Foxy'ego. Rozdzielenie próbek audio (`danger.wav`, `whoosh2.mp3`, `Broken bell.ogg`, `nice-sfx.mp3`). Akustyka i haptyka kolizji ze ścianami (`EventBus.noise_emitted`). Nowa maszyna stanów Balory (Patrol, Alert z przyspieszającą pozytywką, Pościg, Ucieczka na odległość) i dopasowany NavMesh. Aktywna obrona przed Marionetką poprzez zamach kontrolerem VR z haptyką bliskości ucha. Threat Director (pacing pojawiania się wrogów na osi czasu). Nowy przeciwnik **Phantom Grasp** (chwyt za kontroler, wibracje i mechanika wyszarpywania). System **Echolokacji** (puls dźwiękowo-haptyczny na przycisku A/X sondujący układ ścian kosztem hałasu). Dedykowane **Menu Pauzy VR** (`scenes/pause_menu.tscn`). Naprawa wyłącznika lektora TTS w ustawieniach oraz zabezpieczenia `is_inside_tree()`. Architektura przestrzenna Menu Głównego 3D z industrialnym klimatem Google Stitch i cyfrowym glitchem `RubikGlitch`.

## O projekcie
Głównym założeniem technologicznym było zbudowanie stabilnego szkieletu scen w VR z wykorzystaniem asynchronicznego menedżera `SceneLoader`, w którym każda scena jest w 100% samowystarczalna (zawiera własne instancje `Player`, `StartXR` i `Fade`). Zapobiega to błędom fizyki i kolizji przy przeładowaniach. Rozgrywka opiera się na dźwiękowej orientacji przestrzennej i odpowiednich interakcjach z przeciwnikami. Interfejs gry zaprojektowano z myślą o pełnej dostępności – obok wskaźnika laserowego VR oferuje kompletną nawigację gałką analogową kontrolera (joystickiem) z odczytem lektorskim (TTS) i haptyką, umożliwiając osobom niewidomym intuicyjną obsługę menu bez konieczności celowania w przestrzeni 3D.

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