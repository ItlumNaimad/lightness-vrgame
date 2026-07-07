# Lightness VR

**Lightness** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Gra jest survival horrorem zaprojektowanym w taki sposób, aby była w pełni dostępna dla osób niewidomych – bodźce wizualne dają minimalną (lub żadną) przewagę rozgrywki.

## Najnowsze zmiany (Version Log)
- **v0.3.0** - Wdrożenie logiki przeciwników (Balora, Marionette) bazującej na wektorach kierunkowych (VR) i systemie punktów nawigacyjnych (NavMesh) oraz wspólnego systemu JumpscareHelper.
- **v0.2.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (SceneLoader) rozwiązującego problemy fizyki XR podczas przeładowywania map.

## O projekcie
Głównym założeniem technologicznym było zbudowanie solidnego szkieletu ("Stagingu") dla VR, gdzie Gracz i jego wirtualne dłonie nie muszą być fizycznie resetowane czy przenoszone przy każdej zmianie lokacji. Rozgrywka opiera się na dźwiękowej orientacji przestrzennej i odpowiednich interakcjach z trójką specjalnych przeciwników.

## Stack technologiczny
- **Godot Engine 4.x** (wersja Godot 4.6, ustawienia Mobile Renderer dla płynności)
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
