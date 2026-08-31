#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════════
# Umbrella OS — Live Native QML Splash Screen Preview Runner
# ════════════════════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QML_FILE="${SCRIPT_DIR}/preview-splash.qml"

echo "========================================================"
echo "  UMBRELLA OS — RED QUEEN NATIVE SPLASH SIMULATION"
echo "========================================================"
echo "  [+] Loading Splash Screen UI: ${QML_FILE}"
echo "  [+] Staged Plasma boot simulation active."
echo "  [+] Press Ctrl+C or close window to exit."
echo "========================================================"

if command -v qml6 &>/dev/null; then
    qml6 "$QML_FILE"
elif command -v qml &>/dev/null; then
    qml "$QML_FILE"
elif command -v qmlscene &>/dev/null; then
    qmlscene "$QML_FILE"
else
    echo "[!] Error: No Qt6 QML runtime (qml6/qml/qmlscene) found."
    exit 1
fi
