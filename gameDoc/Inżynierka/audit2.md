## Podsumowanie (najważniejsze wnioski i “P0” poprawki)

1) **W kodzie zostały “bezpieczniki debugowe” typu `or true`, które realnie wyłączają warunki i psują logikę** (m.in. w `SceneLoader` i `foxy.gd`). To jest błąd implementacyjny, nie styl.   
2) **`SceneLoader` nie resetuje `is_loading` w ścieżce błędu ładowania** → pojedyncza awaria może “zablokować” kolejne przejścia scen.   
3) **`game_map.tscn` deklaruje zasoby Balory i Foxy’ego, ale nie instancjuje ich jako węzłów** (w tej gałęzi `audit` na mapie faktycznie widzę tylko `Marionette`, `StartXR`, `Player`, `Fade`, ambient).   
4) **Poziomy głośności wrogów są ekstremalne (np. Foxy ~ +15 dB)** i stoją w sprzeczności z zasadami miksu, które sam opisujesz w SKILL.md.   
5) **`Marionette` działa w `_process`, mimo że w SKILL.md sam wskazujesz, że VR i zmienny FPS potrafią rozjechać timing AI**. To nie musi być błąd “teraz”, ale to ryzyko regresji i niepowtarzalnych zachowań.   
6) **UI/TTS jest dobrze pomyślane (debounce, warmup, haptics na hover/click)**, ale warto dopiąć to projektowo do jednej, spójnej “warstwy accessibility”, żeby nie rozlewało się po skryptach UI.   
7) **Haptyka**: korzystasz z `trigger_haptic_pulse("haptic", ...)` i masz akcję `haptic` w action mapie, więc fundament jest poprawny.   

Poniżej masz audyt “projektowo‑implementacyjny” + konkretne propozycje poprawek (w tym gotowe patche).

---

## 0) Kontekst repo / konfiguracja (co audytuję)

- Projekt jest skonfigurowany jako **Godot 4.7** (feature `4.7`) i używa **Mobile renderera**.   
- OpenXR jest włączony, XR Tools plugin jest aktywny, a jako autoloady masz m.in. `SceneLoader`, `EventBus`, `TTSManager` i autoloady XR Tools (`XRToolsUserSettings`, `XRToolsRumbleManager`).   
- W scenach gameplay/menu stosujesz dobry wzorzec “scena samowystarczalna”: `StartXR` + `Player` + `Fade` (w `game_map.tscn` widoczne wprost).   

To jest bardzo sensowna baza pod VR (zwłaszcza w kontekście Twojej uwagi o niestabilności fizyki XR przy doinstancjonowywaniu podscen).

---

## 1) Architektura scen i przejść (SceneLoader) — audyt + poprawki

### 1.1. Plusy (jest dobrze)
- Masz **asynchroniczne ładowanie scen** przez `ResourceLoader.load_threaded_request()` i polling w `_process()`, plus fade‑out/fade‑in.   
- Jest **blokada wielokrotnego wywołania** (`is_loading`).   

To są krytyczne elementy “comfortu VR”.

### 1.2. Problemy (P0/P1)
**P0: `or true` w `SceneLoader`**  
W `SceneLoader` masz:

```gdscript
if ClassDB.class_exists("JumpscareHelper") or true:
	JumpscareHelper.is_jumpscaring_global = false
```

To *zawsze* wejdzie w blok. To jest klasyczny “debug bypass”, który powinien być usunięty.   

**P0: brak resetu `is_loading` w ścieżce błędu**  
Gdy `THREAD_LOAD_FAILED` / `INVALID_RESOURCE`, wyłączasz `_process`, logujesz błąd… ale **nie ustawiasz `is_loading = false`**. Efekt: loader może się zablokować “na zawsze” po jednym failu.   

**P1: Fade tween zawsze startuje z 0 albo 1 “na sztywno”**  
W `_set_fade()` wymuszasz `current_alpha = 1.0 if target_alpha == 0.0 else 0.0`. To może powodować “skok” w nietypowych sekwencjach (np. przerwane przejście, fail load, szybki powrót).   

### 1.3. Patch: bezpieczny SceneLoader (minimalna zmiana, bez przebudowy)

**Proponowana wersja (diff mentalny) dla `scripts/scene_loader.gd`:**

```gdscript
extends Node

var last_survival_time: float = 0.0
var last_death_reason: String = "Nieznane zagrożenie"
var steps_taken: int = 0
var marionettes_defended: int = 0
var foxy_charges_blocked: int = 0

var scene_path: String = ""
var is_loading: bool = false

var _fade_alpha: float = 0.0
var _fade_tween: Tween

func load_scene(path: String) -> void:
	if is_loading:
		return
	is_loading = true
	scene_path = path

	_set_fade(1.0, 0.5)
	await get_tree().create_timer(0.6).timeout

	var err := ResourceLoader.load_threaded_request(scene_path)
	if err != OK:
		# natychmiastowy błąd requestu
		_on_load_failed("load_threaded_request error=%s" % err)
		return

	set_process(true)

func _process(_delta: float) -> void:
	var progress := []
	var status := ResourceLoader.load_threaded_get_status(scene_path, progress)

	if status == ResourceLoader.THREAD_LOAD_FAILED or status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		_on_load_failed("threaded_get_status failed")
		return

	if status == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		var packed: PackedScene = ResourceLoader.load_threaded_get(scene_path)
		if packed == null:
			_on_load_failed("loaded resource is null")
			return

		get_tree().change_scene_to_packed(packed)

		# reset
		is_loading = false
		scene_path = ""

		# bez "or true"
		JumpscareHelper.is_jumpscaring_global = false

		call_deferred("_fade_in")

func _on_load_failed(msg: String) -> void:
	set_process(false)
	printerr("SceneLoader fail: ", msg, " path=", scene_path)
	is_loading = false
	scene_path = ""
	_set_fade(0.0, 0.2) # wróć do obrazu, żeby nie zostać w czerni

func _set_fade(target_alpha: float, duration: float) -> void:
	if _fade_tween and _fade_tween.is_running():
		_fade_tween.kill()

	_fade_tween = get_tree().create_tween()
	var from := _fade_alpha
	var to := target_alpha
	_fade_alpha = target_alpha
	_fade_tween.tween_method(_apply_fade_alpha, from, to, duration)

func _apply_fade_alpha(a: float) -> void:
	XRToolsFade.set_fade("scene_transition", Color(0,0,0,a))

func _fade_in() -> void:
	_set_fade(0.0, 0.5)
```

Co to daje:
- Znika P0 (`or true`).
- Loader odblokowuje się po failu.
- Fade jest “stanowy” (pamięta alpha).
- Tweeny się nie nakładają (kill poprzedniego).

Twoja obecna logika jest blisko — to jest raczej “utwardzenie” niż przebudowa.   

---

## 2) EventBus / komunikacja (Foxy + PlayerAudioManager) — audyt + poprawki

### 2.1. Plusy
- `EventBus.noise_emitted` jest prosty i dobry jako “szyna zdarzeń” (pub/sub).   
- `PlayerAudioManager` emituje hałas na podstawie kroków i prędkości (`ground_control_velocity`). To jest fajny, “systemowy” sposób karmienia AI.   

### 2.2. Problemy
**P0: `or true` w `foxy.gd`**  
Masz:

```gdscript
if ClassDB.class_exists("EventBus") or true:
   var event_bus = get_node_or_null("/root/EventBus")
   ...
```

To jest to samo ryzyko, co w `SceneLoader`: warunek jest martwy.   

**P1: brak disconnectu przy unload (wyciek połączeń przy nietypowych flow)**  
Przy `change_scene_to_packed` zwykle wszystko jest niszczone, ale autoload `EventBus` zostaje. Jeżeli kiedyś zaczniesz doinstancjonowywać Foxy’ego wielokrotnie w obrębie sceny albo robić respawny, to bez disconnectu możesz dostać wielokrotne callbacki.

### 2.3. Patch (minimalny) dla `foxy.gd`
Zamiast `ClassDB... or true`:

```gdscript
func _ready() -> void:
	if jumpscare_trigger:
		jumpscare_trigger.body_entered.connect(_on_body_entered)
	if block_trigger:
		block_trigger.body_entered.connect(_on_block_entered)

	if EventBus and not EventBus.noise_emitted.is_connected(_on_noise_emitted):
		EventBus.noise_emitted.connect(_on_noise_emitted)

func _exit_tree() -> void:
	if EventBus and EventBus.noise_emitted.is_connected(_on_noise_emitted):
		EventBus.noise_emitted.disconnect(_on_noise_emitted)
```

To utrzymuje dokładnie to samo zachowanie, ale bez “haków debugowych”.   

---

## 3) AI przeciwników — audyt i korekty projektowe

### 3.1. Foxy (szarża + blok ręką)
**Co działa dobrze**
- Stanowa logika (`LISTENING → PREPARING_CHARGE → CHARGING`) i “snapshot” pozycji gracza tuż przed szarżą.   
- Dobry pomysł z `BlockTrigger` maskującym tylko warstwę dłoni (`collision_mask = 131072`, czyli layer 18).   

**Ryzyka / poprawki**
- W `_physics_process` resetujesz `velocity.y` *warunkowo* (nie resetujesz w `CHARGING`). To może być OK, ale jeżeli Foxy kiedykolwiek straci “floor contact” podczas CHARGING (np. próg, schodek), to `velocity.y` zacznie żyć własnym życiem. Rozważyłbym po prostu konsekwentny reset po `is_on_floor()`.   
- `print()` w VR w pętli potrafi robić śmieci i przeszkadzać w profilowaniu — owiń w `if OS.is_debug_build()`.

### 3.2. Balora (NavigationAgent3D)
**Plus**
- Zastosowałeś sensowną korektę `path_desired_distance` i `target_desired_distance = 2.0`, co jest typowym obejściem problemu “cel jest na podłodze, a agent ma pivot wyżej”.   

**Do poprawy (czytelność / higiena)**
- W `ballora.gd` masz komentarze typu `#[ASK] ...` — do pracy inżynierskiej i repo “audit” lepiej je usunąć albo przenieść do dokumentu/issue, bo to wygląda jak niedomknięty TODO.   

### 3.3. Marionette (audio‑only “patrz/nie patrz” + bezruch)
**Co jest bardzo dobre projektowo**
- Mechanika oparta o dot‑product (próg “spojrzenia”) i osobno próg ruchu w 2D (x/z), z “grace period” oraz crescendo (zmniejszający się dystans) — to jest spójne z Twoim celem accessibility i horroru audio.   

**Największy problem implementacyjny**
- Całość działa w `_process(delta)`. W VR FPS bywa zmienny, a Ty sam w SKILL.md opisujesz ryzyko “różnych prędkości reakcji”. Tutaj jest to szczególnie ważne, bo mechanika jest *czasowo‑progowa* (look_fail_time, survive_time, attack_duration_limit).   

**Proponowana poprawka**
- Przenieś logikę z `_process` do `_physics_process` (albo przynajmniej użyj stałego kroku przez akumulację czasu i wykonywanie “ticków” w pętli). To poprawi powtarzalność zachowania i ułatwi obronę tezy (“czas reakcji = X sekund w modelu symulacji”).   

**Mała, ale konkretna niespójność**
- Tekst błędu mówi: `"Czas na reakcję (3s) minął!"`, a `attack_duration_limit` ma domyślnie `5.5`. Ujednolić (albo zmienić limit, albo komunikat).   

---

## 4) Audio (formaty, import, głośności, sceny)

### 4.1. Format i import (rekomendacja oparta o dokumentację Godota)
Godot 4.7 dokumentuje import trzech podstawowych formatów audio: **WAV, Ogg Vorbis, MP3** oraz związane z nimi ustawienia importu. W audycie “projektowym” warto dopiąć zasadę: *format dobieramy do roli dźwięku + ustawień importu, a nie “jak akurat pobrałem asset”*.   

### 4.2. Głośność (problem w repo)
W `scenes/foxy.tscn` dźwięki kroku/biegu mają `volume_db` około **+15 dB**, co praktycznie gwarantuje dominację miksu (i potencjalne przestery/zmęczenie).   
W `scenes/marionette.tscn` szept ma `volume_db = 8.0`.   

**Poprawka projektowa (zalecana)**
- Zrób 3–4 busy: `Ambient`, `Enemies`, `UI`, `Player`.  
- Ustal docelowy headroom (np. Master ~ -6 dB), a potem ustawiaj poziomy *w busach*, a nie w każdej scenie wroga.  
- Zostaw `volume_db` w scenach raczej blisko 0 / lekko na minus, a balans rób centralnie.

To ułatwia też pracę inżynierską: możesz w rozdziale o audio pokazać “architekturę miksu”, zamiast listy wyjątków.

### 4.3. Jednorazowe dźwięki tworzone dynamicznie (micro‑stutter ryzyko)
W kilku miejscach tworzysz `AudioStreamPlayer.new()` “w locie” (np. ping kompasu, success). To jest OK funkcjonalnie, ale w VR warto rozważyć **pule (pool) albo preinstancjowane one‑shoty**, bo alokacje w nieprzewidywalnym momencie potrafią generować małe przycięcia.

Przykład miejsca: `PlayerAudioManager._trigger_compass_ping()`.   

---

## 5) XR / haptyka / action map — audyt

### 5.1. Action map i “haptic”
Masz w `openxr_action_map.tres` akcję `haptic` (typ 4) dla `/user/hand/left` i `/user/hand/right`.   
To się spina z Twoim wywołaniem:

```gdscript
left_hand.trigger_haptic_pulse("haptic", 100.0, 1.0, 0.5, 0.0)
```

w `JumpscareHelper`.   

Dodatkowo, Godot opisuje koncepcję XR action mapy (nazwy akcji są tym, co dostajesz w sygnałach i czego używasz do bindowania).   

### 5.2. Poprawka projektowa: “jedno źródło prawdy” dla haptyki
Masz autoload `XRToolsRumbleManager`, ale nie widzę go w Twojej logice jumpscare/UI (robisz bezpośrednie `trigger_haptic_pulse`).   

Rekomendacja:
- Albo konsekwentnie idziesz “low‑level” i zostawiasz `trigger_haptic_pulse` (OK dla pracy),  
- Albo robisz `HapticsManager` (twój autoload), który mapuje zdarzenia (`ui_hover`, `ui_click`, `jumpscare`, `success_block`) na parametry (freq/amp/duration) i *tam* dopiero wywołuje kontrolery. Dzięki temu:
  - nie powielasz parametrów po całym kodzie,
  - łatwiej testować i balansować.

---

## 6) Sceny `.tscn` — konkretne niespójności i poprawki

### 6.1. `game_map.tscn`: brak instancji Balory i Foxy’ego
W `game_map.tscn` masz ext_resource dla `balora.tscn` i `foxy.tscn`, ale wśród węzłów końcowych widzę tylko `Marionette`, `StartXR`, `Player`, `Fade`, ambient i geometrię.   

**Poprawka**
- Jeśli to nie jest celowe “na branchu audit”, dodaj instancje:
  - `[node name="Balora" parent="." instance=ExtResource("6_oviui")]`
  - `[node name="Foxy" parent="." instance=ExtResource("11_foxy")]`
- Alternatywnie: spawnuj je skryptem w `_ready()` mapy (ale wtedy usuń martwe ext_resource z `.tscn`, żeby plik nie sugerował czegoś, czego nie robi).

### 6.2. `player.tscn`: pointery vs Twój “skill”
W `player.tscn` masz `FunctionPointer` na obu rękach, laser włączony i dystans 6.0.   
To stoi w sprzeczności z fragmentem SKILL.md, gdzie rekomendujesz “FunctionGazePointer, krótki zasięg, laser niewidoczny”.

To nie jest “błąd”, ale **niespójność dokumentacji z kodem**. W audycie pracy inżynierskiej to ważne, bo reviewer będzie pytał “które jest prawdą?”.

---

## 7) UI + TTS + Hold-to-click — audyt

### 7.1. TTSManager (mocna strona projektu)
- Wybór polskiego głosu po language id oraz warmup to bardzo praktyczne.   
- Masz anti‑spam (powtórzenia tekstu w krótkim oknie) i dwell threshold (80 ms), co sensownie adresuje realny problem “latania pointerem po UI”.   
- Haptics na hover i click w TTSManager to świetny “kanał dotykowy” dla niewidomych.   

### 7.2. Poprawka projektowa: wydzielenie “Accessibility Layer”
Teraz accessibility jest:
- w `TTSManager` (setup_button, speak, haptic),   
- w UI skryptach (np. `main_menu_ui.gd` i `game_over_ui.gd` wołają setup_button i announce_panel),   
- i w mechanice gry (kompas, whoosh).   

Rekomendacja: zrób jedną konwencję:
- UI nigdy nie woła `DisplayServer`/tts bezpośrednio — tylko `Accessibility.announce(...)`
- `Accessibility` deleguje do TTS + Haptics + ewentualnie SFX.

To zmniejsza sprzężenia (a w pracy inżynierskiej daje czytelny diagram modułów).

### 7.3. HoldButton (drobne ryzyka)
`HoldButton` jest oznaczony `@tool`. To znaczy, że może się uruchamiać w edytorze (nawet jeśli `_process` sprawdza `Engine.is_editor_hint()`).   
Rekomendacja: usuń `@tool` z runtime‑komponentów UI, chyba że realnie potrzebujesz zachowania w edytorze.

---

## 8) Ocena SKILL.md (merytoryka + korekty)

### Co jest bardzo wartościowe
- Silny nacisk na **samowystarczalne sceny** + `change_scene_to_packed` + async load jest zgodny z tym, co faktycznie masz w projekcie.   
- Wzorzec “player w grupie `player`” jest spójny z `player.tscn` (Player ma group).   
- Haptyka przez `trigger_haptic_pulse` i akcję `haptic` jest zgodna z Twoją action mapą.   
- Pułapki z `NavigationAgent3D` (desired distances) — wdrożone w `ballora.gd`.   

### Co wymaga poprawy / uaktualnienia (żeby skill nie kłamał)
1) **“Najczęstszy błąd: `or true`”** — skill to opisuje, ale w branchu `audit` ten błąd nadal istnieje w co najmniej dwóch miejscach. W SKILL.md dopisałbym zasadę “grep na `or true` przed commitem” i potraktował to jako *quality gate*.   

2) **Pointery**: SKILL.md sugeruje `FunctionGazePointer`, ale projekt używa `FunctionPointer` z laserem i dystansem 6.0. Albo zmień implementację, albo zmień skill, bo inaczej agent AI (i Ty) będziecie się nawzajem “rozjeżdżać” na założeniach.   

3) **Audio dB “nigdy powyżej 5 dB”**: w scenach wrogów masz +8 dB (Marionette) i ~+15 dB (Foxy). Jeśli to świadome (np. testy), dopisz w skillu wyjątek: *“Poziomy w scenach są tymczasowe; docelowo miks w busach”* — albo po prostu ujednolić sceny.   

4) **Proces vs physics**: skill mówi “AI w `_physics_process`”, a `Marionette` jest w `_process`. Tu akurat masz sensowny powód (logika stricte “czasowa”), ale w VR to właśnie argument za `_physics_process`. W skillu doprecyzuj: *“Jeśli mechanika ma progi czasowe/reakcji — preferuj physics tick albo stały timestep.”*   

5) **Sekcja o formatach audio**: zamiast stanowczego “X jest zawsze lepsze”, lepiej odwołać się do dokumentacji importu audio w Godot 4.7 i opisać zasadę doboru formatu + import settings.   

---

## 9) Lista zaleceń (priorytety)

### P0 (napraw od razu)
- Usunąć `or true` z `SceneLoader` i `Foxy` + dodać reset `is_loading` w fail path.   
- Ujednolicić `game_map.tscn`: albo instancjonujesz Balorę i Foxy’ego, albo wycinasz martwe ext_resource (żeby scena nie wprowadzała w błąd).   

### P1 (ważne dla jakości VR i obrony pracy)
- Przenieść `Marionette` na stały tick (`_physics_process` lub stały timestep).   
- Zrobić “miks w busach” i zejść z ekstremalnych `volume_db` w scenach wrogów.   

### P2 (dług techniczny / utrzymanie)
- Usunąć `@tool` z runtime skryptów UI i scen, jeśli nie jest konieczne (np. `HoldButton`).   
- Wydzielić warstwę `Accessibility` (TTS + haptics + zasady UI).   

---

Jeśli potraktujesz ten branch `audit` jako materiał stricte “pod obronę”, to dwie rzeczy dadzą Ci największy zwrot:
1) uszczelnienie `SceneLoader` (P0) + konsekwentne usunięcie `or true`,  
2) ujednolicenie timingu AI (Marionette) i miksu audio (bus‑based).

To są też elementy, które najłatwiej obronić przed komisją: deterministyczna symulacja + kontrola komfortu VR + spójna architektura modułów.

W Node'zie Player używany jest Hand Collision który daje warning: Collision hand scenes are deprecated, use collistion node script directly.
