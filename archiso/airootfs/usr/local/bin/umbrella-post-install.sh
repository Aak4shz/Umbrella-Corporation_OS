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
    plymouth-theme-hexagon-dots-git || true

# ── Install Ollama ───────────────────────────────────────────────────────
echo "[3/6] Installing Ollama..."
if ! command -v ollama &>/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh || true
    sudo systemctl enable ollama.service || true
fi

# ── Install Aider ────────────────────────────────────────────────────────
echo "[4/6] Installing Aider..."
pip install --user aider-chat || true

# ── Install Claude Code ──────────────────────────────────────────────────
echo "[5/6] Installing Claude Code..."
if ! command -v claude &>/dev/null; then
    npm install -g @anthropic-ai/claude-code || true
fi

# ── Install Oh My Zsh ────────────────────────────────────────────────────
echo "[6/6] Setting up Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
fi

# ── Configure Plymouth ───────────────────────────────────────────────────
sudo plymouth-set-default-theme umbrella-boot 2>/dev/null || true
sudo mkinitcpio -P 2>/dev/null || true

echo ""
echo "   Umbrella OS setup complete!"
echo "   Welcome to Umbrella Corporation's Operating System"
echo ""
echo "  Next steps:"
echo "  1. Run 'ollama pull llama3.2' to download a local AI model"
echo "  2. Set your ANTHROPIC_API_KEY in ~/.zshrc for Claude Code"
echo "  3. Reboot to see the full Plymouth boot animation"
echo ""
