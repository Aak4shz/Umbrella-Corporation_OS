#!/bin/bash
# ==============================================================================
# umbrella-post-install.sh
# Post-installation configuration for AUR packages, Ollama, and developer tools
# ==============================================================================

set -e

echo ""
echo "  [Umbrella OS] Post-Install Setup"
echo "  Version 1.0.0"
echo "  Configuring developer workstation environment..."
echo ""

# -- Install yay (AUR helper) --------------------------------------------------
echo "[1/5] Installing yay AUR helper..."
if ! command -v yay &>/dev/null; then
    BUILD_DIR=$(mktemp -d /tmp/umbrella-yay-XXXXXX)
    git clone https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"
    (cd "$BUILD_DIR/yay" && makepkg -si --noconfirm)
    rm -rf "$BUILD_DIR"
fi

# -- Install AUR packages ------------------------------------------------------
echo "[2/5] Installing AUR packages & Privacy Tools..."
yay -S --noconfirm \
    lightly-qt \
    powerlevel10k \
    visual-studio-code-bin \
    lazygit \
    gotop \
    session-desktop-bin \
    simplex-chat-desktop-bin \
    briar-gtk \
    plymouth-theme-hexagon-dots-git || true

# -- Install Ollama ------------------------------------------------------------
echo "[3/5] Configuring Ollama..."
if ! command -v ollama &>/dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh || true
fi
sudo systemctl enable ollama.service || true

# -- Install Aider -------------------------------------------------------------
echo "[4/5] Configuring Aider pair programmer..."
python3 -m pip install --user --break-system-packages aider-chat || true

# -- Configure Zsh as default shell --------------------------------------------
echo "[5/5] Setting up Zsh & Oh My Zsh..."
sudo chsh -s /bin/zsh "$USER" 2>/dev/null || chsh -s /bin/zsh 2>/dev/null || true
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended || true
fi

# -- Configure Plymouth --------------------------------------------------------
sudo plymouth-set-default-theme umbrella-plymouth 2>/dev/null || true
sudo mkinitcpio -P 2>/dev/null || true

echo ""
echo "   Umbrella OS setup complete!"
echo "   Welcome to Umbrella Corporation Operating System"
echo ""
echo "  Next steps:"
echo "  1. Run 'ollama pull llama3.2' to download a local AI model"
echo "  2. Reboot to see the full Plymouth boot animation"
echo ""

