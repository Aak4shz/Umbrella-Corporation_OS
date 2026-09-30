#!/usr/bin/env bash
# ====================================================================
# Umbrella OS - KDE Post-Login Splash Screen Simulator
# ====================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QML_FILE="$SCRIPT_DIR/preview-splash.qml"

echo "========================================================"
echo "  UMBRELLA OS - RED QUEEN POST-LOGIN SPLASH SIMULATOR"
echo "========================================================"
echo "  [+] Loading Splash Screen UI: $QML_FILE"
echo "  [+] Interactive Controls Enabled:"
echo "      - Toggle Logo between Umbrella & Biohazard"
echo "      - Step through Stages 1-6"
echo "      - Auto-Play Boot Sequence"
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
