#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════════
# Umbrella OS — Live SDDM Login Screen Preview Runner
# ════════════════════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QML_FILE="${SCRIPT_DIR}/preview-login.qml"

if ! command -v qml6 &> /dev/null && ! command -v qml &> /dev/null; then
    echo "[ERROR] Qt QML runtime (qml6 or qml) not found."
    exit 1
fi

QML_BIN="$(command -v qml6 || command -v qml)"

echo "▶ Launching Red Queen Login Screen Interactive Preview Window..."
echo "  You can interactively test username, password, and click AUTHENTICATE."
echo "  Press Ctrl+C or close window to exit."

"${QML_BIN}" "${QML_FILE}"
