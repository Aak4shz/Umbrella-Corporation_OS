# Umbrella OS — Logo & Branding Migration Tracker (`list.md`)

> **Objective:** System ke primary branding (Login, Splash, Boot Splash, Terminal, Launcher) par se generic Biohazard symbol ko replace karke official **Red & White Umbrella Corporation Logo** lagana, jabki biological lore, wallpapers aur security warning accents ko preserve karna.

---

## 🎨 Source Assets Available
- [x] `assets/branding/umbrella-corporation-logo.svg` (300x300 Vector Graphic - Official 8-piece Umbrella)
- [x] `assets/branding/umbrella-corporation-logo.png` (633x595 High-Resolution Transparent PNG)
- [x] Symlinked to `assets/` for quick script referencing: `assets/umbrella-corporation-logo.png` & `.svg`

---

## 📋 Task Checklist

### Phase 1: Authentication & Desktop Splash (SDDM & Plasma)
- [ ] **Task 1.1: SDDM Login Screen (`umbrella-sddm`)**
  - **File:** `archiso/airootfs/usr/share/sddm/themes/umbrella-sddm/`
  - Action: Naye Umbrella logo PNG ko copy karna aur `Main.qml` mein `biohazard-logo.png` ki jagah Umbrella logo link karna.
  - Status: `PENDING`

- [ ] **Task 1.2: KDE Post-Login Splash Screen (`Splash.qml`)**
  - **File:** `archiso/airootfs/usr/share/plasma/look-and-feel/org.umbrella.redqueen.desktop/contents/splash/`
  - Action: `images/` directory mein Umbrella logo place karna aur `Splash.qml` mein pulsing logo ko Umbrella logo se link karna.
  - Status: `PENDING`

- [ ] **Task 1.3: Plasma Lockscreen UI (`LockScreenUi.qml`)**
  - **File:** `archiso/airootfs/usr/share/plasma/look-and-feel/org.umbrella.redqueen.desktop/contents/lockscreen/`
  - Action: Center user badge ko Umbrella logo se link karna, aur security subtext lore ko intact rakhna.
  - Status: `PENDING`

---

### Phase 2: Plymouth Boot Splash Animation
- [ ] **Task 2.1: Plymouth Base Logo Asset**
  - **File:** `archiso/airootfs/usr/share/plymouth/themes/umbrella-plymouth/logo.png`
  - Action: Current biohazard `logo.png` ko naye Umbrella logo se replace karna.
  - Status: `PENDING`

- [ ] **Task 2.2: 36-Frame Rotating Umbrella Spinner**
  - **File:** `archiso/airootfs/usr/share/plymouth/themes/umbrella-plymouth/spinner-0.png` to `spinner-35.png`
  - Action: New Umbrella emblem ko 10-degree increments mein rotate karke 36 smooth anti-aliased frames generate karna.
  - Status: `PENDING`

- [ ] **Task 2.3: Plymouth Boot Script & Label Alignment**
  - **File:** `archiso/airootfs/usr/share/plymouth/themes/umbrella-plymouth/umbrella-plymouth.script`
  - Action: Script labels aur comments ko "Umbrella Corporation Core Initialization" par align karna.
  - Status: `PENDING`

---

### Phase 3: Terminal & Desktop System Branding
- [x] **Task 3.1: Fastfetch Terminal ASCII Art**
  - **File:** `archiso/airootfs/etc/fastfetch/umbrella-logo.txt`
  - Action: Current Biohazard ASCII art ko official 8-piece Umbrella Corporation geometric ASCII art se replace karna.
  - Status: `COMPLETED` ✅

- [x] **Task 3.2: User Skeleton Fastfetch Sync**
  - **File:** `archiso/airootfs/etc/skel/.config/fastfetch/umbrella-logo.txt`
  - Action: Updated ASCII art ko `/etc/skel/` config ke saath synchronize karna.
  - Status: `COMPLETED` ✅

- [ ] **Task 3.3: Kickoff / Taskbar Start Button Icon**
  - **Files:**
    - `archiso/airootfs/usr/share/pixmaps/umbrella-logo.png`
    - `archiso/airootfs/usr/share/icons/umbrella-logo.png`
  - Action: Narrow horizontal banner ko clean 1:1 Umbrella Corporation emblem se replace karna taaki panel par Start button crisp dikhe.
  - Status: `PENDING`

- [ ] **Task 3.4: Plasma Desktop Theme Branding Widget**
  - **Files:**
    - `archiso/airootfs/usr/share/plasma/desktoptheme/RedQueen/widgets/branding.svg`
    - `archiso/airootfs/usr/share/plasma/desktoptheme/RedQueen/widgets/branding.svgz`
  - Action: RedQueen theme branding widget ke embedded graphic ko new Umbrella SVG se update karna.
  - Status: `PENDING`

---

### Phase 4: Developer Test & Preview Scripts
- [ ] **Task 4.1: Sync SDDM Preview Script**
  - **File:** `scripts/preview-login.qml`
  - Action: Preview card logo ko new Umbrella logo se link karna.
  - Status: `PENDING`

- [ ] **Task 4.2: Sync Lockscreen Preview Script**
  - **File:** `scripts/preview-lockscreen.qml`
  - Action: Lockscreen preview logo ko update karna.
  - Status: `PENDING`

- [ ] **Task 4.3: Sync Plymouth & Unified Preview Tool**
  - **Files:**
    - `scripts/preview-plymouth.qml`
    - `scripts/preview-all.qml`
    - `scripts/preview-all.sh`
  - Action: Rotating spinner frames aur preview asset links ko update karna.
  - Status: `PENDING`

---

### Phase 5: Verification & Lore Retention Check
- [ ] **Task 5.1: Biohazard Wallpapers Retention Audit**
  - **Files:** `BIohazard_logo.png`, `Umbrella_Cor_Biohazard.jpg`, `T-virus_wallpaper.jpg`, `Infected_Hand-zombie_wallpaper.png`
  - Action: Confirm karna ki biohazard wallpapers aur lore wallpapers safely available hain aur delete nahi huye.
  - Status: `PENDING`

- [ ] **Task 5.2: Live Visual Verification**
  - Action: `bash scripts/preview-all.sh` run karke sabhi previews (Plymouth, SDDM, Lockscreen, Desktop) ko visually verify karna.
  - Status: `PENDING`

---

## 📌 Progress Summary
- **Total Tasks:** 14
- **Completed:** 2
- **Pending:** 12
- **Current Active Task:** Fastfetch (Tasks 3.1 & 3.2 Completed)
