#!/usr/bin/env bash
# ====================================================================
# Umbrella OS - Master All-in-One Boot Lifecycle Simulator
# ====================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
QML_FILE="$SCRIPT_DIR/preview-all.qml"

echo "========================================================"
echo "  UMBRELLA OS - MASTER END-TO-END BOOT SIMULATOR"
echo "========================================================"
echo "  [+] Loading All-in-One Lifecycle Simulator: $QML_FILE"
echo "  [+] Stages:"
echo "      1. Plymouth Early Boot Splash (Rotating Spinner & Progress)"
echo "      2. SDDM Login Greeter (Raccoon City Edition)"
echo "      3. KDE Post-Login Splash Screen (Fullscreen Cinematic Umbrella GIF)"
echo "      4. Red Queen Lock Screen UI & Workspace"
echo "  [+] Use the top switcher bar or keys 1-4 to jump between any stage!"
echo "  [+] Press F11 for Fullscreen, Esc or Ctrl+C to exit."
echo "========================================================"

if command -v qml6 &>/dev/null; then
    qml6 "$QML_FILE"
elif command -v qml &>/dev/null; then
    qml "$QML_FILE"
elif command -v qmlscene &>/dev/null; then
    qmlscene "$QML_FILE"
else
    echo "[!] Error: No Qt6 QML runtime (qml6/qml) found."
    exit 1
fi
