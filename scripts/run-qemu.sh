#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════════
# Umbrella OS — Pre-flight QEMU ISO Verification Script
# Usage: ./scripts/run-qemu.sh [uefi|bios] [iso_path]
# ════════════════════════════════════════════════════════════════════════════

set -e

MODE="${1:-uefi}"
ISO_PATH="${2:-./out/umbrella-os-1.0.0-x86_64.iso}"
RAM="4096"
CPUS="4"

if [ ! -f "$ISO_PATH" ]; then
    echo -e "\e[31m[ERROR] ISO image not found at '$ISO_PATH'\e[0m"
    echo -e "\e[33mPlease compile the ISO first using:\e[0m"
    echo "  sudo mkarchiso -v -w /tmp/archiso-tmp -o ./out ./archiso"
    exit 1
fi

echo -e "\e[34m[INFO] Launching Umbrella OS in QEMU VM ($MODE mode)..."
echo -e "[INFO] ISO: $ISO_PATH | RAM: ${RAM}MB | CPUs: $CPUS\e[0m"

QEMU_CMD="qemu-system-x86_64 -enable-kvm -m $RAM -smp $CPUS -cdrom $ISO_PATH -vga virtio -display default,show-cursor"

if [ "$MODE" == "uefi" ]; then
    if [ -f "/usr/share/edk2-ovmf/x64/OVMF_CODE.fd" ]; then
        QEMU_CMD="$QEMU_CMD -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd"
    elif [ -f "/usr/share/ovmf/x64/OVMF_CODE.fd" ]; then
        QEMU_CMD="$QEMU_CMD -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF_CODE.fd"
    else
        echo -e "\e[33m[WARNING] OVMF firmware file not found in standard paths. Falling back to BIOS mode.\e[0m"
    fi
fi

echo -e "\e[32m[EXEC] $QEMU_CMD\e[0m"
exec $QEMU_CMD
