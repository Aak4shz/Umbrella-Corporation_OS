#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════════
# Umbrella OS — Live Plymouth Boot Splash Animation Preview Runner
# ════════════════════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QML_FILE="${SCRIPT_DIR}/preview-plymouth.qml"

if ! command -v qml6 &> /dev/null && ! command -v qml &> /dev/null; then
    echo "[ERROR] Qt QML runtime (qml6 or qml) not found."
    exit 1
fi

QML_BIN="$(command -v qml6 || command -v qml)"

echo "▶ Launching Plymouth 36-Frame Boot Splash Animation Preview Window..."
echo "  Press Ctrl+C or close window to exit."

"${QML_BIN}" "${QML_FILE}"
