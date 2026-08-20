# Umbrella OS — Live User, Authentication & Auto-Login Implementation Plan

| **Document Type** | Systems Engineering & Authentication Plan |
| **Target Version** | `1.0.0-ACADEMIC` |
| **Component** | Live User Identity, SDDM Auto-Login & Privilege Escalation |
| **Status** | `[COMPLETED]` |
| **Last Updated** | August 2026 |

---

## 1. Executive Summary & Objective

Currently, the live ISO boots directly into SDDM (Simple Desktop Display Manager) without a designated standard live user account or autologin configuration. Because KDE Plasma restricts logging in directly as `root` and no non-root user (e.g., `umbrella`) was provisioned with valid credentials, the system halted at the SDDM login screen, preventing access to the Red Queen desktop environment.

**Primary Objectives:**
1. Provision a standard live user (`umbrella`) with default password (`umbrella`).
2. Configure **SDDM auto-login** directly into KDE Plasma (`plasma.desktop`) for a seamless zero-login live experience.
3. Configure **passwordless `sudo`** privileges for administrative commands and post-installation workflows.
4. Establish full group memberships (audio, video, input, storage, network) to grant hardware acceleration and device permissions.
5. Update Archiso master permission matrix (`profiledef.sh`) and sync all project documentation.

---

## 2. Technical Specification & Credential Matrix

| Parameter | Configuration Value | Target Path / Service |
| :--- | :--- | :--- |
| **Live Username** | `umbrella` | `/etc/passwd` |
| **User ID / Group ID** | `UID: 1000` / `GID: 1000` | `/etc/passwd`, `/etc/group` |
| **Full Name / GECOS** | `Umbrella Corporation Live User` | `/etc/passwd` |
| **Default Password** | `umbrella` | `/etc/shadow` (SHA-512 crypt hash) |
| **User Shell** | `/usr/bin/zsh` | `/etc/passwd` |
| **User Home Dir** | `/home/umbrella` | Profile & `/etc/skel` provisioning |
| **Root Password** | `root` (SHA-512 crypt hash) | `/etc/shadow` |
| **Sudo Privileges** | `NOPASSWD: ALL` | `/etc/sudoers.d/umbrella` (`0440`) |
| **Display Manager Autologin** | User: `umbrella`, Session: `plasma` | `/etc/sddm.conf.d/autologin.conf` |
| **TTY Console Autologin** | User: `umbrella` | `/etc/systemd/system/getty@tty1.service.d/autologin.conf` |

---

## 3. Step-by-Step Action Items & Execution Tracking

### Phase A: User Accounts & Group Provisioning
- [x] **Task 1: User Account Definition in `/etc/passwd`**
  - Defined `root` (UID 0) and `umbrella` (UID 1000) accounts with `/usr/bin/zsh` shell.
  - Target file: `archiso/airootfs/etc/passwd`
- [x] **Task 2: Password Hash Generation in `/etc/shadow`**
  - Set SHA-512 hashed password for `umbrella` (`umbrella`) and `root` (`root`).
  - Target file: `archiso/airootfs/etc/shadow`
- [x] **Task 3: Group Memberships in `/etc/group` and `/etc/gshadow`**
  - Created standard groups: `umbrella`, `wheel`, `video`, `audio`, `storage`, `input`, `power`, `network`, `rfkill`, `optical`, `adm`.
  - Added `umbrella` to all critical hardware and administration groups.
  - Target files: `archiso/airootfs/etc/group`, `archiso/airootfs/etc/gshadow`

---

### Phase B: Privilege Escalation & Display Manager Autologin
- [x] **Task 4: Sudoers Configuration**
  - Granted full passwordless sudo access to `umbrella` and members of `%wheel`.
  - Target file: `archiso/airootfs/etc/sudoers.d/umbrella`
- [x] **Task 5: SDDM Display Manager Auto-Login Configuration**
  - Created SDDM autologin drop-in configuration for instant graphical desktop boot.
  - Target file: `archiso/airootfs/etc/sddm.conf.d/autologin.conf`
- [x] **Task 6: TTY1 Console Auto-Login Update**
  - Updated getty autologin service to target `umbrella` instead of `root`.
  - Target file: `archiso/airootfs/etc/systemd/system/getty@tty1.service.d/autologin.conf`

---

### Phase C: File Permissions & Archiso Matrix
- [x] **Task 7: Archiso `profiledef.sh` Security Matrix Update**
  - Added exact permission bits for `/etc/shadow` (`400`), `/etc/gshadow` (`400`), `/etc/sudoers.d/umbrella` (`440`), `/usr/local/bin/umbrella-live-init.sh` (`755`).
  - Target file: `archiso/profiledef.sh`
- [x] **Task 8: User Profile & `$HOME` Skeleton Verification**
  - Created `umbrella-live-init.service` and `umbrella-live-init.sh` to guarantee `/home/umbrella` initialization and permissions.

---

### Phase D: Documentation, Build & QA Verification
- [x] **Task 9: Documentation Updates**
  - Updated `docs/USER_GUIDE.md` with default username & password credentials (`umbrella` / `umbrella`).
  - Updated `docs/VIVA_PREPARATION.md` with viva Q&A regarding live user provisioning and SDDM autologin architecture.
- [x] **Task 10: Syntax & Pre-flight Verification**
  - Ran bash and configuration lint checks across all modified files.
- [ ] **Task 11: ISO Recompilation & VM Testing**
  - Ready for `mkarchiso` build and boot verification in QEMU VM.

---

## 4. Execution Log

| Date | Task ID | Description | Result / Note |
| :--- | :--- | :--- | :--- |
| Aug 2026 | Plan Created | Created live user & autologin implementation plan | Initialized |
| Aug 2026 | Tasks 1-3 | Configured `/etc/passwd`, `/etc/shadow`, `/etc/group`, `/etc/gshadow` | Completed & Verified |
| Aug 2026 | Tasks 4-6 | Configured `sudoers.d/umbrella`, SDDM `autologin.conf`, and getty TTY1 | Completed & Verified |
| Aug 2026 | Tasks 7-8 | Updated `profiledef.sh` permissions & created `umbrella-live-init` unit | Completed & Verified |
| Aug 2026 | Tasks 9-10 | Updated `USER_GUIDE.md`, `VIVA_PREPARATION.md` & executed syntax checks | All Passed |
