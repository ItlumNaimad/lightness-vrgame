# Przewodnik konfiguracji i automatyzacji Antigravity w Lightness VR

Niniejszy dokument opisuje, jak w pełni wykorzystać potencjał środowiska **Antigravity** (IDE, CLI oraz asynchronicznego Agenta) na systemie **Windows 10 LTSC** w celu maksymalnego zautomatyzowania i usprawnienia prac nad projektem gry VR w silniku **Godot Engine 4.x**.

---

## 1. Tworzenie własnych "Skills" (Zdolności agenta)
Mechanizm **Skills** w Antigravity pozwala wyposażyć agenta AI w trwałą, specjalistyczną wiedzę. Zapobiega to konieczności każdorazowego tłumaczenia reguł projektu w nowej konwersacji.

Możesz stworzyć dedykowaną wtyczkę developerską **Godot VR** bezpośrednio w katalogu konfiguracji Antigravity:
`C:\Users\naimad\.gemini\config\plugins\`

### Rekomendowana struktura wtyczki:
```text
godot-vr-plugin/
├── plugin.json
└── skills/
    ├── SKILL.md
    └── references/
        ├── scene_management.md
        └── xr_tools_fade.md
```

### Konfiguracja `plugin.json`:
```json
{
  "name": "godot-vr-plugin",
  "version": "1.0.0",
  "description": "Zbiór zasad, wzorców projektowych i dokumentacji dla silnika Godot 4.x oraz Godot XR Tools",
  "author": {
    "name": "Naimad VR Developer"
  },
  "license": "MIT",
  "keywords": [
    "godot",
    "gdscript",
    "vr",
    "openxr",
    "xr-tools"
  ]
}
```

### Konfiguracja `skills/SKILL.md`:
Plik rozpoczyna się od nagłówka YAML frontmatter, który informuje system, kiedy automatycznie załadować tę zdolność do kontekstu agenta:
```markdown
---
name: godot-vr-development
description: "Aktywuj tę zdolność, gdy użytkownik pracuje nad projektem w silniku Godot 4, pisze skrypty GDScript lub konfiguruje wtyczkę godot-xr-tools."
---

# Środowisko Godot 4 VR & XR Tools - Zbiór Zasad

## 1. Architektura Scen w projekcie "Lightness"
- **Zasada:** Nie używamy starego podejścia "Staging". Zmiana scen odbywa się przez `SceneLoader.load_scene(path)`.
- **Inicjalizacja:** Każda mapa ma własną instancję `StartXR`, `Player` oraz `Fade`.
- **Wyszukiwanie Gracza:** W skryptach wrogów lub map szukamy głowy gracza za pomocą:
  ```gdscript
  var player_root = get_tree().get_first_node_in_group("player")
  var camera = player_root.get_node_or_null("XROrigin3D/XRCamera3D")
  ```

## 2. Dobre praktyki GDScript (Godot 4.x)
- Używaj `@onready` do pobierania referencji węzłów.
- Zapobiegaj awariom typu `null instance` – zawsze weryfikuj istnienie węzła przed przypisaniem wartości, np. `if timer_label: timer_label.text = ...`.
- Konwersje typów: rzutuj jawnie floaty na int, by unikać ostrzeżeń NARROWING_CONVERSION, np. `var minutes: int = int(total_seconds / 60.0)`.

## 3. Dokumentacja wtyczki XR Tools
Przejdź do plików referencyjnych w celu uzyskania szczegółowych informacji:
- Szczegóły dotyczące wygaszania ekranu: `references/xr_tools_fade.md`
- Przejścia i ładowanie wątkowe: `references/scene_management.md`
```

---

## 2. Wykorzystanie MCP (Model Context Protocol)
**MCP** to otwarty standard umożliwiający bezpieczną integrację agentów AI z zewnętrznymi narzędziami, bazami danych, systemami plików i zewnętrznymi API.

### Sposoby wdrożenia w Lightness VR:
1. **Dostęp do oficjalnego API Godota online:** Możesz podłączyć serwer MCP typu *web-search* (np. Brave Search MCP lub Puppeteer MCP), co pozwoli agentowi na żywo przeszukiwać oficjalną dokumentację Godota (`docs.godotengine.org`) w poszukiwaniu zmian w wersjach 4.x.
2. **Serwer MCP plików i wyszukiwania:** Możesz skonfigurować lokalny serwer MCP, który indeksuje Twoje repozytorium i pozwala na błyskawiczne semantyczne wyszukiwanie powiązań w plikach `.gd`, `.tscn` i `.tres`.
3. **Konfiguracja w Antigravity:** Serwery MCP konfiguruje się w plikach ustawień Twojego klienta Antigravity. Serwery oparte na Node.js lub Pythonie są uruchamiane w tle jako procesy komunikujące się przez standardowe wejście/wyjście (stdio).

---

## 3. Integracja dokumentacji Godota oraz `godot-xr-tools`
Najlepszym i najszybszym sposobem na udostępnienie agentowi dokumentacji silnika i wtyczek bez wychodzenia z kontekstu jest **stworzenie lokalnej bazy wiedzy wewnątrz repozytorium**.

### Jak to zrobić?
1. **Lokalna baza wiedzy w folderze projektu:**
   * W folderze projektu utwórz dedykowany katalog dla dokumentacji (np. `gameDoc/docs/`).
   * Umieść tam pliki markdown (`.md`) skopiowane bezpośrednio z repozytorium [Godot XR Tools na GitHubie](https://github.com/GodotVR/godot-xr-tools).
2. **Analiza kodu dodatków:**
   * Ponieważ cała wtyczka `addons/godot-xr-tools` znajduje się w Twoim projekcie, agent potrafi bezpośrednio czytać i analizować jej kod źródłowy za pomocą narzędzi `view_file` i `grep_search`. Gdy masz wątpliwości jak działa dany komponent, po prostu wskaż plik źródłowy wtyczki.
3. **Tworzenie zbiorczych ściąg API:**
   * Możesz stworzyć zbiorczy plik referencyjny `gameDoc/XR_Tools_Reference.md` z sygnaturami najważniejszych funkcji oraz opisem zachowań komponentów takich jak `XRToolsFade`, `XRToolsSceneBase` czy `PlayerBody`.

---

## 4. Automatyzacja Pracy i Asynchroniczność (CLI & IDE)
Dzięki połączeniu Antigravity CLI oraz IDE, możesz zautomatyzować powtarzalne procesy developerskie:

* **Asynchroniczna praca z celami (`/goal`):**
  Zamiast ręcznie akceptować każdą zmianę, możesz wpisać komendę `/goal` w czacie, przełączając agenta w tryb autonomiczny. Agent samodzielnie:
  1. Zanalizuje problem i zaprojektuje rozwiązanie.
  2. Zaimplementuje kompletne moduły (np. całą sztuczną inteligencję wrogów).
  3. Przetestuje poprawność i dokona niezbędnych poprawek bez angażowania Twojego czasu.
* **Harmonogramowanie i automatyczne audyty (`/schedule`):**
  Możesz zaprogramować agenta, aby wykonywał okresowe zadania (np. co godzinę lub po każdej większej edycji kodu):
  * **Automatyczny linting:** Integracja z linterem GDScript (`gdlint`) przez uruchamianie skryptów PowerShell w tle w celu wykrywania i raportowania ostrzeżeń o stylu kodu.
  * **Audyt struktury scen VR:** Agent może okresowo weryfikować, czy nowo dodane sceny zachowują właściwy zestaw węzłów i poprawnie skonfigurowane grupy (np. grupa `player`).
