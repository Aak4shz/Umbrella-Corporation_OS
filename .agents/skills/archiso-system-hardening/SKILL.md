---
name: archiso-system-hardening
description: >
  Comprehensive engineering rules and verification workflows for building, customizing,
  and hardening Arch Linux live ISO distributions using the archiso build engine.
  Use this skill whenever modifying archiso configurations (profiledef.sh, pacman.conf, packages.x86_64),
  auditing /etc/skel user profiles, configuring systemd services, ordering initramfs hooks (mkinitcpio),
  integrating Plymouth kernel boot splash, or troubleshooting ISO build and QEMU boot issues.
---

# Archiso System Hardening & Live Distro Engineering Skill

This skill provides deterministic systems engineering patterns for mastering Archiso-based Linux distributions, guaranteeing reproducible builds, zero-leak live boot initialization, and rock-solid system integrity.

---

## 1. Archiso Profile Directory Structure

```text
archiso/
├── profiledef.sh              # Master ISO metadata, file permissions matrix & boot modes
├── pacman.conf                # Pacman mirrorlist, multilib, and repository configs
├── packages.x86_64            # Flat declarative list of packages to install
├── syslinux/                  # BIOS legacy bootloader configs & themes
├── grub/                      # UEFI bootloader configs & themes
└── airootfs/                  # Root filesystem overlay applied to live environment
    ├── etc/
    │   ├── skel/              # User profile skeleton copied to /home/umbrella on creation
    │   ├── sudoers.d/         # Strict permission (0:0:440) sudo rule definitions
    │   ├── mkinitcpio.conf.d/ # Early boot initramfs hooks (kms, plymouth, udev)
    │   └── systemd/system/    # System services (sddm, ollama, docker, pipewire)
    └── usr/share/             # Visual assets, wallpapers, Plymouth & SDDM themes
```

---

## 2. Critical Determinism & Permission Rules

### 2.1 Sudoers Permission Lockdown
In `archiso/profiledef.sh`, sudoers files **MUST** carry strict `440` octal permissions:
```bash
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/sudoers.d/umbrella"]="0:0:440"
  ["/root"]="0:0:750"
)
```
* **Anti-Pattern:** Never set `0644` or `0755` on `/etc/sudoers.d/umbrella`. Loose permissions cause `sudo: /etc/sudoers.d/umbrella is world writable` errors, breaking live user privilege escalation.

### 2.2 Clean Overlayfs Isolation
Never edit build cache directories (`work/` or `/tmp/archiso-tmp`) directly. All configuration changes must be made exclusively inside `archiso/airootfs/`.

---

## 3. Early Boot & Plymouth KMS Hook Ordering

To achieve **100% flicker-free silent boot**, the `mkinitcpio` hook order and kernel parameters must be synchronized:

### 3.1 Hook Ordering (`mkinitcpio.conf`)
```text
HOOKS=(base udev plymouth autodetect modconf kms block filesystems keyboard fsck)
```
* `plymouth` must immediately follow `udev` to take control of the display buffer before kernel text prints.

### 3.2 Kernel Boot Parameters (GRUB & Syslinux)
```text
quiet splash loglevel=3 rd.udev.log_priority=3 udev.log_priority=3 vt.global_cursor_default=0 systemd.show_status=auto
```

---

## 4. Deterministic ISO Compilation & Testing Pipeline

```bash
# 1. Clean stale temporary work trees
sudo rm -rf /tmp/archiso-tmp ./work

# 2. Build release ISO with verbose tracing
sudo mkarchiso -v -w /tmp/archiso-tmp -o ./out ./archiso

# 3. Test compiled image in QEMU VM (UEFI mode)
./scripts/run-qemu.sh uefi

# 4. Generate SHA-256 integrity hash
sha256sum ./out/umbrella-os-1.0.0-x86_64.iso > ./out/umbrella-os-1.0.0-x86_64.iso.sha256
```
