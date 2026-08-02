# Development Guidelines, Boundaries & Quality Standards: Umbrella OS

| Document Metadata | Specification |
| --- | --- |
| **System Name** | Umbrella OS |
| **Document Type** | Development Rules, Standards & AI Boundaries |
| **Version** | 1.0.0-ACADEMIC |
| **Scope** | Core OS Developers, System Maintainers, AI Coding Agents |

---

## 1. Core Engineering Principles (What We Use & Do)

To maintain system determinism, stability, and aesthetic integrity across builds, all system modifications must follow these core engineering principles.

### 1.1 Declarative Package & Configuration Management
* **Declarative Manifests:** Package inclusions must be specified in [`archiso/packages.x86_64`](file:///home/aakash/Code/CODE-SOURCE/Umbrella-Corporation_OS/archiso/packages.x86_64). Avoid adding ad-hoc installation steps inside post-install scripts unless the package is unavailable in official repositories.
* **Skeletal Home Provisioning:** User configurations (dotfiles, terminal profiles, editor settings) must reside within `airootfs/etc/skel/`. This ensures every new user account automatically inherits system dotfiles without requiring runtime execution scripts.
* **Explicit Permission Mapping:** File ownership and access permissions must be declared explicitly in [`archiso/profiledef.sh`](file:///home/aakash/Code/CODE-SOURCE/Umbrella-Corporation_OS/archiso/profiledef.sh) under `file_permissions`.

### 1.2 System Service & Runtime Decoupling
* **Isolated Background Daemons:** Runtimes such as Docker Engine (`docker.service`) and local AI inference (`ollama.service`) must run as decoupled systemd services enabled via `airootfs/etc/systemd/system/multi-user.target.wants/`.
* **Dynamic Environment Binding:** Environment variables (`JAVA_HOME`, `PYTHONPATH`, `OLLAMA_HOST`) must be exported dynamically inside `/etc/skel/.zshrc` using `$HOME` references rather than fixed user paths.

### 1.3 Recommended Developer Workflow

```mermaid
graph TD
    A[Identify System Need] --> B{Modification Type?}
    
    B -->|New Package| C[Add to packages.x86_64]
    B -->|User Config / Dotfile| D[Place in airootfs/etc/skel/]
    B -->|System File Permission| E[Update profiledef.sh permissions]
    B -->|Theme / Graphic Asset| F[Add to assets/ & Update Configs]

    C --> G[Validate pacman.conf syntax]
    D --> H[Verify dynamic variable usage]
    E --> I[Validate file_permissions array]
    F --> J[Check resolution & compression]

    G --> K[Run mkarchiso Test Build]
    H --> K
    I --> K
    J --> K

    K --> L{Build Successful?}
    L -->|Yes| M[Commit to Git Main Branch]
    L -->|No| N[Inspect Build Logs & Apply Patch Boundary]
```

---

## 2. Architectural Anti-Patterns (What to Avoid)

Senior systems engineering standards prohibit practices that introduce non-deterministic behavior, build fragility, or security vulnerabilities.

```mermaid
graph LR
    subgraph Prohibited Anti-Patterns
        A1[Hardcoded User Paths]
        A2[Direct LLM Weights Bundling]
        A3[Monolithic First-Boot Scripts]
        A4[Silent Error Suppression]
        A5[Unsigned Third-Party Packages]
    end

    subgraph Architectural Standards
        B1[Dynamic $HOME Environment Variables]
        B2[On-Demand Model Download / Mounting]
        B3[Modular Systemd Target Units]
        B4[Explicit Exit Codes & Failure Logs]
        B5[Official Repositories & Verified Keys]
    end

    A1 -->|Replace With| B1
    A2 -->|Replace With| B2
    A3 -->|Replace With| B3
    A4 -->|Replace With| B4
    A5 -->|Replace With| B5
```

### 2.1 Critical Anti-Patterns Checklist

| Anti-Pattern | Reason for Exclusion | Approved Replacement |
| --- | --- | --- |
| **Hardcoded Home Paths** (`/home/live/` or `/home/user/`) | Breaks user portability when ISO boots under different usernames or installs to disk. | Use `$HOME`, `~`, or relative skeletal paths in `/etc/skel/`. |
| **Direct AI Model Weights Bundling** | Including Multi-GB model weights (e.g. Llama 3.2 8B) inflates ISO size beyond the 8GB limit. | Ship Ollama binary and service daemon; fetch models post-boot or via volume mounts. |
| **Monolithic Setup Scripts** | Single large shell scripts executing all startup setup lead to race conditions and unhandled failures. | Use native systemd service targets and modular scripts with strict error checking (`set -euo pipefail`). |
| **Silent Error Masking (`|| true`)** | Masking non-zero exit codes in build scripts obscures broken package builds and corrupted configs. | Allow explicit script termination, capture error logs, and fix root cause contracts. |
| **Ad-Hoc Modifications Outside Chroot** | Modifying host machine files during ISO build phase corrupts build environment integrity. | Confine all filesystem operations strictly within the `airootfs` directory layout. |

---

## 3. Libraries, Packages & Dependency Boundaries

To maintain a clean academic and production-ready distribution, system dependencies are classified into strict dependency tiers:

```mermaid
mindmap
  root((Umbrella OS Stack))
    Base Core
      Arch Linux Base
      Linux Kernel
      Systemd Engine
    Build Engine
      Archiso
      SquashFS XZ
      Libisoburn
    User Workspace
      KDE Plasma 6
      SDDM Manager
      Plymouth Engine
      Konsole & Zsh
    Developer Toolchain
      JDK 21 LTS
      Python 3.12
      Docker Engine
      VS Code
    AI Infrastructure
      Ollama Service
      Aider CLI
      Claude Code CLI
      PyTorch & Transformers
```

### 3.1 Tier Classification Rules

1. **Tier 1: Core System & Bootloader (Immutable Base)**
   - Includes `base`, `linux`, `linux-firmware`, `archiso`, `grub`, `efibootmgr`, `systemd`.
   - *Rule:* Must not be modified or replaced with custom forks without full regression testing.

2. **Tier 2: Desktop & User Experience (Branding Layer)**
   - Includes `plasma-desktop`, `sddm`, `plymouth`, `konsole`, `zsh`, `papirus-icon-theme`.
   - *Rule:* Configured purely via configuration overlays inside `airootfs/etc/skel/` and `airootfs/etc/sddm.conf.d/`.

3. **Tier 3: Software Engineering Runtimes (Developer Layer)**
   - Includes `jdk21-openjdk`, `python`, `python-pip`, `docker`, `docker-compose`, `code`, `git`, `maven`, `gradle`.
   - *Rule:* Installed globally via declarative package manifests; environment variables exported in `/etc/skel/.zshrc`.

4. **Tier 4: Artificial Intelligence Stack (AI Infrastructure Layer)**
   - Includes `ollama`, `aider`, `@anthropic-ai/claude-code`, `python-pytorch`, `python-transformers`.
   - *Rule:* Services enabled via systemd symlinks; configuration defaults stored under `/etc/skel/.config/aider/`.

---

## 4. Error Handling Boundaries & AI Safety Protocols

When human developers or AI agents modify the codebase, strict safety rules enforce validation before declaring any task complete.

```mermaid
flowchart TD
    Start[Modification Triggered] --> CheckType{File Category?}

    CheckType -->|Shell Script .sh| AuditShell[Syntax Check: bash -n script.sh]
    CheckType -->|Archiso Profile| AuditProfile[Validate file_permissions syntax]
    CheckType -->|Packages List| AuditPackages[Check duplicates: sort & uniq]
    CheckType -->|Config / Dotfile| AuditConfig[Verify no hardcoded paths]

    AuditShell --> RunValidation{Validation Passed?}
    AuditProfile --> RunValidation
    AuditPackages --> RunValidation
    AuditConfig --> RunValidation

    RunValidation -->|No| FixError[Report Traceback & Apply Surgical Fix]
    FixError --> Start

    RunValidation -->|Yes| GitStatus[Check Git Status & Integrity]
    GitStatus --> Success[Validation Complete]
```

### 4.1 AI Agent & Developer Execution Boundaries

1. **Traceback-Driven Diagnosis:**
   - Never guess failure causes. Read the exact stdout/stderr logs from `mkarchiso` or script executions before modifying code.

2. **No Superficial Symptom Patches:**
   - Never suppress errors by adding `2>/dev/null` or `|| exit 0` to broken build commands. Fix the underlying file permission, package name, or configuration key.

3. **Mandatory Runtime & Build Verification:**
   - Editing a file does not complete a task. Shell scripts must be tested using `bash -n`, configuration files validated against schemas, and `profiledef.sh` verified against actual files in `airootfs`.

4. **Surgical File Edits:**
   - Modify only the target lines or blocks required for the feature or fix. Preserve existing docstrings, comments, and licensing headers.

5. **Permission Synchronization:**
   - Whenever an executable script is added to `airootfs/usr/local/bin/` or `airootfs/root/`, it MUST be registered in `archiso/profiledef.sh` under `file_permissions` with mode `0755`.
