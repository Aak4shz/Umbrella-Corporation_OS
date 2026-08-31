---
name: plasma-qml-theming
description: >
  Advanced engineering guide for KDE Plasma 6 desktop theming, QML widget development,
  Kirigami UI components, Plasma Desktop Theme SVG authoring, KWin scripting, and Look-and-Feel packages.
  Use this skill whenever designing or modifying KDE Plasma themes, creating custom plasmoids (widgets),
  customizing application menus (Kickoff/Kicker), configuring SDDM/Lockscreen QML interfaces, or
  enforcing cross-toolkit (Qt/GTK) visual consistency.
---

# Plasma QML Theming & Desktop Engineering Skill

This skill provides comprehensive rules, code patterns, and architectural blueprints for developing world-class custom KDE Plasma 6 desktop experiences, Look-and-Feel packages, and cybernetic HUD interfaces.

---

## 1. KDE Plasma 6 Theming Matrix

A complete Plasma 6 theme consists of 6 interconnected visual layers:

| Layer | Filesystem Location | Description |
| :--- | :--- | :--- |
| **Global Look-and-Feel** | `/usr/share/plasma/look-and-feel/<id>/` | Controls splash screen, lock screen, default layout, and component bindings. |
| **Plasma Desktop Theme** | `/usr/share/plasma/desktoptheme/<id>/` | SVG-based panel, widget, tooltip, dialog, and menu styling. |
| **Color Scheme** | `/usr/share/color-schemes/<id>.colors` | Defines RGB palettes for windows, views, selections, and accents. |
| **Window Decoration** | `/usr/share/aurorae/themes/<id>/` | Titlebars, window borders, and control buttons (close, min, max). |
| **Icons & Cursors** | `/usr/share/icons/<id>/` | System icon pack (Papirus) and cursor theme (breeze_cursors). |
| **SDDM Greeter** | `/usr/share/sddm/themes/<id>/` | Display manager login interface (`Main.qml`). |

---

## 2. Red Queen Visual DNA & Color Science

Always adhere to the **60-30-10 Chromatic Balance**:
* **60% Dominant Canvas:** Deep Obsidian (`#0A0A0A`, `#0D0D0D`, `#121212`)
* **30% Structural Panels:** Translucent Dark Glass (`#181818`, 88%–92% opacity, 1.5px crimson borders `#CC0000`)
* **10% High-Energy Accents:** Laser Crimson & Neon Red (`#FF0000`, `#FF2222`, `#CC0000`)

---

## 3. QML & Kirigami Component Best Practices

### 3.1 Seamless Glassmorphism
```qml
Rectangle {
    color: "#121212"
    opacity: 0.90
    radius: 12
    border.color: "#cc0000"
    border.width: 1.5

    // Subtle laser glow accent
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: "transparent"
        border.color: "#ff3333"
        border.width: 1
        opacity: 0.35
    }
}
```

### 3.2 Vector SVGs Over Bitmap Graphics
* Always use native SVG vector assets (`.svg`) for UI icons with `sourceSize.width` and `sourceSize.height` defined.
* Prevents pixelation on HiDPI and 4K displays.

### 3.3 Dynamic Hardware-Independent Typography
* Primary Headers: `Transformers Movie` / `Blade Runner Movie Font`
* Telemetry / Status: `JetBrains Mono` / `UniNeue Bold`
* Time & HUD Counters: `CF Glitch City` (Uppercase digits)

---

## 4. KDE Plasma 6 Look-and-Feel Structure

```text
usr/share/plasma/look-and-feel/org.umbrella.redqueen.desktop/
├── metadata.json
└── contents/
    ├── defaults                # Default configs for kdeglobals, kwinrc, etc.
    ├── splash/
    │   ├── Splash.qml          # Post-login animated video/QML splash
    │   └── splash.mp4          # 1080p 60FPS video asset
    └── lockscreen/
        └── LockScreenUi.qml    # Screen locker UI component
```

---

## 5. Live Simulation Workflow
Before modifying system files, always create and run a standalone QML test harness:
```bash
qml6 scripts/preview-<component>.qml
```
Verify resolution adaptability, font fallbacks, and animation frame pacing.
