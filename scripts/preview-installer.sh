#!/usr/bin/env bash
# ====================================================================
# Umbrella OS - Calamares Installer Interactive Simulator (8 Sections)
# ====================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QML_FILE="$SCRIPT_DIR/preview-installer.qml"

echo "========================================================================"
echo "    UMBRELLA OS - CALAMARES INSTALLER INTERACTIVE SIMULATOR (Qt6 QML)"
echo "========================================================================"
echo "  [+] Loading Interactive Calamares UI: $QML_FILE"
echo "  [+] Full 8-Section Flow Implemented:"
echo "      [1] Welcome    - Language, Hardware Diagnostics, Hive Directive"
echo "      [2] Location   - Geo-coordinates, World Map HUD, Real-time Clock"
echo "      [3] Keyboard   - Layout, Virtual Visualizer, Live Keystroke Test"
echo "      [4] Partitions - Erase Disk, Dual-boot, Btrfs Subvolumes & Diagram"
echo "      [5] Users      - User Account, Hostname, Password Strength & Match"
echo "      [6] Summary    - Full Deployment Audit & Safety Warning Confirmation"
echo "      [7] Install    - Dynamic 0-100% Progress, Slideshow, Live Logs Drawer"
echo "      [8] Finish     - Deployment Complete, Reboot Option & Shutdown Modal"
echo "------------------------------------------------------------------------"
echo "  [+] Controls:"
echo "      - Keys [1] to [8]: Direct Quick-Jump to any of the 8 sections"
echo "      - Mouse: Click on any step in left sidebar, or use Back / Next"
echo "      - Arrow Keys [Left / Right]: Change Slide (in Install section)"
echo "      - Spacebar: Toggle Slideshow Auto-Play"
echo "      - F11: Toggle Fullscreen"
echo "      - Esc: Exit Simulator"
echo "========================================================================"

cd "$SCRIPT_DIR"

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
