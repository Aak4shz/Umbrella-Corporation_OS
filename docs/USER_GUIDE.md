# Umbrella OS — User Guide & Installation Manual

## 1. System Overview

**Umbrella OS** is an academic-grade, specialized developer distribution based on Arch Linux. Tailored for software engineers, machine learning practitioners, and AI security researchers, Umbrella OS pairs zero-configuration workstation aesthetics (Red Queen Crimson Palette) with pre-bundled local AI runtimes and containerized development stacks.

---

## 2. Key System Features

* **Desktop Environment**: Custom KDE Plasma 6 setup with translucent dark-red panel, Red Queen Konsole profile, and JetBrains Mono Nerd Font.
* **Local AI Inference Engine**: Pre-installed `ollama` background service (`ollama.service`) configured for offline LLM execution.
* **AI Coding Workflows**: Pre-configured `aider` CLI (`.aider.conf.yml`) linked to local Ollama API endpoints (`http://127.0.0.1:11434/v1`).
* **Developer Runtimes**: Out-of-the-box support for Java 21 LTS (`JAVA_HOME`), Python 3 ML stack (`numpy`, `pandas`, `pytorch`, `fastapi`, `uvicorn`), Node.js, Docker, and Git tooling.
* **Privacy & Encrypted Messaging**: Pre-bundled open-source E2EE applications including Signal Desktop, Element (Matrix), Session Messenger (ID-based onion routed), SimpleX Chat (zero user IDs), and Briar (offline mesh network messaging).
* **Branded Terminal & System Info**: Custom `.zshrc` shell profile with Powerlevel10k, Oh-My-Zsh plugins, and custom `fastfetch` system banner.

---

## 3. Installation & Live Session Guide

### Live Boot Session & Default Credentials
1. **Default Live Credentials:**
   * **Username:** `umbrella`
   * **Password:** `umbrella`
   * **Root Password:** `root`
   * **Sudo Access:** Full passwordless administrative privileges (`sudo <command>`)
   * **Auto-Login:** SDDM automatically logs into the `umbrella` KDE Plasma desktop session without requiring credentials.

2. Flash `umbrella-os-1.0.0-x86_64.iso` to a USB drive using `dd` or Ventoy:
   ```bash
   sudo dd if=umbrella-os-1.0.0-x86_64.iso of=/dev/sdX bs=4M status=progress conv=fsync
   ```
3. Boot from USB in UEFI or BIOS mode.
4. System will boot into the Red Queen Plymouth splash screen and auto-login directly to the KDE Plasma live desktop environment.

### Post-Installation & AI Model Provisioning
1. Launch terminal (Konsole or shortcut `Ctrl+Alt+T`).
2. Run the post-install setup helper script:
   ```bash
   umbrella-post-install.sh
   ```
3. Pull your preferred local LLM model using Ollama:
   ```bash
   ollama pull llama3.2
   ```
4. Start an AI pair-programming session with Aider:
   ```bash
   aider
   ```

---

## 4. Useful Command Cheat Sheet

| Command | Action |
| :--- | :--- |
| `ai` | Launch interactive local Ollama shell (`ollama run llama3.2`) |
| `aider` | Start Aider pair programmer pre-pointed to local Ollama |
| `jrun <file.jar>` | Run Java executable JAR file |
| `mci` / `mcp` | Maven clean install / package shortcuts |
| `venv` | Create Python virtual environment (`python3 -m venv venv`) |
| `activate` | Source current python virtual environment (`source ./venv/bin/activate`) |
| `cls` / `ll` / `la` | Modern shell aliases (`clear`, `eza -lh`, `eza -la`) |
