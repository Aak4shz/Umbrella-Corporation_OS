# UMBRELLA OS — Custom Linux Distribution

<div align="center">

```
██╗   ██╗███╗   ███╗██████╗ ██████╗ ███████╗██╗     ██╗      █████╗      ██████╗ ███████╗
██║   ██║████╗ ████║██╔══██╗██╔══██╗██╔════╝██║     ██║     ██╔══██╗    ██╔═══██╗██╔════╝
██║   ██║██╔████╔██║██████╔╝██████╔╝█████╗  ██║     ██║     ███████║    ██║   ██║███████╗
██║   ██║██║╚██╔╝██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     ██╔══██║    ██║   ██║╚════██║
╚██████╔╝██║ ╚═╝ ██║██████╔╝██║  ██║███████╗███████╗███████╗██║  ██║    ╚██████╔╝███████║
 ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝
```

**"Protecting Tomorrow's World, Today."**

*A Custom Arch-Based Linux Distribution for Java/Python Developers & AI Enthusiasts*

[![Built With](https://img.shields.io/badge/Built%20With-Arch%20Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org)
[![Build Tool](https://img.shields.io/badge/Build%20Tool-archiso-CC0000?style=for-the-badge&logo=linux&logoColor=white)](https://wiki.archlinux.org/title/Archiso)
[![Desktop](https://img.shields.io/badge/Desktop-KDE%20Plasma-1D99F3?style=for-the-badge&logo=kde&logoColor=white)](https://kde.org/plasma-desktop/)
[![Theme](https://img.shields.io/badge/Theme-Umbrella%20Corp-8B0000?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PGNpcmNsZSBjeD0iMTIiIGN5PSIxMiIgcj0iMTAiIGZpbGw9IiM4QjAwMDAiLz48L3N2Zz4=&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-Academic%20Project-green?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge)](#)

</div>

---

> **PROJECT CLASSIFICATION: FINAL-YEAR ACADEMIC PROJECT**
> This repository documents the complete end-to-end process of building a custom, bootable Linux distribution from scratch using `archiso`. This is an advanced systems-level project demonstrating mastery of Linux internals, system administration, package management, desktop environment customization, and AI tool integration.

---

## Table of Contents

1. [Project Overview](#-project-overview)
2. [Architecture at a Glance](#-architecture-at-a-glance)
3. [Prerequisites & Host Machine Setup](#-prerequisites--host-machine-setup)
4. [Phase 1: Local Environment & Theme Design](#-phase-1-local-environment--theme-design)
5. [Phase 2: Dev & AI Stack Installation](#-phase-2-dev--ai-stack-installation)
6. [Phase 3: The Secret Sauce — Extracting Dotfiles](#-phase-3-the-secret-sauce--extracting-dotfiles)
7. [Phase 4: Archiso Architecture & Configuration](#-phase-4-archiso-architecture--configuration)
8. [Phase 5: Build, Test & Iterate](#-phase-5-build-test--iterate)
9. [Phase 6: Academic Presentation Strategy](#-phase-6-academic-presentation-strategy)
10. [Project File Structure](#-project-file-structure)
11. [Troubleshooting Reference](#-troubleshooting-reference)
12. [OS Concepts Demonstrated](#-os-concepts-demonstrated)
13. [Acknowledgements & References](#-acknowledgements--references)

---

## Project Overview

### What is Umbrella OS?

**Umbrella OS** is a fully custom, bootable Linux distribution built on top of Arch Linux using the `archiso` build framework. It is not a reskin or a simple configuration of an existing distro — it is a **purpose-built operating system** designed for a very specific audience: **Software Developers (Java & Python) and AI Enthusiasts** who demand a zero-setup, fully pre-configured workstation the moment the OS boots.

The aesthetic is inspired by the **Umbrella Corporation** from the *Resident Evil* franchise — clinical white, deep black, and crimson red — creating an interface that feels like the **Red Queen AI** from the films: intelligent, high-tech, and commanding.

### Why Build a Custom Distro?

| Problem | Umbrella OS Solution |
|---|---|
| Every developer wastes hours setting up a fresh machine | Pre-installed JDK, Python, Git, and build tools out-of-the-box |
| Default Linux desktops are generic and uninspiring | Full KDE Plasma dark theme styled as the "Red Queen" interface |
| AI development tools require complex manual setup | Ollama, Aider, and Claude Code pre-configured and ready |
| Terminal environments take hours to configure | Pre-baked Konsole profiles, Zsh config, and shell aliases |
| New OS installations look nothing like your configured machine | All dotfiles deployed via `/etc/skel` — first boot = perfect setup |

### Key Specifications

| Property | Value |
|---|---|
| **Project Name** | Umbrella OS |
| **Version** | 1.0.0-ACADEMIC |
| **Base Distribution** | Arch Linux (Rolling Release) |
| **Build Tool** | archiso |
| **Desktop Environment** | KDE Plasma (Latest Stable) |
| **Display Server** | Wayland (X11 fallback available) |
| **Architecture** | x86_64 |
| **Boot Mode** | UEFI (with BIOS Legacy fallback) |
| **Bootloader** | GRUB2 with custom Umbrella theme |
| **Boot Animation** | Plymouth with custom Umbrella Corp animation |
| **Shell** | Zsh with Oh My Zsh + custom Umbrella theme |
| **Target Audience** | Java/Python Developers, AI/ML Enthusiasts |
| **ISO Output Size** | ~4–6 GB (estimated with all tools) |

---

## Architecture at a Glance

```
┌─────────────────────────────────────────────────────────────────────┐
│                         UMBRELLA OS STACK                           │
├─────────────────────────────────────────────────────────────────────┤
│                     AI LAYER (Top Level)                            │
│         Ollama  │  Aider  │  Claude Code  │  Python AI Libs        │
├─────────────────────────────────────────────────────────────────────┤
│                   DEVELOPER STACK                                   │
│    JDK 21  │  Python 3.12  │  Git  │  Maven  │  Gradle  │  pip    │
├─────────────────────────────────────────────────────────────────────┤
│                   PRESENTATION LAYER                                │
│   KDE Plasma (Red Queen Theme)  │  GRUB Theme  │  Plymouth Anim   │
│   Custom Wallpapers  │  Konsole Profiles  │  Zsh + Oh My Zsh      │
├─────────────────────────────────────────────────────────────────────┤
│                   SYSTEM SERVICES                                   │
│     NetworkManager  │  PipeWire  │  SDDM (Custom Login)            │
├─────────────────────────────────────────────────────────────────────┤
│                   ARCH LINUX BASE SYSTEM                            │
│    Pacman  │  systemd  │  base  │  linux-zen kernel                │
├─────────────────────────────────────────────────────────────────────┤
│                   HARDWARE ABSTRACTION                              │
│       UEFI/BIOS  │  x86_64  │  VM Compatible                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Prerequisites & Host Machine Setup

### Host Machine Requirements

Your development machine (where you **build** the ISO) must be an **Arch Linux** system. You cannot build an archiso-based image from Ubuntu or any other distro without significant workarounds.

| Requirement | Minimum | Recommended |
|---|---|---|
| **OS** | Arch Linux | Arch Linux (rolling, fully updated) |
| **RAM** | 4 GB | 8 GB or more |
| **Disk Space** | 20 GB free | 40 GB free (for build artifacts) |
| **CPU** | Any x86_64 | Multi-core (faster builds) |
| **Internet** | Required | Stable broadband |

### Install Required Build Tools on Host

```bash
# Update the full system first — always do this on Arch before any major work
sudo pacman -Syu

# Install archiso — the official Arch tool for building custom ISOs
sudo pacman -S archiso

# Install supporting tools needed during the build process
sudo pacman -S git base-devel wget curl squashfs-tools libisoburn dosfstools

# Verify archiso installation
archiso --version
# Expected output: archiso v<version>

# Install virtualization tools for testing your ISO before burning
sudo pacman -S qemu-full virt-manager libvirt edk2-ovmf
sudo systemctl enable --now libvirtd

# Add yourself to the libvirt group so you can manage VMs without sudo
sudo usermod -aG libvirt $(whoami)
# Log out and back in for this to take effect
```

> **Pitfall:** If you skip `sudo pacman -Syu` before the build, your installed keyring may be outdated, causing package signature verification failures during the ISO build process. Always update first.

---

## Phase 1: Local Environment & Theme Design

> **Goal:** Transform your personal Arch Linux installation into the full Umbrella OS experience. Every customization you make here will later be extracted and packaged into the ISO. Build it here first — package it later.

### Step 1.1 — Install KDE Plasma Desktop

```bash
# Install the full KDE Plasma desktop environment
sudo pacman -S plasma plasma-desktop kde-applications sddm

# Install KDE-specific utilities we'll need
sudo pacman -S plasma-pa plasma-nm kwallet-pam kscreen
sudo pacman -S dolphin konsole kate ark spectacle okular

# Enable SDDM (the KDE display manager) as the default login screen
sudo systemctl enable sddm.service

# Reboot into KDE Plasma
sudo reboot
```

### Step 1.2 — Install the Lightly Application Style (Required for Custom Theme)

The `Lightly` application style provides more rounded, modern windows that are essential for the Red Queen look.

```bash
# Install from AUR using yay (install yay if you don't have it)
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si && cd ..

# Install Lightly style
yay -S lightly-qt

# Install kvantum for advanced Qt theming
sudo pacman -S kvantum
```

### Step 1.3 — Install a Dark Base Theme (Dracula or Catppuccin Mocha as the Foundation)

We will use an established dark theme as our base and then heavily modify it to create the Umbrella Corp aesthetic.

```bash
# Install Dracula theme for KDE (excellent dark base with accent color support)
yay -S plasma5-themes-dracula

# Install icon theme — Papirus Dark is clean, minimal, and professional
sudo pacman -S papirus-icon-theme

# Install fonts — critical for the "high-tech" terminal look
sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd
sudo pacman -S ttf-fira-code noto-fonts noto-fonts-emoji
sudo pacman -S ttf-roboto inter-font
```

### Step 1.4 — Apply the Base Theme via KDE System Settings

Open **System Settings** and configure the following. These settings are what you'll later export as dotfiles.

```
System Settings → Appearance → Global Theme
  → Download "Layan" or "Sweet" dark theme → Apply

System Settings → Appearance → Colors
  → Customize colors:
     Background: #0A0A0A     (near-black)
     Foreground: #F0F0F0     (clinical white)
     Selection:  #CC0000     (Umbrella Red)
     Link Color: #FF2020     (bright red for links)
     Active Title Bar: #1A0000  (dark crimson)

System Settings → Appearance → Application Style
  → Select "Lightly"

System Settings → Appearance → Icons
  → Select "Papirus-Dark"

System Settings → Appearance → Fonts
  → General:       JetBrains Mono 10
  → Fixed Width:   JetBrains Mono 10
  → Toolbar:       Roboto Medium 9
  → Window Title:  Roboto Bold 10
```

### Step 1.5 — Create the Umbrella Corp Wallpaper Directory

```bash
# Create a directory for custom wallpapers
mkdir -p ~/.local/share/wallpapers/UmbrellaOS/

# Place your custom wallpapers here. Recommended: 3840x2160 (4K) resolution.
# Wallpaper concepts:
# - The Umbrella Corporation logo (red on black) with hexagonal honeycomb pattern
# - The Red Queen AI interface with holographic overlays
# - Dark Raccoon City skyline with the Umbrella logo in the sky
# - Clinical lab environment with red ambient lighting

# For now, download a placeholder or use GIMP/Krita to create your wallpaper
# We will cover wallpaper creation in detail in the assets section
```

### Step 1.6 — Configure KDE Plasma Panel (Taskbar) for the Red Queen Look

Right-click the desktop → **Configure Desktop and Wallpaper** → configure:

```
Panel Layout:
  → Remove default panel
  → Add new panel → "Empty Panel"
  → Position: Bottom, Height: 44px
  → Add widgets:
     - Application Launcher (with custom Umbrella logo)
     - Task Manager (Icon-Only style)
     - System Tray
     - Digital Clock (Font: JetBrains Mono, format: hh:mm:ss AP)

Panel Opacity: Translucent (80%)
Panel Background: #0D0000 with 80% opacity
```

### Step 1.7 — Install and Configure a Custom GRUB Theme (Umbrella Corp)

```bash
# Create GRUB theme directory
sudo mkdir -p /boot/grub/themes/umbrella

# Create the theme descriptor file
sudo nano /boot/grub/themes/umbrella/theme.txt
```

Paste this into `theme.txt`:

```
# Umbrella OS — GRUB Theme
# Inspired by Umbrella Corporation from Resident Evil

desktop-color: "#0A0A0A"
desktop-image: "background.png"
terminal-box: "terminal_box_*.png"
terminal-font: "JetBrains Mono Regular 14"

+ boot_menu {
  left = 30%
  top = 40%
  width = 40%
  height = 30%
  item_font = "JetBrains Mono Regular 14"
  item_color = "#F0F0F0"
  selected_item_color = "#FF0000"
  selected_item_pixmap_style = "select_*.png"
  item_height = 36
  item_padding = 12
  item_spacing = 4
}

+ label {
  top = 85%
  left = 0
  width = 100%
  align = "center"
  text = "UMBRELLA CORPORATION — AUTHORIZED PERSONNEL ONLY"
  font = "JetBrains Mono Regular 12"
  color = "#CC0000"
}
```

```bash
# Edit GRUB configuration to use the custom theme
sudo nano /etc/default/grub
```

Add/modify these lines:

```bash
GRUB_THEME="/boot/grub/themes/umbrella/theme.txt"
GRUB_BACKGROUND="/boot/grub/themes/umbrella/background.png"
GRUB_GFXMODE="1920x1080,auto"
GRUB_GFXPAYLOAD_LINUX="keep"
GRUB_TIMEOUT=5
GRUB_TIMEOUT_STYLE="menu"

# Customize the menu entry name
GRUB_DISTRIBUTOR="Umbrella OS"
```

```bash
# Regenerate GRUB configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Step 1.8 — Install and Configure Plymouth (Boot Animation)

```bash
# Install Plymouth
sudo pacman -S plymouth

# Install a dark base theme to customize
yay -S plymouth-theme-hexagon-dots-git
# OR install a spinner theme as base
sudo pacman -S plymouth-theme-spinner

# Check available themes
plymouth-set-default-theme --list

# Create your custom Plymouth theme directory
sudo mkdir -p /usr/share/plymouth/themes/umbrella-boot

# Create the theme script
sudo nano /usr/share/plymouth/themes/umbrella-boot/umbrella-boot.script
```

A minimal Plymouth script that shows the Umbrella logo:

```javascript
// umbrella-boot.script — Plymouth Boot Animation

wallpaper_image = Image("background.png");
screen_width = Window.GetWidth();
screen_height = Window.GetHeight();

wallpaper_sprite = Sprite(wallpaper_image.Scale(screen_width, screen_height));
wallpaper_sprite.SetZ(-100);

logo_image = Image("umbrella_logo.png");
logo_sprite = Sprite(logo_image);
logo_sprite.SetX(screen_width / 2 - logo_image.GetWidth() / 2);
logo_sprite.SetY(screen_height / 2 - logo_image.GetHeight() / 2);

// Progress bar at bottom
progress_box = Image.CreateFilledWithColor(600, 4, 0.8, 0, 0, 1);
progress_sprite = Sprite(progress_box);
progress_sprite.SetX(screen_width / 2 - 300);
progress_sprite.SetY(screen_height * 0.85);

fun refresh_callback() {
    progress_sprite.SetOpacity(0.8 + 0.2 * Math.Sin(Plymouth.GetBoot().GetSecs() * 3));
}

Plymouth.SetRefreshFunction(refresh_callback);
```

```bash
# Set Umbrella Plymouth theme as default
sudo plymouth-set-default-theme umbrella-boot

# Rebuild initramfs to include Plymouth
sudo mkinitcpio -P

# Add Plymouth to GRUB kernel parameters
sudo nano /etc/default/grub
# Add to GRUB_CMDLINE_LINUX_DEFAULT:
# quiet splash plymouth.enable=1
```

### Step 1.9 — Configure the Red Queen Terminal (Konsole)

This is the most visually impactful piece of the Umbrella OS experience.

```bash
# Konsole profile configuration directory
mkdir -p ~/.local/share/konsole/

# Create the Red Queen profile
nano ~/.local/share/konsole/RedQueen.profile
```

```ini
[Appearance]
ColorScheme=RedQueen
Font=JetBrains Mono,13,-1,5,50,0,0,0,0,0
LineSpacing=2
UseFontLineChararacters=true

[General]
Command=/bin/zsh
LocalTabTitleFormat=%d — %n
Name=Red Queen
Parent=FALLBACK/
RemoteTabTitleFormat=%H — %u

[Scrolling]
ScrollBarPosition=2
ScrollFullPage=false

[Terminal Features]
BidiRenderingEnabled=false
BlinkingCursorEnabled=true
CursorShape=1
```

```bash
# Create the Red Queen color scheme
mkdir -p ~/.local/share/konsole/
nano ~/.local/share/konsole/RedQueen.colorscheme
```

```ini
[Background]
Color=10,0,0

[BackgroundFaint]
Color=18,0,0

[BackgroundIntense]
Color=25,0,0

[Color0]
Color=18,18,18

[Color0Faint]
Color=10,10,10

[Color0Intense]
Color=40,40,40

[Color1]
Color=204,0,0

[Color1Intense]
Color=255,50,50

[Color2]
Color=80,200,80

[Color2Intense]
Color=100,255,100

[Color3]
Color=200,160,0

[Color3Intense]
Color=255,200,0

[Color4]
Color=50,100,200

[Color4Intense]
Color=80,140,255

[Color5]
Color=170,0,170

[Color5Intense]
Color=220,50,220

[Color6]
Color=0,180,180

[Color6Intense]
Color=0,220,220

[Color7]
Color=200,200,200

[Color7Intense]
Color=255,255,255

[Foreground]
Color=230,230,230

[ForegroundFaint]
Color=160,160,160

[ForegroundIntense]
Color=255,255,255

[General]
Anchor=0.5,0.5
Blur=true
BlurRadius=8
ColorRandomization=false
Description=Red Queen Terminal
FillStyle=Tile
Opacity=0.88
Wallpaper=
WallpaperOpacity=1
```

### Step 1.10 — Install and Configure Zsh with Oh My Zsh

```bash
# Install Zsh
sudo pacman -S zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions

# Set Zsh as the default shell
chsh -s /bin/zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k — the best prompt theme for the Red Queen look
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install useful OMZ plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Edit `~/.zshrc` to look like this:

```bash
# ~/.zshrc — Umbrella OS Shell Configuration

export ZSH="$HOME/.oh-my-zsh"

# Theme — Powerlevel10k with Red Queen customization
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  python
  pip
  gradle
  mvn
  docker
  kubectl
  history
  colored-man-pages
  command-not-found
)

source $ZSH/oh-my-zsh.sh

# ─── UMBRELLA OS Environment Variables ────────────────────────────────────────
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export PYTHONPATH=$HOME/.local/lib/python3.12:$PYTHONPATH
export OLLAMA_HOST=127.0.0.1:11434

# ─── Aliases — Red Queen Commands ─────────────────────────────────────────────
alias cls="clear"
alias ll="ls -alh --color=auto"
alias la="ls -A --color=auto"
alias ..="cd .."
alias ...="cd ../.."

# Git shortcuts
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"

# AI shortcuts
alias ai="ollama run llama3.2"
alias aider="aider --model ollama/llama3.2"

# Java shortcuts
alias jrun="java -jar"
alias mci="mvn clean install"
alias mcp="mvn clean package"

# Python shortcuts  
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source ./venv/bin/activate"

# Umbrella OS branding
echo ""
echo "  UMBRELLA CORPORATION"
echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Welcome back, $(whoami | tr '[:lower:]' '[:upper:]')"
echo "  Authorized Access Granted | $(date '+%A, %B %d %Y — %H:%M:%S')"
echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Powerlevel10k instant prompt (must be at the bottom)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

```bash
# Apply the Zsh configuration
source ~/.zshrc

# Configure Powerlevel10k prompt (run the wizard)
p10k configure
# Choose:
# - Nerdfont symbols: Yes
# - Extra icons: Few
# - Prompt style: Rainbow or Pure (pick what looks most "Red Queen")
# - Time format: 24-hour
# - Prompt separators: Slanted
```

> **Pitfall:** The `echo` block at the top of `.zshrc` (the welcome banner) can sometimes interfere with terminal scripts or non-interactive shells. Wrap it in `[[ $- == *i* ]] && ...` to ensure it only runs in interactive sessions.

---

## Phase 2: Dev & AI Stack Installation

> **Goal:** Install and verify every developer tool and AI utility that Umbrella OS will ship pre-configured. Everything installed here will be declared in the archiso `packages.x86_64` file later.

### Step 2.1 — Install Java Development Kit (JDK 21 LTS)

```bash
# Install OpenJDK 21 (Long-Term Support — best choice for a stable dev distro)
sudo pacman -S jdk21-openjdk openjdk21-src

# Verify installation
java --version
# Expected: openjdk 21.x.x ...

javac --version
# Expected: javac 21.x.x

# Set JAVA_HOME permanently (already added in .zshrc above)
echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk' >> ~/.zshrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# Install Maven (build tool for Java projects)
sudo pacman -S maven

# Install Gradle (alternative Java build tool, popular with Android/Kotlin)
sudo pacman -S gradle

# Verify
mvn --version
gradle --version
```

### Step 2.2 — Install Python Environment Stack

```bash
# Python 3 is already on Arch, but install the full stack
sudo pacman -S python python-pip python-virtualenv python-pipx

# Install essential Python packages globally
pip install --user \
  ipython \
  jupyter \
  black \
  flake8 \
  pylint \
  mypy \
  pytest \
  requests \
  fastapi \
  uvicorn \
  sqlalchemy \
  pydantic \
  click \
  rich

# Install AI/ML Python libraries
pip install --user \
  numpy \
  pandas \
  matplotlib \
  scikit-learn \
  torch torchvision \
  transformers \
  openai \
  anthropic \
  langchain \
  chromadb

# Verify
python3 --version
# Expected: Python 3.12.x

pip3 list | grep -E "(numpy|torch|transformers)"
```

### Step 2.3 — Install Essential Developer Tools

```bash
# Version Control
sudo pacman -S git git-lfs github-cli

# Configure Git globally (will be included in skel dotfiles)
git config --global user.name "Umbrella Corp Developer"
git config --global user.email "developer@umbrella-corp.os"
git config --global core.editor "nano"
git config --global init.defaultBranch "main"
git config --global color.ui "auto"

# Code Editors & IDEs
sudo pacman -S code                    # VS Code (open-source build)
yay -S visual-studio-code-bin         # OR the official Microsoft build

# Install useful VS Code extensions (via CLI)
code --install-extension ms-python.python
code --install-extension redhat.java
code --install-extension ms-toolsai.jupyter
code --install-extension eamodio.gitlens
code --install-extension pkief.material-icon-theme
code --install-extension zhuangtongfa.material-theme
code --install-extension ms-vscode.cpptools

# Terminal multiplexer (essential for developers)
sudo pacman -S tmux

# Docker (containerization)
sudo pacman -S docker docker-compose
sudo systemctl enable docker.service
sudo usermod -aG docker $(whoami)

# Database CLI tools
sudo pacman -S postgresql-libs sqlite

# Network tools
sudo pacman -S curl wget httpie nmap

# System monitoring (beautiful TUI tools)
sudo pacman -S btop fastfetch neofetch
yay -S gotop

# File management
sudo pacman -S tree fzf ripgrep fd bat eza

# Compression tools
sudo pacman -S zip unzip p7zip

# Verify critical tools
git --version && docker --version && code --version
```

### Step 2.4 — Install Ollama (Local AI Model Runner)

```bash
# Install Ollama — runs large language models locally
curl -fsSL https://ollama.com/install.sh | sh

# Enable and start the Ollama service
sudo systemctl enable ollama.service
sudo systemctl start ollama.service

# Verify Ollama is running
ollama --version
systemctl status ollama

# Pull a default model (this will be included in post-install instructions
# since model sizes are too large to bundle in the ISO itself)
ollama pull llama3.2          # Meta's Llama 3.2 — 3B parameter model (~2GB)
ollama pull llama3.2:3b       # Explicit 3B variant
ollama pull codellama:7b      # Code-specialized model (~4GB)
ollama pull phi3:mini         # Microsoft Phi-3 Mini — small and fast

# Test that Ollama works
ollama run llama3.2 "Say: Umbrella Corporation, your trusted partner."

# List available models
ollama list
```

> **Note for ISO packaging:** Ollama models are gigabytes in size and cannot be bundled into the ISO. The ISO will ship with Ollama **installed and configured** but models will be downloaded on first boot via a post-install script or user instruction.

### Step 2.5 — Install Aider (AI Pair Programming Tool)

```bash
# Aider is a command-line AI coding assistant that works with local Ollama models
pip install --user aider-chat

# Verify installation
aider --version

# Create Aider configuration file
mkdir -p ~/.config/aider/
nano ~/.config/aider/.aider.conf.yml
```

```yaml
# ~/.config/aider/.aider.conf.yml — Umbrella OS Aider Configuration
model: ollama/llama3.2
ollama-api-base: http://127.0.0.1:11434
auto-commits: false
git: true
show-diff: true
dark-mode: true
```

### Step 2.6 — Install Claude Code (Anthropic AI Coding Assistant)

```bash
# Claude Code requires Node.js — install it first
sudo pacman -S nodejs npm

# Verify Node.js
node --version    # Should be 18+ or 20+ LTS
npm --version

# Install Claude Code globally via npm
npm install -g @anthropic-ai/claude-code

# Verify
claude --version

# Claude Code uses the ANTHROPIC_API_KEY environment variable
# Add to .zshrc (users will add their own key after installation)
echo '# Claude Code API Key — add your key here' >> ~/.zshrc
echo '# export ANTHROPIC_API_KEY="your-key-here"' >> ~/.zshrc
```

> **Note:** Claude Code requires an Anthropic API key that each user must obtain from console.anthropic.com. The ISO ships with Claude Code installed; users configure their key post-install.

### Step 2.7 — Configure a Custom Neofetch/Fastfetch Banner

This is displayed when a new terminal opens, serving as the "boot screen" for the shell.

```bash
# Create a custom fastfetch configuration
mkdir -p ~/.config/fastfetch/

nano ~/.config/fastfetch/config.jsonc
```

```jsonc
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "file",
        "source": "~/.config/fastfetch/umbrella-logo.txt",
        "color": {
            "1": "red",
            "2": "white"
        }
    },
    "modules": [
        "title",
        "separator",
        { "type": "os",       "key": "OS      " },
        { "type": "kernel",   "key": "Kernel  " },
        { "type": "uptime",   "key": " Uptime  " },
        { "type": "shell",    "key": "Shell   " },
        { "type": "de",       "key": " Desktop " },
        { "type": "cpu",      "key": "CPU     " },
        { "type": "memory",   "key": "RAM     " },
        { "type": "disk",     "key": "Disk    " },
        { "type": "colors",   "symbol": "circle" }
    ]
}
```

```bash
# Create the ASCII logo file for fastfetch
nano ~/.config/fastfetch/umbrella-logo.txt
```

```
${1}   ██╗   ██╗███╗   ███╗██████╗ ██████╗ ███████╗██╗     ██╗      █████╗ 
${1}   ██║   ██║████╗ ████║██╔══██╗██╔══██╗██╔════╝██║     ██║     ██╔══██╗
${1}   ██║   ██║██╔████╔██║██████╔╝██████╔╝█████╗  ██║     ██║     ███████║
${1}   ██║   ██║██║╚██╔╝██║██╔══██╗██╔══██╗██╔══╝  ██║     ██║     ██╔══██║
${1}   ╚██████╔╝██║ ╚═╝ ██║██████╔╝██║  ██║███████╗███████╗███████╗██║  ██║
${1}    ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
${2}                    O P E R A T I N G   S Y S T E M  v1.0
```

---

## Phase 3: The Secret Sauce — Extracting Dotfiles

> **Goal:** Carefully extract all configuration files from your customized local machine and organize them into a structure that can be dropped directly into the ISO's `/etc/skel` directory. Every new user created on Umbrella OS will automatically inherit all these configurations.

### Understanding `/etc/skel`

```
/etc/skel is the "skeleton" directory.
When a new user account is created (useradd),
Linux COPIES the entire contents of /etc/skel
into the new user's home directory.

So if /etc/skel/.zshrc exists,
every new user gets that .zshrc automatically.

This is how Umbrella OS achieves zero-setup experience:
The live user and every installed user gets
the EXACT same environment without any manual configuration.
```

### Step 3.1 — Create the Dotfiles Staging Directory

```bash
# Create a staging area for all dotfiles
mkdir -p ~/umbrella-dotfiles
mkdir -p ~/umbrella-dotfiles/home-skel
mkdir -p ~/umbrella-dotfiles/system-wide

# This will mirror the structure of /etc/skel
# and also hold system-wide config files
```

### Step 3.2 — Extract Shell Configuration

```bash
# Copy Zsh configurations
cp ~/.zshrc              ~/umbrella-dotfiles/home-skel/.zshrc
cp ~/.p10k.zsh           ~/umbrella-dotfiles/home-skel/.p10k.zsh
cp -r ~/.oh-my-zsh       ~/umbrella-dotfiles/home-skel/.oh-my-zsh

# Copy tmux config if you've customized it
cp ~/.tmux.conf          ~/umbrella-dotfiles/home-skel/.tmux.conf 2>/dev/null || true
```

### Step 3.3 — Extract KDE Plasma Configuration

```bash
# KDE stores nearly ALL user configuration under ~/.config and ~/.local
# We need to be selective — copy everything relevant to the visual theme

# Create target structure
mkdir -p ~/umbrella-dotfiles/home-skel/.config
mkdir -p ~/umbrella-dotfiles/home-skel/.local/share

# Core KDE appearance settings
cp -r ~/.config/plasma-org.kde.plasma.desktop-appletsrc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/plasmarc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/kdeglobals \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/kwinrc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/kscreenlockerrc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/kdedefaults \
       ~/umbrella-dotfiles/home-skel/.config/ 2>/dev/null || true

# Application-specific configs
cp -r ~/.config/kglobalshortcutsrc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/dolphinrc \
       ~/umbrella-dotfiles/home-skel/.config/

cp -r ~/.config/katerc \
       ~/umbrella-dotfiles/home-skel/.config/ 2>/dev/null || true

# Konsole profiles (THE MOST IMPORTANT — the Red Queen terminal)
cp -r ~/.local/share/konsole \
       ~/umbrella-dotfiles/home-skel/.local/share/

# KDE color schemes
cp -r ~/.local/share/color-schemes \
       ~/umbrella-dotfiles/home-skel/.local/share/ 2>/dev/null || true

# KDE global themes
cp -r ~/.local/share/plasma \
       ~/umbrella-dotfiles/home-skel/.local/share/ 2>/dev/null || true

# Custom wallpapers
cp -r ~/.local/share/wallpapers \
       ~/umbrella-dotfiles/home-skel/.local/share/

# Akonadi settings (skip — user-specific mail data)
# Skip .config/akonadi — too user-specific
```

### Step 3.4 — Extract VS Code Configuration

```bash
# VS Code user settings
mkdir -p ~/umbrella-dotfiles/home-skel/.config/Code/User/

cp ~/.config/Code/User/settings.json \
   ~/umbrella-dotfiles/home-skel/.config/Code/User/

cp ~/.config/Code/User/keybindings.json \
   ~/umbrella-dotfiles/home-skel/.config/Code/User/ 2>/dev/null || true
```

Create a standard `settings.json` for Umbrella OS:

```json
{
    "workbench.colorTheme": "One Dark Pro",
    "workbench.iconTheme": "material-icon-theme",
    "editor.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
    "editor.fontSize": 14,
    "editor.fontLigatures": true,
    "editor.lineHeight": 1.6,
    "editor.cursorBlinking": "smooth",
    "editor.cursorStyle": "block",
    "editor.renderWhitespace": "selection",
    "editor.formatOnSave": true,
    "terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font'",
    "terminal.integrated.fontSize": 13,
    "workbench.startupEditor": "none",
    "git.autofetch": true,
    "python.defaultInterpreterPath": "/usr/bin/python3",
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-21",
            "path": "/usr/lib/jvm/java-21-openjdk",
            "default": true
        }
    ],
    "editor.bracketPairColorization.enabled": true,
    "editor.guides.bracketPairs": "active"
}
```

### Step 3.5 — Extract Git Configuration

```bash
cp ~/.gitconfig \
   ~/umbrella-dotfiles/home-skel/.gitconfig
```

### Step 3.6 — Extract Fastfetch Configuration

```bash
cp -r ~/.config/fastfetch \
   ~/umbrella-dotfiles/home-skel/.config/
```

### Step 3.7 — Extract Aider Configuration

```bash
cp -r ~/.config/aider \
   ~/umbrella-dotfiles/home-skel/.config/ 2>/dev/null || true
```

### Step 3.8 — Handle System-Wide Themes (Not in skel)

Some themes need to be installed system-wide (not just per-user):

```bash
# Document which packages provide system-wide themes
# These must be listed in packages.x86_64 — NOT in skel

# System-wide KDE themes go to /usr/share/plasma/desktoptheme/
# System-wide icon themes go to /usr/share/icons/
# System-wide fonts go to /usr/share/fonts/

# Copy any locally-built/custom themes that aren't in AUR/pacman
sudo cp -r ~/.local/share/plasma/desktoptheme/UmbrellaOS \
           /usr/share/plasma/desktoptheme/ 2>/dev/null || true

# Export the full list of installed packages for reference
pacman -Qqe > ~/umbrella-dotfiles/package-list-explicit.txt
pacman -Qq  > ~/umbrella-dotfiles/package-list-all.txt
```

### Step 3.9 — Audit and Clean the Dotfiles

Before packaging, audit every file you're copying:

```bash
# Check for any hardcoded absolute paths that reference your username
grep -r "$(whoami)" ~/umbrella-dotfiles/home-skel/ 2>/dev/null

# Replace any hardcoded username with a placeholder if found
# The live user in archiso is called "arch" by default
# But /etc/skel is copied before the username is set, so this usually works fine

# Check total size of dotfiles
du -sh ~/umbrella-dotfiles/home-skel/
# If it's over 500MB, investigate what's taking space

# Particularly watch out for:
# - ~/.oh-my-zsh can be large — this is fine, it's needed
# - .local/share/konsole — should be small (just profiles)
# - Any cached data accidentally included
```

> **Critical Pitfall:** Never include `~/.config/dconf/user` in your skel — this is a binary database that is completely machine-specific and will cause KDE to behave unpredictably on other hardware. KDE reads its config from the individual `.config/*rc` files, not dconf.

---

## Phase 4: Archiso Architecture & Configuration

> **Goal:** Set up the archiso working directory, populate it with all packages, custom files, and scripts, creating the blueprint for the final ISO image.

### Step 4.1 — Understanding Archiso Structure

```bash
# Archiso provides a profile template. Copy it to start working.
cp -r /usr/share/archiso/configs/releng/ ~/umbrella-os-build

# Navigate into the build directory — this is now your ISO workspace
cd ~/umbrella-os-build

# Let's understand what we have:
tree ~/umbrella-os-build/
```

```
umbrella-os-build/
├── airootfs/                    ← THIS becomes the root filesystem of your ISO
│   ├── etc/
│   │   ├── hostname             ← Sets hostname to "umbrella-os" in live env
│   │   ├── locale.conf          ← Sets language/locale
│   │   ├── mkinitcpio.conf      ← Initramfs configuration
│   │   ├── pacman.conf          ← Pacman mirror/repo config for the ISO
│   │   ├── shadow               ← Pre-set passwords for live users
│   │   └── skel/               ← ← ← THE SECRET SAUCE GOES HERE
│   ├── root/
│   │   └── .automated_script.sh ← Runs when the live env boots
│   └── usr/
│       └── local/bin/           ← Custom scripts available in the live env
│
├── efiboot/                     ← EFI boot files
├── grub/                        ← GRUB bootloader configuration
├── syslinux/                    ← Legacy BIOS boot
│
├── packages.x86_64              ← ← ← LIST OF ALL PACKAGES TO INSTALL
├── pacman.conf                  ← Pacman configuration used DURING the build
├── profiledef.sh                ← ← ← MAIN BUILD PROFILE DEFINITION
└── build.sh                     ← (deprecated, mkarchiso replaces this)
```

### Step 4.2 — Configure `profiledef.sh` (The Build Identity)

```bash
nano ~/umbrella-os-build/profiledef.sh
```

```bash
#!/usr/bin/env bash
# profiledef.sh — Umbrella OS Build Profile
# shellcheck disable=SC2034

iso_name="umbrella-os"
iso_label="UMBRELLA_OS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Umbrella Corporation OS Project <https://github.com/your-username/umbrella-os>"
iso_application="Umbrella OS — Developer & AI Workstation"
iso_version="1.0.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=(
    'bios.syslinux.mbr'
    'bios.syslinux.eltorito'
    'uefi-ia32.grub.esp'
    'uefi-x64.grub.esp'
    'uefi-x64.grub.eltorito'
)
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
    ["/etc/shadow"]="0:0:400"
    ["/etc/gshadow"]="0:0:400"
    ["/root"]="0:0:750"
    ["/root/.automated_script.sh"]="0:0:755"
    ["/usr/local/bin/choose-mirror"]="0:0:755"
    ["/usr/local/bin/Installation_guide"]="0:0:755"
    ["/usr/local/bin/livecd-sound"]="0:0:755"
)
```

### Step 4.3 — Configure `packages.x86_64` (The Complete Package List)

This is the most critical file. Every package listed here is installed into the ISO.

```bash
nano ~/umbrella-os-build/packages.x86_64
```

```
# ════════════════════════════════════════════════════════════════════════════
# UMBRELLA OS — Package List
# File: packages.x86_64
# Purpose: All packages included in the Umbrella OS live environment
# ════════════════════════════════════════════════════════════════════════════

# ── BASE SYSTEM ─────────────────────────────────────────────────────────────
base
base-devel
linux
linux-headers
linux-firmware
mkinitcpio
mkinitcpio-archiso

# ── BOOTLOADER ──────────────────────────────────────────────────────────────
grub
efibootmgr
dosfstools
os-prober

# ── INIT & CORE SERVICES ────────────────────────────────────────────────────
systemd
systemd-sysvcompat
dbus

# ── NETWORKING ──────────────────────────────────────────────────────────────
networkmanager
network-manager-applet
nm-connection-editor
wpa_supplicant
wireless_tools
curl
wget

# ── AUDIO (PipeWire stack) ──────────────────────────────────────────────────
pipewire
pipewire-alsa
pipewire-pulse
pipewire-jack
wireplumber
pavucontrol

# ── DISPLAY SERVER & LOGIN ──────────────────────────────────────────────────
xorg-server
xorg-xrandr
wayland
plasma-wayland-session
sddm
sddm-kcm

# ── KDE PLASMA DESKTOP ──────────────────────────────────────────────────────
plasma-meta
kde-system-meta
kde-utilities-meta
konsole
dolphin
kate
ark
spectacle
okular
gwenview
kcalc
partitionmanager

# ── KDE THEMING & VISUAL ────────────────────────────────────────────────────
papirus-icon-theme
kvantum
qt5-styleplugins

# ── FONTS ───────────────────────────────────────────────────────────────────
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
ttf-fira-code
noto-fonts
noto-fonts-emoji
ttf-roboto
inter-font
ttf-font-awesome

# ── SHELL & TERMINAL TOOLS ──────────────────────────────────────────────────
zsh
zsh-completions
zsh-syntax-highlighting
zsh-autosuggestions
tmux
bash-completion

# ── FILE MANAGEMENT ─────────────────────────────────────────────────────────
tree
fzf
ripgrep
fd
bat
eza
rsync
zip
unzip
p7zip
ranger

# ── SYSTEM MONITORING ───────────────────────────────────────────────────────
btop
fastfetch
htop
lsof
strace
sysstat

# ── JAVA DEVELOPMENT STACK ──────────────────────────────────────────────────
jdk21-openjdk
openjdk21-src
maven
gradle

# ── PYTHON DEVELOPMENT STACK ────────────────────────────────────────────────
python
python-pip
python-virtualenv
python-pipx
python-numpy
python-pandas
python-matplotlib
python-scikit-learn
python-requests
python-rich
python-click
python-black
python-pylint
python-pytest
ipython
jupyter-notebook

# ── NODE.JS (for Claude Code) ───────────────────────────────────────────────
nodejs
npm

# ── GIT & VERSION CONTROL ───────────────────────────────────────────────────
git
git-lfs
github-cli
lazygit

# ── CODE EDITOR ─────────────────────────────────────────────────────────────
code

# ── DOCKER ──────────────────────────────────────────────────────────────────
docker
docker-compose
docker-buildx

# ── DATABASE TOOLS ──────────────────────────────────────────────────────────
sqlite
postgresql-libs

# ── NETWORK TOOLS ───────────────────────────────────────────────────────────
nmap
httpie
openssh
net-tools
traceroute
bind

# ── PLYMOUTH (Boot Animation) ────────────────────────────────────────────────
plymouth

# ── ARCHIVE & COMPRESSION ───────────────────────────────────────────────────
lzop
lz4

# ── ACCESSIBILITY & LOCALES ─────────────────────────────────────────────────
man-db
man-pages
texinfo

# ════════════════════════════════════════════════════════════════════════════
# NOTE: Ollama and Aider are installed via post-install scripts,
# not through pacman, as they use curl-based and pip-based installers.
# Claude Code is installed via npm in the post-install script.
# ════════════════════════════════════════════════════════════════════════════
```

> **Pitfall:** AUR packages (like `yay`, `lightly-qt`, `powerlevel10k`) **CANNOT** be listed in `packages.x86_64` — archiso only uses the official Arch repos. AUR packages must be built separately and either included as pre-built `.pkg.tar.zst` files in a local repo, or installed via a custom script that runs inside `airootfs` during the build.

### Step 4.4 — Set Up the `airootfs` Directory Structure

```bash
# Create the full directory structure inside airootfs
cd ~/umbrella-os-build

# System-wide theme directories
mkdir -p airootfs/usr/share/plasma/desktoptheme/
mkdir -p airootfs/usr/share/icons/
mkdir -p airootfs/usr/share/fonts/umbrella/
mkdir -p airootfs/usr/share/wallpapers/UmbrellaOS/
mkdir -p airootfs/usr/share/plymouth/themes/umbrella-boot/
mkdir -p airootfs/boot/grub/themes/umbrella/
mkdir -p airootfs/usr/share/sddm/themes/umbrella-sddm/

# The most important directory — the skeleton for all new users
mkdir -p airootfs/etc/skel/.config
mkdir -p airootfs/etc/skel/.local/share

# System configuration files
mkdir -p airootfs/etc/systemd/system/

# Post-install and custom scripts
mkdir -p airootfs/usr/local/bin/

# Root user home (for the live environment)
mkdir -p airootfs/root/
```

### Step 4.5 — Populate `/etc/skel` with Your Extracted Dotfiles

```bash
# Copy all your extracted dotfiles into the ISO's skel directory
cp -r ~/umbrella-dotfiles/home-skel/.zshrc \
      ~/umbrella-os-build/airootfs/etc/skel/

cp -r ~/umbrella-dotfiles/home-skel/.p10k.zsh \
      ~/umbrella-os-build/airootfs/etc/skel/

cp -r ~/umbrella-dotfiles/home-skel/.oh-my-zsh \
      ~/umbrella-os-build/airootfs/etc/skel/

cp -r ~/umbrella-dotfiles/home-skel/.gitconfig \
      ~/umbrella-os-build/airootfs/etc/skel/

cp -r ~/umbrella-dotfiles/home-skel/.tmux.conf \
      ~/umbrella-os-build/airootfs/etc/skel/ 2>/dev/null || true

cp -r ~/umbrella-dotfiles/home-skel/.config/fastfetch \
      ~/umbrella-os-build/airootfs/etc/skel/.config/

cp -r ~/umbrella-dotfiles/home-skel/.config/Code \
      ~/umbrella-os-build/airootfs/etc/skel/.config/

cp -r ~/umbrella-dotfiles/home-skel/.local/share/konsole \
      ~/umbrella-os-build/airootfs/etc/skel/.local/share/

cp -r ~/umbrella-dotfiles/home-skel/.local/share/wallpapers \
      ~/umbrella-os-build/airootfs/etc/skel/.local/share/

# KDE configuration files (the appearance settings)
for f in plasmarc kdeglobals kwinrc plasma-org.kde.plasma.desktop-appletsrc kscreenlockerrc; do
    [[ -f ~/umbrella-dotfiles/home-skel/.config/$f ]] && \
    cp ~/umbrella-dotfiles/home-skel/.config/$f \
       ~/umbrella-os-build/airootfs/etc/skel/.config/
done
```

### Step 4.6 — Create Key System Configuration Files

**Hostname:**
```bash
echo "umbrella-os" > ~/umbrella-os-build/airootfs/etc/hostname
```

**Locale:**
```bash
cat > ~/umbrella-os-build/airootfs/etc/locale.conf << 'EOF'
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOF
```

**Hosts file:**
```bash
cat > ~/umbrella-os-build/airootfs/etc/hosts << 'EOF'
127.0.0.1   localhost
::1         localhost
127.0.1.1   umbrella-os.localdomain umbrella-os
EOF
```

**Set the default shell to Zsh for all new users:**
```bash
cat >> ~/umbrella-os-build/airootfs/etc/default/useradd << 'EOF'
SHELL=/bin/zsh
EOF
```

**Enable critical systemd services by creating symlinks:**
```bash
# Enable NetworkManager
mkdir -p ~/umbrella-os-build/airootfs/etc/systemd/system/multi-user.target.wants/
ln -sf /usr/lib/systemd/system/NetworkManager.service \
   ~/umbrella-os-build/airootfs/etc/systemd/system/multi-user.target.wants/

# Enable SDDM (display manager / login screen)
mkdir -p ~/umbrella-os-build/airootfs/etc/systemd/system/display-manager.service.wants/
ln -sf /usr/lib/systemd/system/sddm.service \
   ~/umbrella-os-build/airootfs/etc/systemd/system/display-manager.service.wants/

# Enable Docker
ln -sf /usr/lib/systemd/system/docker.service \
   ~/umbrella-os-build/airootfs/etc/systemd/system/multi-user.target.wants/
```

### Step 4.7 — Create a Post-Install Script for AUR Packages & Ollama

Since AUR packages can't go in `packages.x86_64`, we install them via a script:

```bash
nano ~/umbrella-os-build/airootfs/usr/local/bin/umbrella-post-install.sh
```

```bash
#!/bin/bash
# ════════════════════════════════════════════════════════════════════════════
# umbrella-post-install.sh
# Runs after installation to set up AUR packages, Ollama, and Claude Code
# ════════════════════════════════════════════════════════════════════════════

set -e  # Exit on any error

echo ""
echo "  ████████╗"
echo "  ██╔═════╝  Umbrella OS — Post-Install Setup"
echo "  ████████╗  Version 1.0.0"
echo "  ██╔═════╝"
echo "  ██║        Installing remaining components..."
echo "  ╚═╝"
echo ""

# ── Install yay (AUR helper) ─────────────────────────────────────────────
echo "[1/6] Installing yay AUR helper..."
if ! command -v yay &>/dev/null; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

# ── Install AUR packages ─────────────────────────────────────────────────
echo "[2/6] Installing AUR packages..."
yay -S --noconfirm \
    lightly-qt \
    powerlevel10k \
    visual-studio-code-bin \
    lazygit \
    gotop \
    plymouth-theme-hexagon-dots-git

# ── Install Ollama ───────────────────────────────────────────────────────
echo "[3/6] Installing Ollama..."
if ! command -v ollama &>/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
    sudo systemctl enable ollama.service
fi

# ── Install Aider ────────────────────────────────────────────────────────
echo "[4/6] Installing Aider..."
pip install --user aider-chat

# ── Install Claude Code ──────────────────────────────────────────────────
echo "[5/6] Installing Claude Code..."
if ! command -v claude &>/dev/null; then
    npm install -g @anthropic-ai/claude-code
fi

# ── Install Oh My Zsh ────────────────────────────────────────────────────
echo "[6/6] Setting up Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── Configure Plymouth ───────────────────────────────────────────────────
sudo plymouth-set-default-theme umbrella-boot 2>/dev/null || true
sudo mkinitcpio -P 2>/dev/null || true

echo ""
echo "  Umbrella OS setup complete!"
echo "  Welcome to Umbrella Corporation's Operating System"
echo ""
echo "  Next steps:"
echo "  1. Run 'ollama pull llama3.2' to download a local AI model"
echo "  2. Set your ANTHROPIC_API_KEY in ~/.zshrc for Claude Code"
echo "  3. Reboot to see the full Plymouth boot animation"
echo ""
```

```bash
chmod +x ~/umbrella-os-build/airootfs/usr/local/bin/umbrella-post-install.sh
```

### Step 4.8 — Configure GRUB for the ISO Boot Menu

```bash
# Copy your GRUB theme into the airootfs
cp -r /boot/grub/themes/umbrella \
   ~/umbrella-os-build/airootfs/boot/grub/themes/

# Also configure the archiso GRUB (used during live boot selection)
nano ~/umbrella-os-build/grub/grub.cfg
```

```
# ════════════════════════════════════════════════════════════════════
# UMBRELLA OS — GRUB Boot Menu Configuration
# "Protecting Tomorrow's World, Today."
# ════════════════════════════════════════════════════════════════════

set default=0
set timeout=5

insmod all_video
insmod font

if loadfont "${prefix}/fonts/unicode.pf2"; then
    set gfxmode="auto"
    insmod gfxterm
    terminal_output gfxterm
fi

set theme="${prefix}/themes/umbrella/theme.txt"

menuentry "Umbrella OS — Live Boot" --class umbrella {
    set gfxpayload=keep
    linux   /%INSTALL_DIR%/boot/x86_64/vmlinuz-linux archisobasedir=%INSTALL_DIR% archisolabel=%ARCHISO_LABEL% quiet splash plymouth.enable=1 loglevel=3 rd.udev.log_level=3
    initrd  /%INSTALL_DIR%/boot/x86_64/initramfs-linux.img
}

menuentry "Umbrella OS — Live Boot (RAM)" --class umbrella {
    set gfxpayload=keep
    linux   /%INSTALL_DIR%/boot/x86_64/vmlinuz-linux archisobasedir=%INSTALL_DIR% archisolabel=%ARCHISO_LABEL% quiet splash plymouth.enable=1 copytoram
    initrd  /%INSTALL_DIR%/boot/x86_64/initramfs-linux.img
}

menuentry " EFI Firmware Settings" {
    fwsetup
}

menuentry "Reboot" {
    reboot
}

menuentry " Shutdown" {
    halt
}
```

---

## Phase 5: Build, Test & Iterate

> **Goal:** Run the `mkarchiso` command to produce the final `.iso` file, test it extensively in a virtual machine, and resolve all issues before presenting.

### Step 5.1 — Pre-Build Checklist

Before running `mkarchiso`, run through this checklist:

```bash
cd ~/umbrella-os-build

# Verify profile structure
ls -la
# Must see: airootfs/ efiboot/ grub/ packages.x86_64 pacman.conf profiledef.sh

# Verify skel contents are present
ls -la airootfs/etc/skel/
# Must see your .zshrc, .config/, .local/, etc.

# Verify packages.x86_64 has no blank lines at the end causing issues
wc -l packages.x86_64

# Check that no AUR package names slipped into packages.x86_64
# (AUR packages aren't in official repos and will cause build failure)

# Verify profiledef.sh is executable
chmod +x profiledef.sh

# Check total size of airootfs — if it's too large, the ISO will be huge
du -sh airootfs/
```

### Step 5.2 — Run the Build

```bash
# Create output directory
mkdir -p ~/umbrella-iso-output

# Run mkarchiso — this is the main build command
# MUST be run as root (sudo)
sudo mkarchiso -v -w /tmp/umbrella-work -o ~/umbrella-iso-output ~/umbrella-os-build/

# Flags explained:
# -v               → verbose output (you can see what's happening)
# -w /tmp/...      → working directory (temp files during build — needs ~10GB free)
# -o ~/...         → output directory (where the .iso file is saved)
# ~/umbrella-os-build/  → your profile directory

# The build takes 15–45 minutes depending on internet speed and CPU.
# You will see pacman downloading all packages listed in packages.x86_64
```

**Expected build output:**
```
==> Starting build of Umbrella OS
==> [mkarchiso] Setting up pacman configuration
==> [mkarchiso] Installing packages to work dir
     Packages (XXX) base base-devel linux ...
==> [mkarchiso] Running customize_airootfs.sh
==> [mkarchiso] Creating squashfs image
==> [mkarchiso] Creating ISO image
==> Done! ISO saved to: ~/umbrella-iso-output/umbrella-os-2025XX.iso
```

### Step 5.3 — Test in QEMU/KVM Virtual Machine

Never write to physical media for the first test. Use a VM.

```bash
# Quick UEFI test with QEMU (no VM manager needed)
ISO="$(ls ~/umbrella-iso-output/*.iso | head -1)"

qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -smp 4 \
    -cdrom "$ISO" \
    -boot d \
    -vga virtio \
    -display gtk,gl=on \
    -bios /usr/share/edk2/x64/OVMF.fd \
    -net nic \
    -net user

# For BIOS legacy test (simpler, no EFI)
qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -smp 4 \
    -cdrom "$ISO" \
    -boot d \
    -vga std
```

**VM Testing Checklist:**

```
After the VM boots, verify each item:

 GRUB Stage
 [ ] Custom GRUB theme loads (Umbrella Corp background, red selection highlight)
 [ ] Boot menu entries are visible and readable
 [ ] Selecting "Umbrella OS — Live Boot" boots successfully

 Plymouth Stage
 [ ] Plymouth animation is visible during boot (not just black screen)
 [ ] Custom logo/animation appears

 Desktop Stage
 [ ] SDDM login screen uses custom theme
 [ ] After login: KDE Plasma loads with correct dark theme
 [ ] Wallpaper is the custom Umbrella Corp wallpaper
 [ ] Panel is at the bottom with correct color (dark crimson)
 [ ] Icons are Papirus-Dark

 Terminal Stage
 [ ] Opening Konsole uses the Red Queen profile
 [ ] Background is deep dark red/black
 [ ] Font is JetBrains Mono
 [ ] The welcome banner (Umbrella Corp ASCII art) appears
 [ ] Zsh with Powerlevel10k prompt is active

 Developer Tools Stage
 [ ] java --version → OpenJDK 21
 [ ] python3 --version → Python 3.12
 [ ] git --version → Git
 [ ] mvn --version → Maven
 [ ] gradle --version → Gradle
 [ ] code --version → VS Code
 [ ] docker --version → Docker
 [ ] node --version → Node.js
 [ ] ollama --version → Ollama (even if no models downloaded)
 [ ] aider --version → Aider
 [ ] claude --version → Claude Code
```

### Step 5.4 — Common Build Errors and Fixes

| Error | Cause | Fix |
|---|---|---|
| `error: target not found: <package>` | Package name is wrong or not in Arch repos | Check spelling at `packages.archlinux.org`, remove AUR packages from list |
| `GPG signature verification failed` | Outdated keyring on host | `sudo pacman -Sy archlinux-keyring` then rebuild |
| `squashfs: failed to write` | Not enough disk space in `/tmp` | Use `-w` flag pointing to a partition with 15+ GB free |
| Boot hangs after GRUB | initramfs issue, Plymouth conflict | Remove `splash plymouth.enable=1` from kernel params temporarily |
| KDE doesn't apply theme at login | Skel files not being copied | Check `airootfs/etc/skel/` permissions; ensure files are readable |
| Blank screen after SDDM | GPU driver issue in VM | Add `-vga std` instead of `-vga virtio` in QEMU flags |
| `mkarchiso: error: no profile` | Wrong path passed | Ensure you pass the directory containing `profiledef.sh` |

### Step 5.5 — Write the ISO to a USB Drive (for Physical Testing)

```bash
# VERIFY THE DEVICE NAME FIRST — this will ERASE the USB drive
lsblk
# Find your USB drive — it will be something like /dev/sdb or /dev/sdc
# DO NOT accidentally use your main hard drive (/dev/sda)

ISO="$(ls ~/umbrella-iso-output/*.iso | head -1)"
USB_DEVICE="/dev/sdX"    # ← Replace X with your actual device letter

# Write the ISO using dd
sudo dd if="$ISO" of="$USB_DEVICE" bs=4M status=progress oflag=sync

# Verify the write completed successfully
sync

echo "ISO written to $USB_DEVICE successfully."
```

### Step 5.6 — Iterate: The Build–Test–Fix Cycle

```bash
# After making changes to the profile, clean the work directory and rebuild
sudo rm -rf /tmp/umbrella-work

# Then rebuild
sudo mkarchiso -v -w /tmp/umbrella-work -o ~/umbrella-iso-output ~/umbrella-os-build/

# Pro tip: keep a build log for debugging
sudo mkarchiso -v -w /tmp/umbrella-work -o ~/umbrella-iso-output ~/umbrella-os-build/ 2>&1 | tee ~/umbrella-build.log
```

---

## Phase 6: Academic Presentation Strategy

> **Goal:** Structure your demonstration to maximize marks from college evaluators. Present this not just as a "cool project" but as a technically rigorous demonstration of core Computer Science concepts.

### Step 6.1 — Framing the Narrative for Evaluators

Do not walk in and say "I made a themed Linux distro." Instead, present it as:

> *"Umbrella OS is a custom, purpose-built operating system built from source using Arch Linux's archiso framework. It demonstrates advanced competency in Linux kernel configuration, system administration, package management, desktop environment architecture, and the integration of modern AI developer tooling — all delivered with a zero-setup, production-ready user experience."*

This framing immediately establishes:
- Systems programming knowledge
- OS architecture understanding
- Practical DevOps skills
- Modern AI tooling awareness

### Step 6.2 — The Demonstration Script (10–15 Minute Presentation)

**Segment 1: The Boot Sequence (2 minutes)**
> Boot the VM live and let the GRUB theme, Plymouth animation, and SDDM login screen do the talking. Point out each component and name the underlying technology.
> - "This is GRUB2 — the bootloader. I've replaced the default theme with a fully custom one I built using GRUB's theme scripting language."
> - "This animation is Plymouth — a userspace splash renderer that uses DRM/KMS to display graphics before the desktop loads."
> - "This login screen is SDDM — the Simple Desktop Display Manager, configured to use a custom Umbrella theme."

**Segment 2: The Desktop Experience (3 minutes)**
> Log in. Let the desktop animate open.
> - "Everything you're seeing — wallpaper, panel color, icon theme, window decorations — all of this is pre-configured. When a user creates an account on this system, they receive this exact environment automatically through Linux's `/etc/skel` mechanism."
> - Open the terminal. Let the welcome banner render.
> - "The terminal uses a custom Konsole color scheme I built with specific RGB values to match the Umbrella Corporation aesthetic."

**Segment 3: Developer Stack Demo (3 minutes)**
> Run these commands live:
```bash
java --version          # Java 21 LTS
python3 --version       # Python 3.12
git --version           # Git
mvn --version           # Maven
docker ps               # Docker running
fastfetch               # System info with Umbrella branding
```

**Segment 4: AI Stack Demo (4 minutes)**
> This is the most impressive part for modern evaluators.
```bash
# Start Ollama (may already be running)
systemctl status ollama

# Run a live AI query
ollama run llama3.2 "Write a Python function to reverse a linked list"

# Show Aider (AI pair programming)
mkdir /tmp/demo && cd /tmp/demo && git init
aider --model ollama/llama3.2
# Type: "Create a simple Java Hello World class"

# Show Claude Code
claude --version
# Explain: "This connects to Anthropic's Claude API for cloud-based AI assistance"
```

**Segment 5: Under the Hood — The Technical Architecture (3 minutes)**
> Open a file manager or terminal and walk through the structure:
```bash
# Show the archiso build structure
ls ~/umbrella-os-build/

# Show the package list
wc -l ~/umbrella-os-build/packages.x86_64
cat ~/umbrella-os-build/packages.x86_64 | head -20

# Show the skel directory
ls -la ~/umbrella-os-build/airootfs/etc/skel/

# Show the build command
cat ~/umbrella-build-command.txt
```

### Step 6.3 — Mapping Umbrella OS to Academic OS Concepts

Prepare this table for your viva/evaluation:

| OS Concept | Where Demonstrated in Umbrella OS |
|---|---|
| **Boot Process** | GRUB2 → Plymouth → systemd → SDDM → KDE Plasma (full documented chain) |
| **Kernel Configuration** | `mkinitcpio.conf` — configuring the Linux kernel's initial ramdisk |
| **Package Management** | pacman, `packages.x86_64`, understanding dependency resolution |
| **Process Management** | systemd units for NetworkManager, SDDM, Docker, Ollama |
| **File System Hierarchy** | Proper use of `/usr`, `/etc`, `/home`, `/boot`, `/tmp` as per FHS |
| **User Management** | `/etc/skel` mechanism, shadow file, default shell configuration |
| **Inter-Process Communication** | D-Bus (used by KDE Plasma and system services) |
| **Device Management** | udev rules, PipeWire audio, SDDM GPU handling |
| **Security** | File permissions in `profiledef.sh`, shadow file hardening |
| **Virtualization** | QEMU/KVM testing, understanding VM architecture |
| **Containerization** | Docker pre-installed, demonstrates modern OS-level virtualization |
| **AI/ML Integration** | Ollama local LLM, demonstrating GPU/CPU inference on the OS level |

### Step 6.4 — Common Evaluator Questions and Strong Answers

**Q: "Why Arch Linux and not Ubuntu?"**
> *"Arch Linux was chosen because it's a minimal base — it installs only what you explicitly declare. This forces a deep understanding of every component of the system, because nothing is included by default. Ubuntu ships with 1,500+ pre-installed packages; Arch starts with nothing. For a project that aims to demonstrate OS construction knowledge, Arch is the honest choice."*

**Q: "What is archiso and why use it?"**
> *"archiso is Arch Linux's official tool for building bootable ISO images. It's what Arch Linux itself uses to build its own installation media. It operates by taking a 'profile' — a directory with a package list and a root filesystem overlay — and builds a fully bootable, squashfs-compressed ISO from it. I chose it because it's the lowest-level, most transparent build tool available for this purpose."*

**Q: "What's the difference between this and just downloading a distro and customizing it?"**
> *"This is a build system, not a customization. When I run `mkarchiso`, it downloads packages from Arch's servers, installs them into a clean chroot environment, overlays my configuration files, compresses the filesystem with squashfs, and burns a bootable ISO. Every single component is explicitly declared and intentional. There is no mystery software — I know exactly what every byte in this ISO comes from."*

**Q: "How is this different from just a VM snapshot?"**
> *"A VM snapshot is a binary blob tied to one virtualization platform. This is a standards-compliant bootable ISO image that follows the El Torito/UEFI specification and boots on real physical hardware. It's architecture-portable and hardware-agnostic."*

**Q: "How does the AI stack work locally without internet?"**
> *"Ollama is a container-like runtime that runs Large Language Models (LLMs) locally on the CPU or GPU. The models are quantized (compressed using techniques like Q4_K_M quantization) to run on consumer hardware. Aider connects to Ollama's local API — which mimics the OpenAI API interface — so the AI coding assistant works completely offline."*

### Step 6.5 — Documents to Prepare for Submission

Prepare these as part of your academic submission:

```
Umbrella OS — Academic Submission Package
├── README.md                        ← This file
├── report/
│   ├── project-report.pdf           ← Full technical report (20-30 pages)
│   ├── synopsis.pdf                 ← 2-page project synopsis
│   └── presentation.pptx            ← Slide deck for viva
├── src/
│   └── umbrella-os-build/           ← Full archiso profile source
├── screenshots/
│   ├── 01-grub-theme.png
│   ├── 02-plymouth-animation.png
│   ├── 03-sddm-login.png
│   ├── 04-desktop.png
│   ├── 05-konsole-terminal.png
│   ├── 06-java-demo.png
│   ├── 07-python-demo.png
│   ├── 08-ollama-demo.png
│   └── 09-aider-demo.png
└── iso/
    └── [LINK TO ISO DOWNLOAD]       ← ISO too large for Git; host on Drive
```

---

## Project File Structure

Complete reference of every file in the Umbrella OS build system:

```
umbrella-os-build/
│
├── profiledef.sh                         # Build profile metadata & settings
├── packages.x86_64                       # All packages to install in ISO
├── pacman.conf                           # Pacman configuration for build
│
├── airootfs/                             # BECOMES the root filesystem
│   ├── etc/
│   │   ├── hostname                      # "umbrella-os"
│   │   ├── hosts                         # /etc/hosts entries
│   │   ├── locale.conf                   # Language settings
│   │   ├── default/
│   │   │   ├── grub                      # GRUB kernel parameters
│   │   │   └── useradd                   # Default shell = zsh
│   │   ├── mkinitcpio.conf               # Initramfs hooks (includes Plymouth)
│   │   ├── pacman.conf                   # In-system pacman config
│   │   ├── shadow                        # Pre-hashed passwords (live user)
│   │   └── skel/                         # ← SKELETON FOR NEW USERS
│   │       ├── .zshrc                    # Zsh config + Umbrella banner
│   │       ├── .p10k.zsh                 # Powerlevel10k prompt config
│   │       ├── .gitconfig                # Git global config
│   │       ├── .tmux.conf                # Tmux configuration
│   │       ├── .oh-my-zsh/              # Oh My Zsh installation
│   │       ├── .config/
│   │       │   ├── fastfetch/            # Fastfetch system info config
│   │       │   │   ├── config.jsonc
│   │       │   │   └── umbrella-logo.txt
│   │       │   ├── Code/User/
│   │       │   │   └── settings.json     # VS Code settings
│   │       │   ├── aider/
│   │       │   │   └── .aider.conf.yml  # Aider AI config
│   │       │   ├── plasmarc              # KDE Plasma settings
│   │       │   ├── kdeglobals            # KDE global appearance
│   │       │   ├── kwinrc                # KWin window manager
│   │       │   └── konsolerc             # Konsole settings
│   │       └── .local/share/
│   │           ├── konsole/
│   │           │   ├── RedQueen.profile  # Konsole terminal profile
│   │           │   └── RedQueen.colorscheme
│   │           └── wallpapers/
│   │               └── UmbrellaOS/       # Custom wallpaper images
│   │
│   ├── usr/
│   │   ├── local/bin/
│   │   │   └── umbrella-post-install.sh  # Post-install AUR/Ollama setup
│   │   └── share/
│   │       ├── plymouth/themes/
│   │       │   └── umbrella-boot/        # Custom Plymouth theme
│   │       │       ├── umbrella-boot.script
│   │       │       ├── background.png
│   │       │       └── umbrella_logo.png
│   │       ├── sddm/themes/
│   │       │   └── umbrella-sddm/        # Custom SDDM login theme
│   │       └── wallpapers/
│   │           └── UmbrellaOS/           # System-wide wallpapers
│   │
│   └── boot/
│       └── grub/themes/
│           └── umbrella/                 # GRUB boot theme
│               ├── theme.txt
│               ├── background.png
│               └── *.png                 # Theme graphics
│
├── grub/
│   └── grub.cfg                          # GRUB menu configuration for ISO
│
├── efiboot/
│   └── loader/
│       └── entries/                      # systemd-boot entries (backup)
│
└── syslinux/                             # Legacy BIOS boot configuration
    └── archiso.cfg
```

---

## Troubleshooting Reference

### Build-Time Issues

```bash
# Issue: "error: target not found: <packagename>"
# Fix: The package doesn't exist in Arch repos. Find the correct name:
pacman -Ss <search_term>
# Or check: https://archlinux.org/packages/

# Issue: Build fails with "could not satisfy dependencies"
# Fix: A package in packages.x86_64 has conflicting dependencies
# Check the conflict:
sudo pacman -Sdd <package1> <package2>

# Issue: "failed to prepare transaction: invalid or corrupted package"
# Fix: Refresh keyring on host
sudo pacman -Sy archlinux-keyring
sudo pacman -Syu

# Issue: Build runs out of space
# Fix: Specify a working directory with more space
sudo mkarchiso -v -w /mnt/large-disk/umbrella-work -o ~/output ~/umbrella-os-build/
```

### Boot-Time Issues

```bash
# Issue: GRUB theme doesn't load, just shows text menu
# Fix: background.png is missing or wrong dimensions
# GRUB requires exact pixel-perfect PNG files — use GIMP to export correctly
# Recommended: 1920x1080 PNG, 24-bit color, no alpha channel

# Issue: Plymouth shows black screen
# Fix: Plymouth not added to mkinitcpio hooks
nano airootfs/etc/mkinitcpio.conf
# Ensure HOOKS contains: ... plymouth ... after base udev
# Example: HOOKS=(base udev plymouth autodetect ...)

# Issue: System boots to black screen after Plymouth
# Fix: SDDM not starting — check service symlink
ls -la airootfs/etc/systemd/system/display-manager.service
# Should be a symlink to /usr/lib/systemd/system/sddm.service
```

### Desktop-Time Issues

```bash
# Issue: KDE starts but theme is default (Breeze), not custom
# Fix: skel files are not being applied
# Cause 1: The live user's home already existed before skel was populated
# Fix:  In the live environment, the user is "arch" — check if
#       /etc/skel is populated correctly in the ISO
ls ~/umbrella-os-build/airootfs/etc/skel/

# Cause 2: KDE reads config from dconf before the rc files
# Fix: Remove any dconf/user binary from skel

# Issue: Konsole opens with default theme, not Red Queen
# Fix: The profile wasn't set as default in konsolerc
nano ~/umbrella-os-build/airootfs/etc/skel/.config/konsolerc
# Add:
# [Desktop Entry]
# DefaultProfile=RedQueen.profile

# Issue: Wallpaper is black/not loading
# Fix: Wallpaper path in plasmarc is hardcoded to your username
grep -r "$(whoami)" ~/umbrella-os-build/airootfs/etc/skel/
# Fix any paths that reference your specific username
```

---

## OS Concepts Demonstrated

This section maps Umbrella OS's implementation to textbook OS concepts for academic reference:

### 1. Boot Process (Bootstrap Sequence)
The complete Linux boot chain is implemented and customized at every stage:
- **Stage 1:** BIOS/UEFI firmware loads the GRUB bootloader from MBR/ESP
- **Stage 2:** GRUB loads `vmlinuz` (compressed kernel) and `initramfs`
- **Stage 3:** The kernel decompresses, initializes hardware, mounts initramfs
- **Stage 4:** Plymouth provides graphical splash from initramfs
- **Stage 5:** systemd PID 1 takes over, manages all service startup
- **Stage 6:** SDDM starts, provides graphical login
- **Stage 7:** KDE Plasma session manager initializes the desktop

### 2. File System Hierarchy Standard (FHS)
Umbrella OS strictly follows the Linux FHS:
- `/boot` — Kernel, initramfs, bootloader
- `/usr` — User programs and shared data (read-only in production)
- `/etc` — System-wide configuration
- `/home` — User home directories
- `/var` — Variable data (logs, spool)
- `/tmp` — Temporary files (tmpfs — RAM-backed)
- `/proc`, `/sys` — Virtual filesystems exposing kernel data

### 3. Init System & Service Management
Systemd is configured with explicit service declarations:
```bash
# Viewing the service dependency tree
systemd-analyze plot > boot-analysis.svg

# Critical services and their dependencies
systemctl list-dependencies sddm.service
systemctl list-dependencies NetworkManager.service
```

### 4. Package Management
Pacman implements a SAT-solver based dependency resolver. The ISO demonstrates:
- Declarative package specification (`packages.x86_64`)
- Binary package management (`.pkg.tar.zst` format)
- Repository signing and signature verification (GPG)
- Dependency graph resolution at build time

### 5. Process Isolation & Containerization
Docker (pre-installed) demonstrates OS-level process isolation using:
- **Namespaces:** PID, NET, MNT, UTS, IPC isolation
- **cgroups:** CPU and memory resource limits
- **Union filesystems:** OverlayFS for efficient container layers

---

## Acknowledgements & References

### Technologies Used

| Technology | Purpose | Documentation |
|---|---|---|
| **Arch Linux** | Base distribution | https://wiki.archlinux.org |
| **archiso** | ISO build framework | https://wiki.archlinux.org/title/Archiso |
| **KDE Plasma** | Desktop environment | https://kde.org/plasma-desktop |
| **GRUB2** | Bootloader | https://www.gnu.org/software/grub/manual |
| **Plymouth** | Boot splash | https://www.freedesktop.org/wiki/Software/Plymouth |
| **SDDM** | Display manager | https://github.com/sddm/sddm |
| **Ollama** | Local LLM runner | https://ollama.com/docs |
| **Aider** | AI pair programmer | https://aider.chat |
| **Claude Code** | AI coding assistant | https://docs.anthropic.com/claude-code |
| **Oh My Zsh** | Zsh framework | https://ohmyz.sh |
| **Powerlevel10k** | Zsh prompt theme | https://github.com/romkatv/powerlevel10k |
| **Papirus Icons** | Icon theme | https://github.com/PapirusDevelopmentTeam/papirus-icon-theme |
| **JetBrains Mono** | Developer font | https://www.jetbrains.com/lp/mono |

### Academic References

- Arpaci-Dusseau, R. H., & Arpaci-Dusseau, A. C. (2018). *Operating Systems: Three Easy Pieces*. Arpaci-Dusseau Books.
- Love, R. (2010). *Linux Kernel Development (3rd ed.)*. Addison-Wesley.
- Ward, B. (2021). *How Linux Works: What Every Superuser Should Know (3rd ed.)*. No Starch Press.
- Nemeth, E., et al. (2017). *UNIX and Linux System Administration Handbook (5th ed.)*. Addison-Wesley.
- Arch Linux Wiki: https://wiki.archlinux.org *(primary technical reference)*

### Inspiration

- **Resident Evil / Biohazard** franchise by Capcom for the Umbrella Corporation aesthetic
- **The Arch Way** — simplicity, modernity, user-centricity, versatility, openness
- **Garuda Linux, EndeavourOS, CachyOS** — inspiration as Arch-based custom distributions

---

<div align="center">

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    UMBRELLA CORPORATION — PROTECTING TOMORROW'S WORLD, TODAY.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
       Built for Final Year Academic Project  |  Final Year Academic Project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

*"The right tool for the right job. The right OS for the right developer."*

</div>
