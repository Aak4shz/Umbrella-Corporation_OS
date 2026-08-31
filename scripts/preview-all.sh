#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════
# Umbrella OS — Master All-in-One Boot Lifecycle Simulator
# ════════════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
QML_FILE="$SCRIPT_DIR/preview-all.qml"

echo "========================================================"
echo "  UMBRELLA OS — MASTER END-TO-END BOOT SIMULATOR"
echo "========================================================"
echo "  [+] Loading All-in-One Lifecycle Simulator: $QML_FILE"
echo "  [+] Stages:"
echo "      1. Plymouth Early Boot Splash (Rotating Biohazard)"
echo "      2. SDDM Login Greeter (Raccoon City Edition)"
echo "      3. Post-Login Native QML Splash (Red Queen AI Core)"
echo "      4. Red Queen Lock Screen UI"
echo "  [+] Use the top switcher bar to jump between any stage!"
echo "  [+] Press Ctrl+C or close window to exit."
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
