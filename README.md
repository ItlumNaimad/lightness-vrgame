# Lightness VR

**Lightness** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Gra jest survival horrorem zaprojektowanym w taki sposób, aby była w pełni dostępna dla osób niewidomych – bodźce wizualne dają minimalną (lub żadną) przewagę rozgrywki.

## Najnowsze zmiany (Version Log)
- **v0.1.0** - Zaprojektowanie założeń koncepcyjnych oraz opracowanie customowego systemu zarządzania scenami (Staging) rozwiązującego problemy fizyki XR podczas przeładowywania map.

## O projekcie
Głównym założeniem technologicznym było zbudowanie solidnego szkieletu ("Stagingu") dla VR, gdzie Gracz i jego wirtualne dłonie nie muszą być fizycznie resetowane czy przenoszone przy każdej zmianie lokacji. Rozgrywka opiera się na dźwiękowej orientacji przestrzennej i odpowiednich interakcjach z trójką specjalnych przeciwników.

## Stack technologiczny
- **Godot Engine 4.x** (wersja Godot 4.6, ustawienia Mobile Renderer dla płynności)
- **OpenXR** (Główna biblioteka do połączenia z goglami VR)
- **Godot XR Tools** - standardowe pakiety fizyki dłoni i bazowych obiektów, dostosowane na potrzeby projektu.

## Uruchomienie i testowanie
Projekt przeznaczony jest na gogle VR obsługujące OpenXR (np. Meta Quest podpięty przez Meta Quest Link / SteamVR).
1. Sklonuj repozytorium.
2. Otwórz w **Godot 4.x**
3. Po odpaleniu (F5) uruchomi się scena `main.tscn`, która automatycznie podłączy gogle i w odpowiednim momencie załaduje w 3D `main_menu.tscn`.
