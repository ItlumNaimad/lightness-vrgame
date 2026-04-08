# Lightness VR

**Lightness** to autorski, inżynierski projekt gry w wirtualnej rzeczywistości (VR) utworzony w silniku Godot Engine. Tytuł stawia sobie za zadanie stworzenie immersyjnego środowiska z unikalnymi mechanikami VR i własnym podejściem do zarządzania scenami (optymalizacja ładowania zasobów oraz eliminacja problemów z fizyką XR na przejściach map).

## O projekcie
Głównym założeniem było zbudowanie solidnego szkieletu ("Stagingu") dla VR, gdzie Gracz i jego wirtualne dłonie nie muszą być fizycznie resetowane czy przenoszone przy każdej zmianie lokacji. Sercem gry jest centralny moduł zarządzający (`main.gd`), który ładuje świat i środowiska poboczne podłączając je dynamicznie pod jeden spójny system.

## Stack technologiczny
- **Godot Engine 4.x** (wersja Godot 4.6, ustawienia Mobile Renderer dla płynności)
- **OpenXR** (Główna biblioteka do połączenia z goglami VR)
- **Godot XR Tools** - standardowe pakiety fizyki dłoni i bazowych obiektów, dostosowane na potrzeby projektu.

## Uruchomienie i testowanie
Projekt przeznaczony jest na gogle VR obsługujące OpenXR (np. Meta Quest podpięty przez Meta Quest Link / SteamVR).
1. Sklonuj repozytorium.
2. Otwórz w **Godot 4.x**
3. Po odpaleniu (F5) uruchomi się scena `main.tscn`, która automatycznie podłączy gogle i załaduje interfejs w 3D `main_menu.tscn`

> **Szczegółowa dokumentacja** koncepcyjna i techniczna gry opisana na etapie planowania pracy inżynierskiej znajduje się w folderze `gameDoc/Inżynierka/Dokumentacja.pdf`.
