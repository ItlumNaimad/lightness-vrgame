# DESIGN.md — Lightness VR Design System & Screen Specifications

## 1. Executive Summary & Product Vision

**Lightness VR** is an immersive audio-first VR survival horror game developed in Godot Engine 4.x with OpenXR and Godot XR Tools. 
The core philosophy is **100% Blind & Low-Vision Accessibility (Universal Design)** combined with **Atmospheric Diegetic Horror**:
- **Visual Presentation**: While sighted players and spectators receive a sleek, atmospheric, high-contrast, minimalist UI projected in 3D space (`Viewport2DIn3D`), the interface is engineered from the ground up to provide equal auditory and haptic feedback.
- **VR Spatial Constraints**: UI elements exist as diegetic or spatial canvases positioned within the comfortable reach and field-of-view of the player (1.0m–1.8m distance, 0.15m physical touch distance).
- **Aesthetic Direction**: *Abyssal Monochrome & Phosphor Amber/Crimson*. Deep pitch blacks (`#050508`), frosted dark glass panels (`rgba(15, 17, 23, 0.85)`), high-visibility phosphor green/amber accents (`#00FFA3`, `#FFB800`), alert crimson (`#FF3366`), and ultra-crisp sans-serif typography.

---

## 2. Design System & Visual Tokens

### 2.1 Color Palette

| Token Name | Hex / RGBA | Role / Usage |
| :--- | :--- | :--- |
| **`bg-void`** | `#030305` | Deepest background, VR skybox, fade-to-black baseline |
| **`bg-surface-glass`** | `rgba(14, 18, 26, 0.88)` | Floating VR panel background with backdrop-blur |
| **`bg-surface-card`** | `rgba(24, 30, 44, 0.90)` | Inner card containers, active selection frames |
| **`border-subtle`** | `rgba(255, 255, 255, 0.12)` | Inactive component outlines (2px solid) |
| **`border-focus`** | `#00FFA3` | Active VR pointer / touch hover outline (4px glow) |
| **`text-primary`** | `#FFFFFF` | Primary headers, high-contrast labels (WCAG AAA) |
| **`text-secondary`** | `#A0AEC0` | Subtitles, helper text, descriptive notes |
| **`text-muted`** | `#5A6578` | Inactive status, subtle metadata |
| **`accent-phosphor`** | `#00FFA3` | Confirmation, safety, active toggles, hold-meter |
| **`accent-amber`** | `#FFB800` | Warning, caution cues, sound compass indicators |
| **`accent-crimson`** | `#FF3366` | Critical danger, jumpscare warnings, hostile alert |
| **`accent-cyan`** | `#00D2FF` | Audio settings, TTS indicator, info markers |

### 2.2 Typography

- **Primary Font**: *Outfit* or *Inter* (Clean geometric sans-serif with high x-height for VR legibility).
- **Monospace Font**: *JetBrains Mono* / *Fira Code* (Timers, statistics, VR telemetry).
- **Scale Hierarchy**:
  - `Display / VR Hero`: `48px – 64px` (Bold, Letter-spacing +1.5px)
  - `Header 1`: `32px – 40px` (Semi-Bold)
  - `Header 2 / Section`: `24px – 28px` (Medium)
  - `Body / Button Text`: `18px – 22px` (Medium, High readability at 1m in VR)
  - `Caption / Badge`: `14px – 16px` (Uppercase, Semi-Bold)

### 2.3 Spatial & Interaction Metrics (VR Physics)

- **Touch & Gaze Hold Time**: `0.7s` (Primary actions), `1.0s` (Destructive/Exit actions).
- **Button Dimensions**: Minimum `320px × 72px` (large target area for VR laser pointer and physical hand collision).
- **Hold Progress Ring**: Animated SVG circle / shader ring filling from `0%` to `100%` on touch/hover.
- **Haptic Feedback Profile**:
  - Hover / Focus: Soft tick (Frequency 40Hz, Amp 0.2, Duration 20ms)
  - Hold Tick: Escalating pulse frequency (60Hz → 140Hz)
  - Confirm / Click: Solid click (Frequency 120Hz, Amp 0.8, Duration 80ms)

---

## 3. Screen Specifications & Wireframe Layouts

### 3.1 Main Menu Screen (`scenes/main_menu.tscn`)

**Purpose**: Player onboarding, starting game sessions, customizing accessibility & audio profiles, and reading controller guides.

#### Layout Structure:
```
+-------------------------------------------------------------------------------+
|                                LIGHTNESS VR                                   |
|                      [ Audio-First Survival Horror ]                          |
+-------------------------------------------------------------------------------+
|  +---------------------------------+  +------------------------------------+  |
|  |           PRIMARY MENU          |  |         SESSION TELEMETRY          |  |
|  |                                 |  |                                    |  |
|  |  [ > ROZPOCZNIJ GRĘ (START) ]   |  |   Najlepszy Czas:    03:45         |  |
|  |     (Hold 0.7s to Play)         |  |   Ostatnia Próba:    01:20         |  |
|  |                                 |  |   Odparci Wrogowie:  14            |  |
|  |  [ ⚙ USTAWIENIA (SETTINGS) ]    |  +------------------------------------+  |
|  |                                 |  |         ACCESSIBILITY STATUS       |  |
|  |  [ 🎮 STEROWANIE I PORADNIK ]   |  |   TTS Lektor:       [ WŁĄCZONY ]   |  |
|  |                                 |  |   Kompas Dźwiękowy: [ WŁĄCZONY ]   |  |
|  |  [ ✕ WYJŚCIE Z GRY ]            |  |   Tryb Dłoni:       [ FIZYCZNY ]   |  |
|  +---------------------------------+  +------------------------------------+  |
+-------------------------------------------------------------------------------+
|  Status: Gotowy do gry • Naciśnij lub dotknij przycisk kontrolerem VR         |
+-------------------------------------------------------------------------------+
```

#### Interactive Elements:
1. **`btn_start_game`**: Triggers scene transition via `SceneLoader.load_scene("res://scenes/game_map.tscn")` with fade-out.
2. **`btn_settings`**: Opens overlay with sliders for Master Volume, Ambient Distortion Intensity, TTS Voice Speed, and Sound Compass pitch scale.
3. **`btn_how_to_play`**: Opens modal with controller infographics and enemy behavior guides.
4. **`btn_exit`**: Exits application.

---

### 3.2 In-Game Pause & Settings Overlay (`scenes/pause_menu.tscn`)

**Purpose**: Pausing active simulation, adjusting accessibility on the fly, audio re-calibration, resuming or restarting.

#### Layout Structure:
```
+-------------------------------------------------------------------------------+
|                                    PAUZA                                      |
|                            Czas gry: 01:42                                    |
+-------------------------------------------------------------------------------+
|  [ ▶ WZNÓW GRĘ (RESUME) ]                                                     |
|  [ ⟳ RESTARTUJ PRÓBĘ (RESTART) ]                                              |
|                                                                               |
|  ---------------------------------------------------------------------------  |
|  DŹWIĘK I UŁATWIENIA DOSTĘPU:                                                 |
|                                                                               |
|  Głośność Główna:      [ =======o=== ] 80%                                    |
|  Głośność Efektu Whoosh:[ =====o===== ] 3.0 dB                                 |
|  Kompas Dźwiękowy:     (•) WŁĄCZONY   ( ) WYŁĄCZONY                           |
|  Syntezator Lektora:   (•) WŁĄCZONY   ( ) WYŁĄCZONY                           |
|  ---------------------------------------------------------------------------  |
|                                                                               |
|  [ ⌂ POWRÓT DO MENU GŁÓWNEGO ]                                                |
+-------------------------------------------------------------------------------+
```

---

### 3.3 Loading & Transition Screen (`scenes/loading_screen.tscn`)

**Purpose**: High-comfort VR transition during asynchronous scene loading.

#### Layout & Behavior:
- **Visual**: 100% `#000000` black background with smooth `XRToolsFade` tweening.
- **Center Element**: Minimalist pulsing phosphor ring (`#00FFA3`) with ambient breath animation (period 1.5s).
- **Subtext**: `"Wczytywanie koszmaru..."` (Font size 22px, alpha oscillating 0.4 - 0.9).
- **Accessibility Audio**: Soft periodic sonar ping (`Broken bell.ogg` at -18dB) every 1.2s to confirm responsiveness, accompanied by TTS statement: *"Ładowanie mapy gry"*.

---

### 3.4 Game Over & Survival Summary Screen (`scenes/game_over.tscn`)

**Purpose**: Providing closure after a jumpscare, delivering score telemetry, and offering instant retry or exit.

#### Layout Structure:
```
+-------------------------------------------------------------------------------+
|                                  KONIEC GRY                                   |
|                             [ PRZEŻYŁEŚ: 02:47 ]                              |
+-------------------------------------------------------------------------------+
|                                                                               |
|   PRZEBYTE KROKI:        184 kroki (Hałas: 34%)                               |
|   ODPARCIE MARIONETTE:   3 udane obrony                                       |
|   ZABLOKOWANE SZARŻE:    1 udany blok ręką                                    |
|   POWÓD PORAŻKI:         Balora — Wejście w strefę krytyczną                   |
|                                                                               |
+-------------------------------------------------------------------------------+
|                                                                               |
|      [ ⟳ ZAGRAJ PONOWNIE (RETRY) ]          [ ⌂ MENU GŁÓWNE (MENU) ]          |
|          (Hold 0.7s to Play)                   (Hold 0.7s to Exit)            |
|                                                                               |
+-------------------------------------------------------------------------------+
```

---

## 4. Visual Assets & Infographics Specifications

### 4.1 VR Controller Layout Infographic (Accessibility & Control Guide)

**Format**: 16:9 High-Resolution Vector Graphic (SVG / PNG `1920×1080` and `3840×2160`).

```
+-------------------------------------------------------------------------------+
|                       SCHEMAT STEROWANIA — LIGHTNESS VR                       |
+-------------------------------------------------------------------------------+
|                                                                               |
|      [ LEWY KONTROLER ]                           [ PRAWY KONTROLER ]         |
|                                                                               |
|   (L-Stick Tilt):                               (R-Stick Tilt):               |
|   -> Obrót Skokowy (Snap Turn)                  -> Płynny Ruch (Locomotion)   |
|   -> Dźwięk Whoosh (Lewo: Niski, Prawo: Wysoki) -> W kierunku kontrolera      |
|   -> Ping Kompasu Północ/Południe                                             |
|                                                 (R-Stick Click):              |
|   (L-Stick Click):                              -> Cichy Krok / Skradanie     |
|   -> Sprint (Generuje Duży Hałas!)                                            |
|                                                 (Wystawienie Ręki / Blok):    |
|   (Dotknięcie Przycisków):                      -> Odepchnięcie Szarży Foxy   |
|   -> Fizyczne wciśnięcie (0.7s)                 -> Dotyk interfejsu (Touch)   |
|                                                                               |
+-------------------------------------------------------------------------------+
```

### 4.2 Enemy Threat Cards (Tactical Infographics)

#### Card 1: Balora (Patrol & Proximity)
- **Visual Icon**: Stylized music box ballerina silhouette surrounded by sound wave ripples.
- **Audio Cue**: Tinkling music box melody (`ballora.mp3`).
- **Rule**: Reaguje na **odległość**, a nie na hałas. Im bliżej jesteś, tym muzyka gra szybciej.
- **Counter**: Natychmiastowy odwrót i ucieczka sprintem poza promień detekcji.

#### Card 2: Foxy (Noise & Charge)
- **Visual Icon**: Mechanical predator silhouette with soundwave overload meter and shield icon.
- **Audio Cue**: Ciężkie metaliczne kroki (`foxy_walking.wav`) → Nagła cisza i sygnał alarmu (`nice-sfx.mp3`).
- **Rule**: Reaguje na **kumulatywny hałas** (sprint, kolizje ze ścianami).
- **Counter**: Zrób unik w bok LUB unieś i wyciągnij dłoń w stronę nadbiegającej szarży, by zablokować atak.

#### Card 3: Marionette (Spatial Whispers & Echolocation)
- **Visual Icon**: Ethereal porcelain mask with directional sound cones and eye-slash symbol.
- **Audio Cue**: Narastające szepty w uchu (`whispers.wav`) z efektem zbliżania (*crescendo*).
- **Rule**: Pojawia się na ścianach i szepcze do ucha, atakując przy patrzeniu lub gwałtownym ruchu.
- **Counter**: Zatrzymaj się w miejscu na okres łaski (4.0s) i odwróć głowę w przeciwną stronę od źródła szeptu.

---

## 5. Implementation Guide for Godot XR

1. **2D Canvas in 3D Space**:
   - Use `XRToolsViewport2DIn3D` for all menus.
   - Screen Size: `Vector2(1280, 720)` or `Vector2(1920, 1080)`.
   - Viewport Size in 3D: `Vector2(1.6, 0.9)` meters at `1.2m` height from player spawn.
2. **Button Interactions**:
   - Integrate with `FunctionGazePointer` configured with `distance = 0.15`, `click_on_hold = true`, `hold_time = 0.7`.
   - Animate `TextureProgressBar` or custom Shader circular meter around button icon on focus.
3. **Accessibility Integration**:
   - Connect `focus_entered` signals to Godot's `DisplayServer.tts_speak()` or audio cue playback to automatically voice the hovered button text.
