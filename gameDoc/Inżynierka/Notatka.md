# Nowy system zarządzania scenami (zamiast Staging.gd)

Z powodu problemów z działaniem fizyki w klasycznym scenariuszu węzła `Staging` od Godot XR Tools, w projekcie zaimplementowano własną scenę nadzorującą grę o nazwie `main.tscn`.
Zrezygnowaliśmy z ładowania węzła XROrigin wewnątrz każdej nowej sceny lub polegania na ukrytej mechanice migracji Gracza przez Staging.

Oto kluczowe punkty jak to działa teraz:

1. **Rola `main.tscn`:**
   - Jest ustrukturyzowanym węzłem głównym gry, z podpiętym skryptem `main.gd`.
   - Zawsze utrzymuje jeden stały węzeł gracza (`Player`), dzięki czemu zapobiega błędnej reinicjalizacji fizyki XR przy zmianach map.
   - Posiada węzeł `World`, do którego wgrywana i z którego usuwana jest aktualnie aktywna mapa/scena.

2. **Kompatybilność Map:**
   - Skrypty menu oraz map (`game_map.gd`, `main_menu.gd`) nadal mogą i powinny dziedziczyć z `XRToolsSceneBase`. 
   - Dzięki temu posiadają wbudowane funkcje i wystawiają sygnały `request_load_scene` oraz `request_quit`, których Twój nowy `main.gd` automatycznie pilnuje po wczytaniu mapy.

3. **Inicjowanie i przebieg:**
   - Węzeł root posiada instancję `StartXR`. Uruchamia to system XR / gogle od razu po odpaleniu okna.
   - Po starcie gry `main.gd` czeka w swoim `_ready` okrągłą sekundę i wczytuje domyślnie `res://scenes/main_menu.tscn`.
   - Gdy klikniesz Start w `main_menu.tscn`, załadowanie mapy dzieje się dzięki wbudowanym metodom w Ttween, które używają `XRToolsFade` do zaciemnienia obrazu dla płynnego i bezpiecznego przejścia.
