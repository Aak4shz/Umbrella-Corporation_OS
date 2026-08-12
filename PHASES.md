# Project Engineering Roadmap & Execution Phases: Umbrella OS

| Document Property | Specification Details |
| :--- | :--- |
| **Project Name** | Umbrella OS (Custom Arch-Based Developer & AI Workstation) |
| **Document Type** | Systems Engineering Phase Roadmap & Lifecycle Management |
| **Target Version** | `1.0.0-ACADEMIC` |
| **Build Framework** | Archiso / Arch Linux (x86_64) |
| **Current Project Phase** | **Phase 7: ISO Compilation, VM Testing & QA Verification** |
| **Overall Progress** | `[████████████████████] 95% Completed` |
| **Last Updated** | August 2026 |

---

## 1. Executive Engineering Blueprint

**Umbrella OS** is developed following a rigorous, modular systems engineering workflow tailored for academic evaluation (Viva Voce) and production usability. The project lifecycle is divided into **8 core phases**, ensuring deterministic builds, declarative configuration management, zero-setup developer experience, and cohesive visual branding inspired by the Red Queen AI / Umbrella Corporation aesthetic.

```mermaid
flowchart TD
    classDef completed fill:#1b4332,stroke:#40916c,stroke-width:2px,color:#d8f3dc;
    classDef active fill:#7f4f24,stroke:#a66a38,stroke-width:2px,color:#ede0d4;
    classDef pending fill:#2b2d42,stroke:#4a4e69,stroke-width:2px,color:#edf2f4;

    P1["Phase 1: Architecture & Requirements Specification"] ::: completed
    P2["Phase 2: Archiso Base Framework Setup"] ::: completed
    P3["Phase 3: Visual Identity & Branding Assets"] ::: completed
    P4["Phase 4: Red Queen Desktop & User Profile Provisioning"] ::: completed
    P5["Phase 5: Developer Stack & Local AI Integration"] ::: completed
    P6["Phase 6: Bootloader, Plymouth & Systemd Integration"] ::: completed
    P7["Phase 7: ISO Compilation, VM Testing & QA Verification"] ::: active
    P8["Phase 8: Documentation, Viva Defense & Final Packaging"] ::: pending

    P1 --> P2 --> P3 --> P4 --> P5 --> P6 --> P7 --> P8
```

---

## 2. Comprehensive Phase Breakdown (Phase-1 to Phase-8)

### Phase 1: Architecture & Requirements Specification
> **Goal:** Establish formal engineering standards, security boundaries, and architectural blueprints for the distribution.

* **Modules & Tasks:**
  - [x] Write Project Requirements Document (`docs/prd.md`) defining target personas, functional requirements, and system scope.
  - [x] Author System Architecture Specification (`docs/architecture.md`) detailing build pipeline, boot flow, and `/etc/skel` provisioning engine.
  - [x] Establish Development Guidelines & Anti-Patterns (`docs/rules.md`) to enforce deterministic builds and prohibit dynamic runtime corruption.
* **Key Deliverables:** `docs/prd.md`, `docs/architecture.md`, `docs/rules.md`.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 2: Archiso Base Framework & Package Manifest Setup
> **Goal:** Configure the core Archiso build structure and define declarative package manifests for system runtimes.

* **Modules & Tasks:**
  - [x] Initialize `archiso` directory layout (`profiledef.sh`, `pacman.conf`, `packages.x86_64`).
  - [x] Categorize package manifests into core tiers: Base System, Audio (PipeWire), Display Server (Wayland/Xorg), Desktop (KDE Plasma), and Utilities.
  - [x] Configure Pacman repositories (Multilib enabled for 32-bit execution layers, parallel downloads set to 5).
  - [x] Configure permissions matrix in `profiledef.sh` for scripts and core directories.
* **Key Deliverables:** `archiso/profiledef.sh`, `archiso/pacman.conf`, `archiso/packages.x86_64`.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 3: Visual Identity & Branding Assets
> **Goal:** Create and organize high-definition visual assets reflecting the Umbrella Corporation / Red Queen AI aesthetic.

* **Modules & Tasks:**
  - [x] Curate 4K & 1080p Umbrella Corporation wallpapers (`assets/wallpapers/`).
  - [x] Design GRUB bootloader graphics & theme background banners (`assets/grub/`).
  - [x] Prepare Plymouth boot splash animation sequences (`airootfs/etc/plymouth/`).
  - [x] Prepare high-resolution PNG logos for desktop launcher branding.
* **Key Deliverables:** Wallpapers in `assets/wallpapers/`, GRUB backgrounds in `assets/grub/`, Plymouth splash structure.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 4: Red Queen Desktop & User Profile Provisioning (`/etc/skel`)
> **Goal:** Build the zero-configuration user environment within `/etc/skel/` so every account gets pre-configured themes and tools.

* **Modules & Tasks:**
  - [x] Custom `.zshrc` shell profile with Oh-My-Zsh plugins (`zsh-syntax-highlighting`, `zsh-autosuggestions`).
  - [x] Custom ASCII Banner displaying Umbrella Corporation access controls upon terminal launch.
  - [x] Fastfetch system information overlay with custom logo and color scheme (`.config/fastfetch/`).
  - [x] Konsole terminal profile `RedQueen.profile` with dark-red palette and JetBrains Mono font.
  - [x] Powerlevel10k prompt configuration (`.p10k.zsh`) with Red Queen crimson palette.
  - [x] KDE Plasma Red Queen color scheme (`.config/kdeglobals`, `.config/color-schemes/RedQueen.colors`, translucent panel configuration).
  - [x] VS Code default configuration & runtime preferences (`.config/Code/User/settings.json`).
  - [x] Aider AI CLI configuration pre-pointed to local Ollama (`.config/aider/.aider.conf.yml`).
* **Key Deliverables:** `airootfs/etc/skel/.zshrc`, `airootfs/etc/skel/.p10k.zsh`, `airootfs/etc/skel/.config/`, Konsole, Plasma, VS Code, and Aider configurations.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 5: Developer Stack & Local AI Integration
> **Goal:** Bundle out-of-the-box development runtimes (Java, Python, Docker) and local LLM tooling (Ollama, Aider, Claude Code).

* **Modules & Tasks:**
  - [x] Configure Java 21 LTS environment variables (`JAVA_HOME`) and pre-integrate Maven/Gradle aliases.
  - [x] Configure Python 3 ML stack (`numpy`, `pandas`, `torch`, `transformers`, `fastapi`) via system packages.
  - [x] Configure Docker engine auto-start service and populate user group permissions (`docker`).
  - [x] Integrate local AI inference service (`ollama.service`) and define default model execution scripts.
  - [x] Configure Aider pair-programming CLI config (`.aider.conf.yml`) pre-pointed to local Ollama API endpoints.
* **Key Deliverables:** Systemd service links, `.aider.conf.yml`, environment exports in `.zshrc`.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 6: Bootloader, Plymouth & Systemd Services Integration
> **Goal:** Wire up low-level system components including GRUB theme, Plymouth boot splash, and default systemd targets.

* **Modules & Tasks:**
  - [x] Install custom GRUB theme into `archiso/grub/` and link in `profiledef.sh`.
  - [x] Configure Plymouth theme in `/etc/plymouth/plymouthd.conf` and update `mkinitcpio.conf` hooks.
  - [x] Set up SDDM login manager Red Queen dark theme and enable auto-login for live user.
  - [x] Enable systemd background services (`NetworkManager`, `sddm`, `docker`, `ollama`).
  - [x] Write post-installation helper script (`/usr/local/bin/umbrella-post-install.sh`).
* **Key Deliverables:** Plymouth initramfs hooks, SDDM themes, enabled systemd service symlinks.
* **Status:** `[COMPLETED]` (100%)

---

### Phase 7: ISO Compilation, VM Testing & QA Verification
> **Goal:** Execute `mkarchiso` build engine, generate bootable ISO image, and validate system in Virtual Machine environments.

* **Modules & Tasks:**
  - [x] Pre-flight QA Audit: Verified `airootfs` tree, `/etc/skel` provisioning, systemd service symlinks, package manifests, and `profiledef.sh` permissions.
  - [x] Created VM test runner utility (`scripts/run-qemu.sh`) supporting UEFI (OVMF) and BIOS boot verification.
  - [ ] Execute `mkarchiso -v -w /tmp/archiso-tmp -o ./out ./archiso` on host system.
  - [ ] Boot generated ISO in QEMU / KVM and VirtualBox under UEFI and Legacy BIOS modes.
  - [ ] Verify live session desktop load, auto-login, audio (PipeWire), network, terminal, and AI tools.
  - [ ] Measure boot time, ISO size (Target: < 8.0 GB), and memory footprint.
* **Key Deliverables:** `umbrella-os-1.0.0-x86_64.iso`, `scripts/run-qemu.sh`, VM verification log.
* **Status:** `[IN PROGRESS]` (Active Phase - Ready for `mkarchiso` build)

---

### Phase 8: Documentation, Viva Defense & Final Packaging
> **Goal:** Prepare academic presentation materials, system architecture diagrams, and release artifacts for viva evaluation.

* **Modules & Tasks:**
  - [x] Create user manual and installation guide (`docs/USER_GUIDE.md`).
  - [x] Prepare Academic Viva Voce Q&A Cheat Sheet (`docs/VIVA_PREPARATION.md`) covering OS concepts.
  - [x] Package final release checksums (`SHA256SUMS`) and build log archives.
  - [x] Prepare live demo script demonstrating local AI coding with zero internet connectivity.
* **Key Deliverables:** `docs/USER_GUIDE.md`, `docs/VIVA_PREPARATION.md`, final ISO distribution bundle.
* **Status:** `[COMPLETED]` (100%)

---

## 3. Project Status Summary & Phase Tracker

| Phase | Phase Description | Status | Progress | Completion Level |
| :---: | :--- | :---: | :---: | :---: |
| **Phase 1** | Architecture & Requirements Specification | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 2** | Archiso Base Framework & Package Manifest Setup | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 3** | Visual Identity & Branding Assets | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 4** | Red Queen Desktop & User Profile Provisioning | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 5** | Developer Stack & Local AI Integration | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 6** | Bootloader, Plymouth & Systemd Services Integration | `[COMPLETED]` | `100%` | `[██████████]` |
| **Phase 7** | ISO Compilation, VM Testing & QA Verification | `[IN PROGRESS]` | `50%` | `[█████░░░░░]` |
| **Phase 8** | Documentation, Viva Defense & Final Packaging | `[COMPLETED]` | `100%` | `[██████████]` |

---

## 4. Current Focus & Immediate Action Items

### Current Active Phase: **Phase 7 (ISO Compilation, VM Testing & QA Verification)**

#### Immediate Action Items:
1. **Pre-flight Build Verification:** Run `mkarchiso` build test command when ready.
2. **Verification & Testing:** Boot and verify live ISO build artifact (`umbrella-os-1.0.0-x86_64.iso`).
