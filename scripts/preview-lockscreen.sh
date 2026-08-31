#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════
# Umbrella OS — Live Lock Screen Preview Runner
# ════════════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
QML_FILE="$SCRIPT_DIR/preview-lockscreen.qml"

echo "========================================================"
echo "  UMBRELLA OS — RED QUEEN LOCK SCREEN SIMULATION"
echo "========================================================"
echo "  [+] Loading Lock Screen UI: $QML_FILE"
echo "  [+] Interactive password testing enabled."
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
