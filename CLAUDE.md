# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**Lightness VR** — an engineering-thesis ("Inżynierka") survival horror VR game built in **Godot 4.6** (Mobile renderer) with **GDScript** and **OpenXR**. The defining design constraint: the game must be **fully playable by blind players**. Visual stimuli give little or no gameplay advantage; everything is driven by 3D spatial audio and haptics. Much of the code and all design docs are in **Polish** — match that language in comments and commit messages.

There is no build/lint/test tooling. Development happens in the Godot editor:
- Open the project in Godot 4.6 (no .NET build needed — pure GDScript).
- Main scene / autostart is `scenes/main_menu.tscn`; OpenXR starts automatically.
- Requires an OpenXR headset to actually play (e.g. Meta Quest via Quest Link / SteamVR). Logic can be inspected without hardware but not fully exercised.

## Architecture

### Scene lifecycle — self-contained scenes + SceneLoader (critical)
The project deliberately has **no persistent `Main`/Staging node**. Every playable scene is 100% self-sufficient and embeds its own `StartXR`, `Player`, and `Fade` instances. This guarantees a clean physics reset on every map load — essential for VR stability and avoiding locomotion sickness.

Scene changes go exclusively through the `SceneLoader` autoload (`scripts/scene_loader.gd`), never `change_scene_to_*` directly:
1. `XRToolsFade` fades to black,
2. background load via `ResourceLoader.load_threaded_request` (keeps the headset frame alive),
3. `change_scene_to_packed` swaps the whole environment,
4. resets `JumpscareHelper.is_jumpscaring_global`, then fades back in.

`SceneLoader.last_survival_time` persists the run's score across the full scene swap.

### Autoloads (see `project.godot [autoload]`)
- `SceneLoader` — threaded scene transitions (above).
- `EventBus` (`scripts/event_bus.gd`) — global signal `noise_emitted(global_pos, noise_level)`. The single decoupling channel between player noise and enemies that react to it.
- `XRToolsUserSettings`, `XRToolsRumbleManager` — from the vendored `godot-xr-tools` addon.

### Finding the player from enemy/game scripts
The player camera is not at a fixed path. Always resolve it via the `"player"` group:
```gdscript
var player_root = get_tree().get_first_node_in_group("player")
var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
```
Enemies are in the `"enemy"` group (used by `game_map.gd` for the distance-based audio distortion effect).

### Enemies (`scripts/*.gd` + matching `scenes/*.tscn`)
Each enemy encodes a distinct audio-first mechanic. Full behavioral spec lives in `.agents/AGENTS.md` — read it before changing AI:
- **Balora** (`ballora.gd`) — patrols via `NavigationAgent3D`, reacts to **proximity**, chases when the player lingers in its alert/critical zone.
- **Foxy** (`foxy.gd`) — state machine (`IDLE → LISTENING → PREPARING_CHARGE → CHARGING → JUMPSCARE`) reacting to **cumulative player noise** from `EventBus.noise_emitted`. Goes silent, then charges in a straight line; countered by dodging or a controller "block" (`BlockTrigger` Area3D).
- **Marionette** (`marionette.gd`) — proximity whispers the player must wave away; escalates over survival time.

All jumpscares funnel through `JumpscareHelper.execute()` (`jumpscare_helper.gd`), a static helper that stops the timer, reparents the jumpscare audio (and optional meshes) to the player camera, triggers controller haptics, then returns to the main menu. `JumpscareHelper.is_jumpscaring_global` is a static one-shot guard — respect it.

### Player audio (`player_audio_manager.gd`)
Translates player motion into sound and noise events: emits `EventBus.noise_emitted` on footsteps (louder/`2.5` when sprinting vs `1.0` walking), and produces the "sound compass" ping + turn whoosh on snap-turns. This is the primary accessibility feedback loop — changes here directly affect blind playability.

### Survival loop (`game_map.gd`, extends `XRToolsSceneBase`)
Runs the survival timer, bakes the `NavigationRegion3D` navmesh deferred at startup, fires a milestone gong every 10s (`next_milestone`, drives AI escalation), and applies the **distortion effect**: ambient `pitch_scale` is lerped down as the nearest enemy approaches (subliminal proximity warning). Guarded by `Engine.is_editor_hint()` since the script is `@tool`.

## Conventions
- Use `@onready` for node references; explicitly cast numeric types (avoid `NARROWING_CONVERSION`); null-check nodes before use.
- New sounds require attribution in `README.md` under `## Sounds:` (licensing matters for the thesis).
- `.agents/AGENTS.md` is the authoritative design brief (mechanics, audio/haptic feedback requirements). Keep it in sync when mechanics change.
- `godot-xr-tools` under `addons/` is vendored — treat as third-party; customize via the game scenes rather than editing the addon where possible.
