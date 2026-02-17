```
System Staging w Godot XR Tools jest zaprojektowany jako „scena-matka”, która zarządza cyklem życia wszystkich innych scen (poziomów, menu) w Twojej grze. LoadingScreen jest integralną częścią
  tego systemu i zazwyczaj nie używasz go bezpośrednio, lecz poprzez Staging.

  Oto jak to działa i jak to wdrożyć w Twoim projekcie:


  1. Rola poszczególnych elementów
   * `Staging` (`staging.tscn`): To Twoja główna scena startowa (ustawiana w Godot jako "Main Scene"). Zawiera ona XROrigin3D, systemy ładowania w tle (LoadingScreen) oraz instancję aktualnie
     aktywnego poziomu.
   * `SceneBase` (`scene_base.gd`): Wszystkie Twoje poziomy i menu (np. main_menu.tscn, world.tscn) muszą dziedziczyć z tej klasy lub sceny. Dzięki temu mogą komunikować się ze Staging, prosząc o
     zmianę sceny.
   * `LoadingScreen` (`loading_screen.tscn`): Wyświetla się automatycznie, gdy Staging ładuje nową scenę w osobnym wątku. Obsługuje pasek postępu i opcjonalny komunikat „Naciśnij spust, aby
     kontynuować”.

  2. Jak to skonfigurować krok po kroku


  Krok A: Stworzenie głównego Stagingu
   3. Utwórz nową scenę dziedziczącą z res://addons/godot-xr-tools/staging/staging.tscn. Nazwij ją np. game_staging.tscn.
   4. Wybierz węzeł główny i w inspektorze ustaw Main Scene – to będzie Twoje menu główne (które zaraz przygotujemy).
   5. Ustaw tę scenę (game_staging.tscn) jako główną scenę projektu (Project Settings -> Run -> Main Scene).


  Krok B: Przygotowanie scen (Menu i Świat gry)
  Twoje sceny muszą być zgodne ze standardem XR Tools:
   6. Każda nowa scena (np. menu.tscn) powinna dziedziczyć z res://addons/godot-xr-tools/staging/scene_base.tscn.
   7. Wewnątrz tych scen nie dodawaj własnego XROrigin3D ani kamery, jeśli chcesz korzystać z tych wbudowanych w SceneBase. Staging automatycznie przeniesie gracza w odpowiednie miejsce.


  Krok C: Przejście z menu do gry
  Aby przejść z menu do świata gry, w skrypcie menu (który rozszerza XRToolsSceneBase) wywołaj funkcję load_scene:


   1 # Wewnątrz menu.tscn (dziedziczy z SceneBase)
   2 func _on_start_button_pressed():
   3     # Staging zajmie się resztą: wyciemnieniem ekranu, pokazaniem loading_screen
   4     # i załadowaniem nowej sceny w tle.
   5     load_scene("res://scenes/world.tscn")


  8. Jak działa LoadingScreen.gd „pod maską”?
  Jeśli chcesz dostosować sam ekran ładowania, oto kluczowe funkcje w loading_screen.gd:
   * `progress`: Wartość od 0.0 do 1.0. Staging aktualizuje ją automatycznie podczas ładowania zasobów przez ResourceLoader.
   * `follow_camera`: Jeśli true, ekran ładowania obraca się za głową gracza (płynnie, dzięki krzywej follow_speed), co zapobiega sytuacji, w której gracz patrzy w czarną pustkę, bo odwrócił się
     od splash screena.
   * `enable_press_to_continue`: Jeśli w Staging zaznaczysz Prompt for Continue, ekran nie zniknie od razu po załadowaniu 100%. Czeka, aż gracz przytrzyma spust (wykorzystując HoldButton). Jest
     to zalecane w VR, aby uniknąć nagłego „wskoczenia” w nową scenę, co może powodować nudności.


  Dlaczego warto używać Staging do menu?
  Tak, to świetne rozwiązanie, ponieważ:
   1. Płynność: Menu jest traktowane jak każda inna scena. Możesz łatwo wrócić z gry do menu funkcją exit_to_main_menu().
   2. Standard: Staging dba o to, by kamera i kontrolery były zawsze poprawnie zainicjalizowane przed startem poziomu.
   3. User Experience: LoadingScreen wbudowany w Staging jest zoptymalizowany pod VR (odpowiednie odległości renderowania, czarne tło oszczędzające oczy, śledzenie głowy).
```
