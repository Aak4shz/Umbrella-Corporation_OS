import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Shapes

Window {
    id: root
    width: 1040
    height: 680
    minimumWidth: 960
    minimumHeight: 620
    visible: true
    title: "Umbrella OS — Calamares System Installer (Red Queen Edition)"
    color: "#0a0202"

    // ========================================================================
    // GLOBAL KEYBOARD SHORTCUTS
    // ========================================================================
    Shortcut { sequence: "Escape"; onActivated: Qt.quit() }
    Shortcut {
        sequence: "F11"
        onActivated: {
            root.visibility = (root.visibility === Window.FullScreen ? Window.Windowed : Window.FullScreen)
        }
    }
    Shortcut { sequence: "1"; onActivated: root.goToSection(0) }
    Shortcut { sequence: "2"; onActivated: root.goToSection(1) }
    Shortcut { sequence: "3"; onActivated: root.goToSection(2) }
    Shortcut { sequence: "4"; onActivated: root.goToSection(3) }
    Shortcut { sequence: "5"; onActivated: root.goToSection(4) }
    Shortcut { sequence: "6"; onActivated: root.goToSection(5) }
    Shortcut { sequence: "7"; onActivated: root.goToSection(6) }
    Shortcut { sequence: "8"; onActivated: root.goToSection(7) }

    // ========================================================================
    // STATE PROPERTIES & TWO-WAY FORM MODEL
    // ========================================================================
    property int currentSectionIndex: 0
    property int totalSectionsCount: 8

    // Installer Steps definition
    property var stepNames: [
        "Welcome", "Location", "Keyboard", "Partitions",
        "Users", "Summary", "Install", "Finish"
    ]

    // Form data: Section 1 (Welcome)
    property string selectedLanguage: "American English (en_US)"
    property var languageOptions: [
        "American English (en_US)",
        "British English (en_GB)",
        "Hindi (hi_IN)",
        "Deutsch (de_DE)",
        "Français (fr_FR)",
        "Español (es_ES)",
        "日本語 (ja_JP)",
        "Русский (ru_RU)"
    ]

    // Form data: Section 2 (Location)
    property string selectedRegion: "Asia"
    property string selectedZone: "Kolkata"
    property string selectedLocale: "en_IN.UTF-8"
    property var regionsList: ["Asia", "America", "Europe", "Africa", "Australia", "Pacific"]
    property var zonesMap: ({
        "Asia": ["Kolkata", "Tokyo", "Singapore", "Dubai", "Shanghai", "Seoul", "Bangkok"],
        "America": ["New York", "Los Angeles", "Chicago", "Toronto", "Sao Paulo", "Vancouver"],
        "Europe": ["London", "Berlin", "Paris", "Amsterdam", "Moscow", "Rome", "Zurich"],
        "Africa": ["Cairo", "Johannesburg", "Nairobi", "Lagos", "Casablanca"],
        "Australia": ["Sydney", "Melbourne", "Perth", "Brisbane", "Adelaide"],
        "Pacific": ["Auckland", "Honolulu", "Fiji", "Guam"]
    })

    // Form data: Section 3 (Keyboard)
    property string selectedKeyModel: "Generic 105-Key PC (intl.)"
    property string selectedKeyLayout: "English (US)"
    property string selectedKeyVariant: "Default"
    property string keyTestText: "Umbrella Hive Terminal Security Protocol v1.0"
    property string lastPressedKey: ""

    // Form data: Section 4 (Partitions)
    property string selectedTargetDisk: "/dev/nvme0n1 — 512.1 GB Umbrella NVMe SSD (Samsung 990 Pro)"
    property string partitionOption: "erase" // "erase", "alongside", "manual"
    property string selectedFilesystem: "Btrfs (subvolumes: @, @home, @snapshots, zstd)"
    property string selectedSwapOption: "Swap to file (8 GB)"
    property bool encryptSystem: false

    // Form data: Section 5 (Users)
    property string userFullName: "Umbrella Operative"
    property string userName: "umbrella"
    property string hostName: "hive-workstation"
    property string userPassword: "admin"
    property string repeatPassword: "admin"
    property bool autoLogin: false
    property bool rootSamePassword: true
    property string rootPassword: ""
    property string repeatRootPassword: ""
    property bool showPasswordText: false

    // Form data: Section 7 (Install / Slideshow & Logs)
    property int currentSlideIndex: 0
    property int totalSlidesCount: 4
    property bool autoPlayEnabled: true
    property real installProgress: 0.18
    property bool showTerminalLog: false
    property var terminalLogs: [
        "[INFO] Calamares Installer initialization started.",
        "[INFO] Target disk: /dev/nvme0n1 selected.",
        "[INFO] Creating GPT partition table with parted...",
        "[INFO] Formatting EFI System Partition (/boot/efi) as FAT32...",
        "[INFO] Formatting Root partition (/) as Btrfs with zstd compression...",
        "[INFO] Creating subvolumes: @, @home, @var, @snapshots...",
        "[INFO] Mounting subvolumes to /tmp/calamares-root...",
        "[INFO] Unpacking system image: /run/archiso/bootmnt/arch/x86_64/airootfs.sfs...",
        "[INFO] Extracted 42,914 filesystem objects into target root.",
        "[INFO] Setting locale en_IN.UTF-8 and console keymap us...",
        "[INFO] Creating user 'umbrella' with supplementary groups: wheel, audio, video, storage...",
        "[INFO] Configuring /etc/sudoers for wheel elevation...",
        "[INFO] Applying Red Queen KDE Plasma 6 look-and-feel & KWin visual effects...",
        "[INFO] Building mkinitcpio initramfs with Plymouth hooks...",
        "[INFO] Installing GRUB UEFI bootloader to /boot/efi...",
        "[INFO] Enabling systemd units: sddm.service, NetworkManager.service, ollama.service..."
    ]

    // Form data: Section 8 (Finish)
    property bool restartNowChecked: true
    property string systemRebootMessage: ""

    // Live clock timer for Location & HUD
    property string currentClockString: "10:55:00 AM"
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var date = new Date()
            root.currentClockString = Qt.formatTime(date, "hh:mm:ss AP")
        }
    }

    // Auto slideshow timer
    Timer {
        id: autoSlideTimer
        interval: 6000
        running: root.autoPlayEnabled && root.currentSectionIndex === 6
        repeat: true
        onTriggered: {
            root.currentSlideIndex = (root.currentSlideIndex + 1) % root.totalSlidesCount
        }
    }

    // Dynamic install progress timer
    Timer {
        id: progressTimer
        interval: 150
        running: root.currentSectionIndex === 6 && root.installProgress < 1.0
        repeat: true
        onTriggered: {
            if (root.installProgress < 1.0) {
                root.installProgress = Math.min(1.0, root.installProgress + 0.003)
                if (root.installProgress >= 1.0) {
                    root.installProgress = 1.0
                }
            }
        }
    }

    // ========================================================================
    // HELPER FUNCTIONS
    // ========================================================================
    function goToSection(index) {
        if (index >= 0 && index < root.totalSectionsCount) {
            root.currentSectionIndex = index
            if (index === 6 && root.installProgress < 0.1) {
                root.installProgress = 0.15
            }
        }
    }

    function nextSection() {
        if (root.currentSectionIndex < root.totalSectionsCount - 1) {
            goToSection(root.currentSectionIndex + 1)
        } else if (root.currentSectionIndex === 7) {
            // Finish clicked
            rebootModal.visible = true
        }
    }

    function prevSection() {
        if (root.currentSectionIndex > 0) {
            goToSection(root.currentSectionIndex - 1)
        }
    }

    function getInstallStepText() {
        if (root.installProgress < 0.15) return "Partitioning target NVMe/SSD drive (/dev/nvme0n1)..."
        if (root.installProgress < 0.35) return "Creating Btrfs subvolumes (@, @home, @snapshots, @var)..."
        if (root.installProgress < 0.60) return "Unpacking system image (airootfs.sfs)..."
        if (root.installProgress < 0.75) return "Configuring Red Queen HUD, KDE Plasma 6 & Zsh shell..."
        if (root.installProgress < 0.88) return "Configuring Plymouth silent boot, SDDM & systemd services..."
        if (root.installProgress < 0.98) return "Installing GRUB UEFI bootloader to /boot/efi..."
        return "Installation finalized. Ready to reboot."
    }

    // ========================================================================
    // MAIN APP LAYOUT
    // ========================================================================
    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ====================================================================
        // LEFT CALAMARES SIDEBAR
        // ====================================================================
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 230
            color: "#080101"

            // Right border line
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 1
                color: "#2a0808"
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                // Umbrella Header Logo & Brand
                RowLayout {
                    spacing: 10
                    Image {
                        source: "../archiso/airootfs/usr/share/pixmaps/umbrella-logo.png"
                        Layout.preferredWidth: 36
                        Layout.preferredHeight: 36
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                    ColumnLayout {
                        spacing: 1
                        Text {
                            text: "UMBRELLA OS"
                            font.pixelSize: 13
                            font.bold: true
                            font.letterSpacing: 1.5
                            color: "#ffffff"
                        }
                        Text {
                            text: "SYSTEM INSTALLER"
                            font.pixelSize: 9
                            font.bold: true
                            color: "#cc0000"
                        }
                        Text {
                            text: "RED QUEEN v1.0"
                            font.pixelSize: 8
                            font.family: "Monospace"
                            color: "#883333"
                        }
                    }
                }

                // Separator
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#2a0808"
                }

                // 8 Installer Steps List
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 6

                    Repeater {
                        model: root.stepNames

                        Rectangle {
                            Layout.fillWidth: true
                            height: 36
                            radius: 4
                            color: index === root.currentSectionIndex ? "#240505" : (stepMouseArea.containsMouse ? "#140303" : "transparent")
                            border.color: index === root.currentSectionIndex ? "#cc0000" : (stepMouseArea.containsMouse ? "#441111" : "transparent")
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                spacing: 10

                                // Status Indicator
                                Rectangle {
                                    width: 18
                                    height: 18
                                    radius: 9
                                    color: index === root.currentSectionIndex ? "#ff2222" : (index < root.currentSectionIndex ? "#00aa44" : "#1c0505")
                                    border.color: index === root.currentSectionIndex ? "#ff6666" : (index < root.currentSectionIndex ? "#00ff66" : "#441111")
                                    border.width: 1

                                    Text {
                                        anchors.centerIn: parent
                                        text: index < root.currentSectionIndex ? "✓" : (index === root.currentSectionIndex ? "▶" : "" + (index + 1))
                                        font.pixelSize: 10
                                        font.bold: true
                                        color: index === root.currentSectionIndex ? "#ffffff" : (index < root.currentSectionIndex ? "#ffffff" : "#666666")
                                    }
                                }

                                Text {
                                    text: modelData
                                    font.pixelSize: 12
                                    font.bold: index === root.currentSectionIndex
                                    color: index === root.currentSectionIndex ? "#ffffff" : (index < root.currentSectionIndex ? "#cccccc" : "#666666")
                                    Layout.fillWidth: true
                                }
                            }

                            MouseArea {
                                id: stepMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.goToSection(index)
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                }

                // Security Protocol Footer Tag
                Rectangle {
                    Layout.fillWidth: true
                    height: 48
                    color: "#120303"
                    radius: 4
                    border.color: "#330808"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 2
                        Text {
                            text: "HIVE SECURITY PROTOCOL"
                            font.pixelSize: 8
                            font.bold: true
                            font.family: "Monospace"
                            color: "#ff3333"
                        }
                        Text {
                            text: "DIRECTIVE 4.0: OPERATIONAL\nARCH KERNEL: 6.x HARDENED"
                            font.pixelSize: 8
                            font.family: "Monospace"
                            color: "#885555"
                        }
                    }
                }
            }
        }

        // ====================================================================
        // RIGHT MAIN CONTENT AREA & NAVIGATION
        // ====================================================================
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#0d0202"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // Top Glowing Accent Bar
                Rectangle {
                    Layout.fillWidth: true
                    height: 3
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#00000000" }
                        GradientStop { position: 0.5; color: "#cc0000" }
                        GradientStop { position: 1.0; color: "#00000000" }
                    }
                }

                // Top Quick Jump Section Bar
                Rectangle {
                    Layout.fillWidth: true
                    height: 34
                    color: "#0f0202"

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: "#240606"
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        spacing: 6

                        Text {
                            text: "SECTIONS:"
                            font.pixelSize: 10
                            font.bold: true
                            font.family: "Monospace"
                            color: "#662222"
                        }

                        Repeater {
                            model: root.stepNames
                            Rectangle {
                                height: 22
                                Layout.preferredWidth: pillText.contentWidth + 14
                                radius: 3
                                color: index === root.currentSectionIndex ? "#cc0000" : (pillMouse.containsMouse ? "#2a0808" : "#140303")
                                border.color: index === root.currentSectionIndex ? "#ff4444" : "#330808"
                                border.width: 1

                                Text {
                                    id: pillText
                                    anchors.centerIn: parent
                                    text: (index + 1) + ". " + modelData
                                    font.pixelSize: 10
                                    font.bold: index === root.currentSectionIndex
                                    color: index === root.currentSectionIndex ? "#ffffff" : "#888888"
                                }

                                MouseArea {
                                    id: pillMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.goToSection(index)
                                }
                            }
                        }

                        Item { Layout.fillWidth: true }

                        Text {
                            text: "CLOCK: " + root.currentClockString
                            font.pixelSize: 10
                            font.bold: true
                            font.family: "Monospace"
                            color: "#cc0000"
                        }
                    }
                }

                // ============================================================
                // CENTRAL DYNAMIC SECTION VIEW (STACK OF 8 SECTIONS)
                // ============================================================
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    // --------------------------------------------------------
                    // SECTION 1: WELCOME
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 0
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 14

                            // Welcome Header Banner
                            RowLayout {
                                spacing: 16
                                Image {
                                    source: "../archiso/airootfs/usr/share/pixmaps/umbrella-logo.png"
                                    Layout.preferredWidth: 64
                                    Layout.preferredHeight: 64
                                    fillMode: Image.PreserveAspectFit
                                    smooth: true
                                }
                                ColumnLayout {
                                    spacing: 4
                                    Text {
                                        text: "Welcome to Umbrella OS 1.0"
                                        font.pixelSize: 20
                                        font.bold: true
                                        color: "#ffffff"
                                    }
                                    Text {
                                        text: "Arch Linux base • KDE Plasma 6 (Wayland) • Red Queen Autonomous Suite"
                                        font.pixelSize: 11
                                        font.bold: true
                                        color: "#cc0000"
                                    }
                                    Text {
                                        text: "This installer will guide you through setting up Umbrella OS on your workstation or laboratory node."
                                        font.pixelSize: 11
                                        color: "#a0a0a0"
                                    }
                                }
                            }

                            // Language Selector Card
                            Rectangle {
                                Layout.fillWidth: true
                                height: 74
                                radius: 6
                                color: "#140404"
                                border.color: "#441111"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 6

                                    Text {
                                        text: "SELECT INSTALLATION & SYSTEM LANGUAGE:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }

                                    ComboBox {
                                        id: langCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        model: root.languageOptions
                                        currentIndex: root.languageOptions.indexOf(root.selectedLanguage)
                                        onActivated: {
                                            root.selectedLanguage = currentText
                                        }

                                        background: Rectangle {
                                            color: "#1f0606"
                                            radius: 4
                                            border.color: langCombo.hovered ? "#cc0000" : "#551111"
                                            border.width: 1
                                        }

                                        contentItem: Text {
                                            leftPadding: 10
                                            text: langCombo.displayText
                                            font.pixelSize: 12
                                            color: "#ffffff"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                            }

                            // System Diagnostic Requirements Checklist
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 6
                                color: "#120303"
                                border.color: "#330808"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 14
                                    spacing: 10

                                    Text {
                                        text: "HARDWARE PRE-REQUISITES & DIAGNOSTIC AUDIT:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#888888"
                                    }

                                    // Checks Grid
                                    GridLayout {
                                        columns: 2
                                        Layout.fillWidth: true
                                        rowSpacing: 10
                                        columnSpacing: 16

                                        // Item 1: RAM
                                        RowLayout {
                                            spacing: 8
                                            Rectangle { width: 20; height: 20; radius: 10; color: "#008833"; Text { anchors.centerIn: parent; text: "✓"; color: "#fff"; font.bold: true } }
                                            ColumnLayout {
                                                spacing: 1
                                                Text { text: "Memory: >= 4.0 GB"; font.pixelSize: 11; font.bold: true; color: "#ffffff" }
                                                Text { text: "16.0 GB DDR5 RAM detected (Optimal)"; font.pixelSize: 10; color: "#00cc66" }
                                            }
                                        }

                                        // Item 2: Storage
                                        RowLayout {
                                            spacing: 8
                                            Rectangle { width: 20; height: 20; radius: 10; color: "#008833"; Text { anchors.centerIn: parent; text: "✓"; color: "#fff"; font.bold: true } }
                                            ColumnLayout {
                                                spacing: 1
                                                Text { text: "Available Storage: >= 25.0 GB"; font.pixelSize: 11; font.bold: true; color: "#ffffff" }
                                                Text { text: "512.1 GB NVMe SSD detected (Optimal)"; font.pixelSize: 10; color: "#00cc66" }
                                            }
                                        }

                                        // Item 3: Power
                                        RowLayout {
                                            spacing: 8
                                            Rectangle { width: 20; height: 20; radius: 10; color: "#008833"; Text { anchors.centerIn: parent; text: "✓"; color: "#fff"; font.bold: true } }
                                            ColumnLayout {
                                                spacing: 1
                                                Text { text: "Power Source: AC Power"; font.pixelSize: 11; font.bold: true; color: "#ffffff" }
                                                Text { text: "Connected to continuous power grid"; font.pixelSize: 10; color: "#00cc66" }
                                            }
                                        }

                                        // Item 4: Network
                                        RowLayout {
                                            spacing: 8
                                            Rectangle { width: 20; height: 20; radius: 10; color: "#008833"; Text { anchors.centerIn: parent; text: "✓"; color: "#fff"; font.bold: true } }
                                            ColumnLayout {
                                                spacing: 1
                                                Text { text: "Network: Hive Uplink"; font.pixelSize: 11; font.bold: true; color: "#ffffff" }
                                                Text { text: "Connected to Internet & Pacman mirrors"; font.pixelSize: 10; color: "#00cc66" }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    // Confidentiality Warning banner
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: 38
                                        radius: 4
                                        color: "#200404"
                                        border.color: "#881111"
                                        border.width: 1

                                        RowLayout {
                                            anchors.fill: parent
                                            anchors.margins: 8
                                            spacing: 8
                                            Text {
                                                text: "⚠"
                                                font.pixelSize: 14
                                                color: "#ff3333"
                                            }
                                            Text {
                                                text: "NOTICE: Raccoon City Hive Terminal v1.0. All deployment activities are secured under Umbrella Security Directive 4.0."
                                                font.pixelSize: 10
                                                color: "#dd9999"
                                                Layout.fillWidth: true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 2: LOCATION
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 1
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 14

                            ColumnLayout {
                                spacing: 2
                                Text {
                                    text: "Location & Timezone Selection"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                Text {
                                    text: "Please select your region and city to automatically configure system clock, locale, and regional numeric formats."
                                    font.pixelSize: 11
                                    color: "#a0a0a0"
                                }
                            }

                            // Interactive World Map Canvas
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 6
                                color: "#080101"
                                border.color: "#330808"
                                border.width: 1
                                clip: true

                                // World Map Vector Background Grid
                                Canvas {
                                    id: mapCanvas
                                    anchors.fill: parent
                                    onPaint: {
                                        var ctx = getContext("2d")
                                        ctx.clearRect(0, 0, width, height)

                                        // Draw cybernetic grid
                                        ctx.strokeStyle = "#1a0404"
                                        ctx.lineWidth = 1
                                        for (var x = 0; x < width; x += 40) {
                                            ctx.beginPath()
                                            ctx.moveTo(x, 0)
                                            ctx.lineTo(x, height)
                                            ctx.stroke()
                                        }
                                        for (var y = 0; y < height; y += 40) {
                                            ctx.beginPath()
                                            ctx.moveTo(0, y)
                                            ctx.lineTo(width, y)
                                            ctx.stroke()
                                        }

                                        // Equator & Prime Meridian
                                        ctx.strokeStyle = "#441111"
                                        ctx.lineWidth = 1.5
                                        ctx.beginPath()
                                        ctx.moveTo(0, height / 2)
                                        ctx.lineTo(width, height / 2)
                                        ctx.stroke()

                                        ctx.beginPath()
                                        ctx.moveTo(width / 2, 0)
                                        ctx.lineTo(width / 2, height)
                                        ctx.stroke()
                                    }
                                }

                                // Interactive Radar / Target Ring on Selected Zone
                                Item {
                                    id: targetRing
                                    width: 120
                                    height: 120
                                    anchors.centerIn: parent

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 16
                                        height: 16
                                        radius: 8
                                        color: "#ff2222"
                                        border.color: "#ffffff"
                                        border.width: 2
                                    }

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 50
                                        height: 50
                                        radius: 25
                                        color: "transparent"
                                        border.color: "#cc0000"
                                        border.width: 1.5
                                        opacity: 0.8
                                    }

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 90
                                        height: 90
                                        radius: 45
                                        color: "transparent"
                                        border.color: "#ff3333"
                                        border.width: 1
                                        opacity: 0.4
                                    }
                                }

                                // World Map HUD overlay text
                                Rectangle {
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.margins: 12
                                    width: 260
                                    height: 70
                                    radius: 4
                                    color: "#180303"
                                    opacity: 0.92
                                    border.color: "#551111"
                                    border.width: 1

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 8
                                        spacing: 2
                                        Text {
                                            text: "GEO COORDINATES & TIMEZONE"
                                            font.pixelSize: 9
                                            font.bold: true
                                            font.family: "Monospace"
                                            color: "#ff3333"
                                        }
                                        Text {
                                            text: "ACTIVE ZONE: " + root.selectedRegion + " / " + root.selectedZone
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: "#ffffff"
                                        }
                                        Text {
                                            text: "LOCAL TIME: " + root.currentClockString + " | UTC OFFSET"
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#aaaaaa"
                                        }
                                    }
                                }

                                // Locale Format Info Card (Bottom-Right)
                                Rectangle {
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 12
                                    width: 280
                                    height: 80
                                    radius: 4
                                    color: "#180303"
                                    opacity: 0.92
                                    border.color: "#551111"
                                    border.width: 1

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 8
                                        spacing: 2
                                        Text {
                                            text: "LOCALE FORMATS PREVIEW"
                                            font.pixelSize: 9
                                            font.bold: true
                                            font.family: "Monospace"
                                            color: "#00cc66"
                                        }
                                        Text {
                                            text: "Numbers: 1,234,567.89 • Currency: ₹ / $"
                                            font.pixelSize: 10
                                            color: "#cccccc"
                                        }
                                        Text {
                                            text: "Date: Friday, 23 October 2026"
                                            font.pixelSize: 10
                                            color: "#cccccc"
                                        }
                                        Text {
                                            text: "System Locale: " + root.selectedLocale
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#888888"
                                        }
                                    }
                                }
                            }

                            // Region & Zone Dropdowns
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 14

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: "REGION:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }
                                    ComboBox {
                                        id: regionCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 34
                                        model: root.regionsList
                                        currentIndex: root.regionsList.indexOf(root.selectedRegion)
                                        onActivated: {
                                            root.selectedRegion = currentText
                                            var zones = root.zonesMap[currentText]
                                            if (zones && zones.length > 0) {
                                                zoneCombo.model = zones
                                                root.selectedZone = zones[0]
                                            }
                                        }
                                        background: Rectangle {
                                            color: "#1a0404"
                                            radius: 4
                                            border.color: regionCombo.hovered ? "#cc0000" : "#441111"
                                            border.width: 1
                                        }
                                        contentItem: Text {
                                            leftPadding: 10
                                            text: regionCombo.displayText
                                            font.pixelSize: 12
                                            color: "#ffffff"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: "ZONE / CITY:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }
                                    ComboBox {
                                        id: zoneCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 34
                                        model: root.zonesMap[root.selectedRegion]
                                        currentIndex: model ? model.indexOf(root.selectedZone) : 0
                                        onActivated: {
                                            root.selectedZone = currentText
                                            if (root.selectedZone === "Kolkata") root.selectedLocale = "en_IN.UTF-8"
                                            else if (root.selectedRegion === "America") root.selectedLocale = "en_US.UTF-8"
                                            else if (root.selectedRegion === "Europe") root.selectedLocale = "en_GB.UTF-8"
                                        }
                                        background: Rectangle {
                                            color: "#1a0404"
                                            radius: 4
                                            border.color: zoneCombo.hovered ? "#cc0000" : "#441111"
                                            border.width: 1
                                        }
                                        contentItem: Text {
                                            leftPadding: 10
                                            text: zoneCombo.displayText
                                            font.pixelSize: 12
                                            color: "#ffffff"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 3: KEYBOARD
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 2
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 12

                            ColumnLayout {
                                spacing: 2
                                Text {
                                    text: "Keyboard Model & Layout"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                Text {
                                    text: "Select your hardware keyboard model and preferred key layout mapping."
                                    font.pixelSize: 11
                                    color: "#a0a0a0"
                                }
                            }

                            // Model & Layout Selectors Row
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 14

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: "KEYBOARD MODEL:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }
                                    ComboBox {
                                        id: modelCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        model: ["Generic 105-Key PC (intl.)", "Generic 104-Key PC", "Lenovo ThinkPad Keyboard", "Apple Magic Keyboard"]
                                        currentIndex: 0
                                        onActivated: root.selectedKeyModel = currentText
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111"; border.width: 1 }
                                        contentItem: Text { leftPadding: 10; text: modelCombo.displayText; color: "#fff"; verticalAlignment: Text.AlignVCenter }
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: "KEYBOARD LAYOUT:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }
                                    ComboBox {
                                        id: layoutCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        model: ["English (US)", "English (UK)", "German (QWERTZ)", "French (AZERTY)", "Spanish", "Hindi (InScript)", "Japanese (Kana)"]
                                        currentIndex: 0
                                        onActivated: root.selectedKeyLayout = currentText
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111"; border.width: 1 }
                                        contentItem: Text { leftPadding: 10; text: layoutCombo.displayText; color: "#fff"; verticalAlignment: Text.AlignVCenter }
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Text {
                                        text: "VARIANT:"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.family: "Monospace"
                                        color: "#cc3333"
                                    }
                                    ComboBox {
                                        id: variantCombo
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        model: ["Default", "altgr-intl (with dead keys)", "Dvorak", "Colemak", "Workman"]
                                        currentIndex: 0
                                        onActivated: root.selectedKeyVariant = currentText
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111"; border.width: 1 }
                                        contentItem: Text { leftPadding: 10; text: variantCombo.displayText; color: "#fff"; verticalAlignment: Text.AlignVCenter }
                                    }
                                }
                            }

                            // Interactive Virtual Keyboard Diagram
                            Rectangle {
                                Layout.fillWidth: true
                                height: 180
                                radius: 6
                                color: "#100202"
                                border.color: "#330808"
                                border.width: 1

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 4

                                    // Row 1: Esc + Function keys
                                    Row {
                                        spacing: 4
                                        Repeater {
                                            model: ["Esc", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]
                                            Rectangle {
                                                width: index === 0 ? 38 : 32
                                                height: 24
                                                radius: 3
                                                color: root.lastPressedKey.toUpperCase() === modelData.toUpperCase() ? "#ff2222" : "#1a0505"
                                                border.color: "#441111"
                                                border.width: 1
                                                Text { anchors.centerIn: parent; text: modelData; font.pixelSize: 9; color: "#fff" }
                                                MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = modelData }
                                            }
                                        }
                                    }

                                    // Row 2: Number row
                                    Row {
                                        spacing: 4
                                        Repeater {
                                            model: ["`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "Bksp"]
                                            Rectangle {
                                                width: index === 13 ? 54 : 32
                                                height: 28
                                                radius: 3
                                                color: root.lastPressedKey.toUpperCase() === modelData.toUpperCase() ? "#ff2222" : "#200606"
                                                border.color: "#551111"
                                                border.width: 1
                                                Text { anchors.centerIn: parent; text: modelData; font.pixelSize: 10; font.bold: true; color: "#fff" }
                                                MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = modelData }
                                            }
                                        }
                                    }

                                    // Row 3: QWERTY row
                                    Row {
                                        spacing: 4
                                        Repeater {
                                            model: ["Tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "\\"]
                                            Rectangle {
                                                width: index === 0 ? 46 : (index === 13 ? 40 : 32)
                                                height: 28
                                                radius: 3
                                                color: root.lastPressedKey.toUpperCase() === modelData.toUpperCase() ? "#ff2222" : "#200606"
                                                border.color: "#551111"
                                                border.width: 1
                                                Text { anchors.centerIn: parent; text: modelData; font.pixelSize: 10; font.bold: true; color: "#fff" }
                                                MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = modelData }
                                            }
                                        }
                                    }

                                    // Row 4: ASDF row
                                    Row {
                                        spacing: 4
                                        Repeater {
                                            model: ["Caps", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "Enter"]
                                            Rectangle {
                                                width: index === 0 ? 52 : (index === 12 ? 58 : 32)
                                                height: 28
                                                radius: 3
                                                color: root.lastPressedKey.toUpperCase() === modelData.toUpperCase() ? "#ff2222" : "#200606"
                                                border.color: "#551111"
                                                border.width: 1
                                                Text { anchors.centerIn: parent; text: modelData; font.pixelSize: 10; font.bold: true; color: "#fff" }
                                                MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = modelData }
                                            }
                                        }
                                    }

                                    // Row 5: ZXCV row & Space
                                    Row {
                                        spacing: 4
                                        Repeater {
                                            model: ["Shift", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "Shift"]
                                            Rectangle {
                                                width: index === 0 || index === 11 ? 64 : 32
                                                height: 28
                                                radius: 3
                                                color: root.lastPressedKey.toUpperCase() === modelData.toUpperCase() ? "#ff2222" : "#200606"
                                                border.color: "#551111"
                                                border.width: 1
                                                Text { anchors.centerIn: parent; text: modelData; font.pixelSize: 10; font.bold: true; color: "#fff" }
                                                MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = modelData }
                                            }
                                        }
                                    }

                                    // Row 6: Spacebar
                                    Row {
                                        spacing: 4
                                        Rectangle { width: 50; height: 26; radius: 3; color: "#1a0404"; border.color: "#441111"; Text { anchors.centerIn: parent; text: "Ctrl"; color: "#aaa"; font.pixelSize: 9 } }
                                        Rectangle { width: 44; height: 26; radius: 3; color: "#1a0404"; border.color: "#441111"; Text { anchors.centerIn: parent; text: "Super"; color: "#cc0000"; font.pixelSize: 9; font.bold: true } }
                                        Rectangle { width: 44; height: 26; radius: 3; color: "#1a0404"; border.color: "#441111"; Text { anchors.centerIn: parent; text: "Alt"; color: "#aaa"; font.pixelSize: 9 } }
                                        Rectangle {
                                            width: 240
                                            height: 26
                                            radius: 3
                                            color: root.lastPressedKey === " " ? "#ff2222" : "#240606"
                                            border.color: "#661111"
                                            Text { anchors.centerIn: parent; text: "SPACE"; color: "#666"; font.pixelSize: 9 }
                                            MouseArea { anchors.fill: parent; onClicked: root.lastPressedKey = " " }
                                        }
                                        Rectangle { width: 44; height: 26; radius: 3; color: "#1a0404"; border.color: "#441111"; Text { anchors.centerIn: parent; text: "AltGr"; color: "#aaa"; font.pixelSize: 9 } }
                                        Rectangle { width: 50; height: 26; radius: 3; color: "#1a0404"; border.color: "#441111"; Text { anchors.centerIn: parent; text: "Ctrl"; color: "#aaa"; font.pixelSize: 9 } }
                                    }
                                }
                            }

                            // Interactive Keyboard Test Box
                            Rectangle {
                                Layout.fillWidth: true
                                height: 72
                                radius: 6
                                color: "#140404"
                                border.color: "#551111"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 8
                                    spacing: 4

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: "TYPE HERE TO TEST YOUR KEYBOARD:"
                                            font.pixelSize: 9
                                            font.bold: true
                                            font.family: "Monospace"
                                            color: "#cc3333"
                                        }
                                        Item { Layout.fillWidth: true }
                                        Text {
                                            text: "LAST KEY: " + (root.lastPressedKey ? root.lastPressedKey : "NONE")
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#00cc66"
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        TextField {
                                            id: keyboardTestField
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 32
                                            text: root.keyTestText
                                            placeholderText: "Type any sentence, numbers or special characters to verify layout..."
                                            color: "#ffffff"
                                            font.pixelSize: 12
                                            font.family: "Monospace"
                                            selectByMouse: true
                                            onTextChanged: {
                                                root.keyTestText = text
                                                if (text.length > 0) {
                                                    root.lastPressedKey = text[text.length - 1]
                                                }
                                            }

                                            background: Rectangle {
                                                color: "#200606"
                                                radius: 4
                                                border.color: keyboardTestField.activeFocus ? "#cc0000" : "#441111"
                                                border.width: 1
                                            }
                                        }

                                        Rectangle {
                                            width: 60
                                            height: 32
                                            radius: 4
                                            color: "#2a0808"
                                            border.color: "#661111"
                                            border.width: 1

                                            Text {
                                                anchors.centerIn: parent
                                                text: "Clear"
                                                font.pixelSize: 11
                                                color: "#dddddd"
                                            }

                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: keyboardTestField.text = ""
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 4: PARTITIONS
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 3
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 12

                            ColumnLayout {
                                spacing: 2
                                Text {
                                    text: "Storage & Disk Partitioning"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                Text {
                                    text: "Choose the target drive and partitioning scheme for installing Umbrella OS."
                                    font.pixelSize: 11
                                    color: "#a0a0a0"
                                }
                            }

                            // Storage Device Selector
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 10

                                Text {
                                    text: "STORAGE DISK:"
                                    font.pixelSize: 10
                                    font.bold: true
                                    font.family: "Monospace"
                                    color: "#cc3333"
                                }

                                ComboBox {
                                    id: diskCombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 32
                                    model: [
                                        "/dev/nvme0n1 — 512.1 GB Umbrella NVMe SSD (Samsung 990 Pro)",
                                        "/dev/sda — 1000.2 GB Secondary Hive Data Drive (Crucial MX500)"
                                    ]
                                    currentIndex: 0
                                    onActivated: root.selectedTargetDisk = currentText
                                    background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111"; border.width: 1 }
                                    contentItem: Text { leftPadding: 10; text: diskCombo.displayText; color: "#fff"; verticalAlignment: Text.AlignVCenter }
                                }
                            }

                            // 3 Partitioning Mode Cards
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 12

                                // Option 1: Erase Disk
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 120
                                    radius: 6
                                    color: root.partitionOption === "erase" ? "#260606" : "#120303"
                                    border.color: root.partitionOption === "erase" ? "#cc0000" : "#330808"
                                    border.width: 1.5

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 6

                                        RowLayout {
                                            spacing: 8
                                            Rectangle {
                                                width: 16; height: 16; radius: 8
                                                color: root.partitionOption === "erase" ? "#ff2222" : "transparent"
                                                border.color: "#cc0000"; border.width: 1.5
                                            }
                                            Text {
                                                text: "Erase Disk (Recommended)"
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "#ffffff"
                                            }
                                        }

                                        Text {
                                            text: "Deletes all data on the selected disk and creates clean GPT partitions for Umbrella OS."
                                            font.pixelSize: 10
                                            color: "#aaaaaa"
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }

                                        Text {
                                            text: "• Automatic EFI (512MB) + Btrfs Subvolumes"
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#00cc66"
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: root.partitionOption = "erase"
                                    }
                                }

                                // Option 2: Install Alongside
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 120
                                    radius: 6
                                    color: root.partitionOption === "alongside" ? "#260606" : "#120303"
                                    border.color: root.partitionOption === "alongside" ? "#cc0000" : "#330808"
                                    border.width: 1.5

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 6

                                        RowLayout {
                                            spacing: 8
                                            Rectangle {
                                                width: 16; height: 16; radius: 8
                                                color: root.partitionOption === "alongside" ? "#ff2222" : "transparent"
                                                border.color: "#cc0000"; border.width: 1.5
                                            }
                                            Text {
                                                text: "Install Alongside (Dual-Boot)"
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "#ffffff"
                                            }
                                        }

                                        Text {
                                            text: "Shrinks an existing OS partition to make space for Umbrella OS without deleting existing files."
                                            font.pixelSize: 10
                                            color: "#aaaaaa"
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }

                                        Text {
                                            text: "• Preserves Windows / other Linux OS"
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#888888"
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: root.partitionOption = "alongside"
                                    }
                                }

                                // Option 3: Manual Partitioning
                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 120
                                    radius: 6
                                    color: root.partitionOption === "manual" ? "#260606" : "#120303"
                                    border.color: root.partitionOption === "manual" ? "#cc0000" : "#330808"
                                    border.width: 1.5

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 6

                                        RowLayout {
                                            spacing: 8
                                            Rectangle {
                                                width: 16; height: 16; radius: 8
                                                color: root.partitionOption === "manual" ? "#ff2222" : "transparent"
                                                border.color: "#cc0000"; border.width: 1.5
                                            }
                                            Text {
                                                text: "Manual Partitioning"
                                                font.pixelSize: 12
                                                font.bold: true
                                                color: "#ffffff"
                                            }
                                        }

                                        Text {
                                            text: "Expert mode: manually create, delete, resize, and assign custom mount points."
                                            font.pixelSize: 10
                                            color: "#aaaaaa"
                                            wrapMode: Text.WordWrap
                                            Layout.fillWidth: true
                                        }

                                        Text {
                                            text: "• Full control over mount points"
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#888888"
                                        }
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: root.partitionOption = "manual"
                                    }
                                }
                            }

                            // Visual Partition Diagram (Proposed Disk Layout)
                            Rectangle {
                                Layout.fillWidth: true
                                height: 96
                                radius: 6
                                color: "#140404"
                                border.color: "#441111"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 6

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: "PROPOSED PARTITION LAYOUT FOR: /dev/nvme0n1"
                                            font.pixelSize: 9
                                            font.bold: true
                                            font.family: "Monospace"
                                            color: "#cc3333"
                                        }
                                        Item { Layout.fillWidth: true }
                                        Text {
                                            text: "Total: 512.1 GB (GPT Partition Table)"
                                            font.pixelSize: 9
                                            font.family: "Monospace"
                                            color: "#888888"
                                        }
                                    }

                                    // Graphical Multi-Partition Bar
                                    RowLayout {
                                        Layout.fillWidth: true
                                        height: 36
                                        spacing: 3

                                        // Partition 1: EFI ESP
                                        Rectangle {
                                            Layout.preferredWidth: 60
                                            Layout.fillHeight: true
                                            radius: 3
                                            color: "#880000"
                                            border.color: "#cc2222"
                                            border.width: 1

                                            ColumnLayout {
                                                anchors.centerIn: parent
                                                spacing: 1
                                                Text { text: "ESP /boot/efi"; font.pixelSize: 8; font.bold: true; color: "#fff" }
                                                Text { text: "512 MB (FAT32)"; font.pixelSize: 7; color: "#ddd" }
                                            }
                                        }

                                        // Partition 2: Btrfs Root
                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            radius: 3
                                            color: "#cc1111"
                                            border.color: "#ff4444"
                                            border.width: 1

                                            ColumnLayout {
                                                anchors.centerIn: parent
                                                spacing: 1
                                                Text { text: "Umbrella Root (/) • Btrfs Subvolumes (@, @home, @snapshots, @var)"; font.pixelSize: 10; font.bold: true; color: "#fff" }
                                                Text { text: "503.5 GB • zstd compression enabled • automated snapshots"; font.pixelSize: 8; color: "#ffe0e0" }
                                            }
                                        }

                                        // Partition 3: Swap
                                        Rectangle {
                                            Layout.preferredWidth: 80
                                            Layout.fillHeight: true
                                            radius: 3
                                            color: "#441111"
                                            border.color: "#882222"
                                            border.width: 1

                                            ColumnLayout {
                                                anchors.centerIn: parent
                                                spacing: 1
                                                Text { text: "Swap File"; font.pixelSize: 8; font.bold: true; color: "#fff" }
                                                Text { text: "8.0 GB"; font.pixelSize: 7; color: "#ddd" }
                                            }
                                        }
                                    }

                                    // Sub-options row
                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 16

                                        Text { text: "Filesystem: Btrfs (zstd:3)"; font.pixelSize: 9; font.family: "Monospace"; color: "#00cc66" }
                                        Text { text: "Bootloader: GRUB UEFI (/boot/efi)"; font.pixelSize: 9; font.family: "Monospace"; color: "#00cc66" }
                                        Text { text: "TRIM: Enabled"; font.pixelSize: 9; font.family: "Monospace"; color: "#00cc66" }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 5: USERS
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 4
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 10

                            ColumnLayout {
                                spacing: 2
                                Text {
                                    text: "User Identity & Security Credentials"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                Text {
                                    text: "Configure the primary operator account and administrative privileges for this Hive terminal."
                                    font.pixelSize: 11
                                    color: "#a0a0a0"
                                }
                            }

                            // 2-Column Form
                            GridLayout {
                                columns: 2
                                Layout.fillWidth: true
                                rowSpacing: 8
                                columnSpacing: 16

                                // Full Name
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Text { text: "WHAT IS YOUR NAME?"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                    TextField {
                                        id: fullNameInput
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        text: root.userFullName
                                        color: "#ffffff"
                                        onTextChanged: {
                                            root.userFullName = text
                                            if (text.length > 0) {
                                                root.userName = text.split(" ")[0].toLowerCase().replace(/[^a-z0-9]/g, "")
                                            }
                                        }
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111" }
                                    }
                                }

                                // Login Username
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Text { text: "LOGIN USERNAME (lowercase, sudo):"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                    TextField {
                                        id: userNameInput
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        text: root.userName
                                        color: "#ffffff"
                                        font.family: "Monospace"
                                        onTextChanged: root.userName = text
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111" }
                                    }
                                }

                                // Hostname
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Text { text: "NAME OF THIS COMPUTER (HOSTNAME):"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                    TextField {
                                        id: hostNameInput
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        text: root.hostName
                                        color: "#ffffff"
                                        font.family: "Monospace"
                                        onTextChanged: root.hostName = text
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111" }
                                    }
                                }

                                // Password Strength badge
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Text { text: "SECURITY CLEARANCE LEVEL:"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: 32
                                        radius: 4
                                        color: "#180404"
                                        border.color: "#441111"
                                        RowLayout {
                                            anchors.fill: parent
                                            anchors.margins: 8
                                            Text {
                                                text: root.userPassword.length >= 8 ? "LEVEL 4: UMBRELLA CIPHER SECURE" : (root.userPassword.length >= 4 ? "LEVEL 2: STANDARD ACCESS" : "LEVEL 1: WEAK CIPHER")
                                                font.pixelSize: 10
                                                font.bold: true
                                                font.family: "Monospace"
                                                color: root.userPassword.length >= 8 ? "#00ff66" : (root.userPassword.length >= 4 ? "#ffaa00" : "#ff3333")
                                            }
                                        }
                                    }
                                }

                                // User Password
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    Text { text: "CHOOSE A PASSWORD:"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                    TextField {
                                        id: passInput
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        text: root.userPassword
                                        echoMode: root.showPasswordText ? TextInput.Normal : TextInput.Password
                                        color: "#ffffff"
                                        onTextChanged: root.userPassword = text
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: "#441111" }
                                    }
                                }

                                // Repeat Password
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3
                                    RowLayout {
                                        Text { text: "REPEAT PASSWORD:"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#cc3333" }
                                        Item { Layout.fillWidth: true }
                                        Text {
                                            text: root.userPassword === root.repeatPassword ? "✓ Passwords match" : "✗ Passwords do not match"
                                            font.pixelSize: 9
                                            font.bold: true
                                            color: root.userPassword === root.repeatPassword ? "#00ff66" : "#ff3333"
                                        }
                                    }
                                    TextField {
                                        id: repeatPassInput
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        text: root.repeatPassword
                                        echoMode: root.showPasswordText ? TextInput.Normal : TextInput.Password
                                        color: "#ffffff"
                                        onTextChanged: root.repeatPassword = text
                                        background: Rectangle { color: "#180404"; radius: 4; border.color: root.userPassword === root.repeatPassword ? "#008833" : "#cc0000" }
                                    }
                                }
                            }

                            // Toggles & Checkboxes
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 6
                                Layout.topMargin: 6

                                // Toggle Show/Hide Passwords
                                RowLayout {
                                    spacing: 8
                                    Rectangle {
                                        width: 16; height: 16; radius: 3; color: root.showPasswordText ? "#cc0000" : "#1a0404"
                                        border.color: "#661111"; Text { anchors.centerIn: parent; text: root.showPasswordText ? "✓" : ""; color: "#fff"; font.pixelSize: 10 }
                                        MouseArea { anchors.fill: parent; onClicked: root.showPasswordText = !root.showPasswordText }
                                    }
                                    Text { text: "Show passwords as clear text"; font.pixelSize: 11; color: "#cccccc" }
                                }

                                // Toggle Autologin
                                RowLayout {
                                    spacing: 8
                                    Rectangle {
                                        width: 16; height: 16; radius: 3; color: root.autoLogin ? "#cc0000" : "#1a0404"
                                        border.color: "#661111"; Text { anchors.centerIn: parent; text: root.autoLogin ? "✓" : ""; color: "#fff"; font.pixelSize: 10 }
                                        MouseArea { anchors.fill: parent; onClicked: root.autoLogin = !root.autoLogin }
                                    }
                                    Text { text: "Log in automatically without asking for password on boot"; font.pixelSize: 11; color: "#cccccc" }
                                }

                                // Toggle Root password same
                                RowLayout {
                                    spacing: 8
                                    Rectangle {
                                        width: 16; height: 16; radius: 3; color: root.rootSamePassword ? "#cc0000" : "#1a0404"
                                        border.color: "#661111"; Text { anchors.centerIn: parent; text: root.rootSamePassword ? "✓" : ""; color: "#fff"; font.pixelSize: 10 }
                                        MouseArea { anchors.fill: parent; onClicked: root.rootSamePassword = !root.rootSamePassword }
                                    }
                                    Text { text: "Use the same password for the administrator account (root / sudo)"; font.pixelSize: 11; color: "#cccccc" }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 6: SUMMARY
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 5
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 12

                            ColumnLayout {
                                spacing: 2
                                Text {
                                    text: "Review Installation Summary"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#ffffff"
                                }
                                Text {
                                    text: "All deployment choices have been aggregated. Please review before writing changes to disk."
                                    font.pixelSize: 11
                                    color: "#a0a0a0"
                                }
                            }

                            // 4 Review Summary Cards Grid
                            GridLayout {
                                columns: 2
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                rowSpacing: 10
                                columnSpacing: 12

                                // Card 1: Location
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 6
                                    color: "#140404"
                                    border.color: "#441111"
                                    border.width: 1
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Text { text: "1. LOCATION & LOCALE"; font.pixelSize: 10; font.bold: true; font.family: "Monospace"; color: "#cc0000" }
                                        Text { text: "• Region: " + root.selectedRegion; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Zone / City: " + root.selectedZone; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• System Locale: " + root.selectedLocale; font.pixelSize: 11; color: "#aaaaaa" }
                                        Text { text: "• Language: " + root.selectedLanguage; font.pixelSize: 11; color: "#aaaaaa" }
                                    }
                                }

                                // Card 2: Keyboard
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 6
                                    color: "#140404"
                                    border.color: "#441111"
                                    border.width: 1
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Text { text: "2. KEYBOARD MAPPING"; font.pixelSize: 10; font.bold: true; font.family: "Monospace"; color: "#cc0000" }
                                        Text { text: "• Model: " + root.selectedKeyModel; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Layout: " + root.selectedKeyLayout; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Variant: " + root.selectedKeyVariant; font.pixelSize: 11; color: "#aaaaaa" }
                                    }
                                }

                                // Card 3: Partitions
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 6
                                    color: "#140404"
                                    border.color: "#441111"
                                    border.width: 1
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Text { text: "3. STORAGE & PARTITIONS"; font.pixelSize: 10; font.bold: true; font.family: "Monospace"; color: "#cc0000" }
                                        Text { text: "• Target: /dev/nvme0n1 (512 GB NVMe)"; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Scheme: GPT (Erase disk & clean install)"; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• ESP: 512 MB FAT32 (/boot/efi)"; font.pixelSize: 10; color: "#aaaaaa" }
                                        Text { text: "• Root: Btrfs (@, @home, @snapshots, @var)"; font.pixelSize: 10; color: "#aaaaaa" }
                                    }
                                }

                                // Card 4: Users
                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    radius: 6
                                    color: "#140404"
                                    border.color: "#441111"
                                    border.width: 1
                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 4
                                        Text { text: "4. USER & PERMISSIONS"; font.pixelSize: 10; font.bold: true; font.family: "Monospace"; color: "#cc0000" }
                                        Text { text: "• Real Name: " + root.userFullName; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Username: " + root.userName; font.pixelSize: 11; color: "#ffffff" }
                                        Text { text: "• Hostname: " + root.hostName; font.pixelSize: 11; color: "#aaaaaa" }
                                        Text { text: "• Autologin: " + (root.autoLogin ? "Enabled" : "Disabled"); font.pixelSize: 10; color: "#aaaaaa" }
                                    }
                                }
                            }

                            // Prominent Warning Box
                            Rectangle {
                                Layout.fillWidth: true
                                height: 50
                                radius: 4
                                color: "#240404"
                                border.color: "#aa0000"
                                border.width: 1.5

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 10
                                    spacing: 12
                                    Text { text: "☣"; font.pixelSize: 22; color: "#ff2222" }
                                    ColumnLayout {
                                        spacing: 2
                                        Text { text: "WARNING: Calamares is about to modify your partition tables."; font.pixelSize: 11; font.bold: true; color: "#ffffff" }
                                        Text { text: "Clicking 'Install Now' below will format /dev/nvme0n1 and begin writing system files."; font.pixelSize: 10; color: "#ff9999" }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 7: INSTALL (Slideshow, Progress & Logs)
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 6

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 0

                            // Central Slide Presentation Area
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true

                                // SLIDE 1: Welcome & Red Queen
                                Item {
                                    anchors.fill: parent
                                    opacity: root.currentSlideIndex === 0 ? 1.0 : 0.0
                                    Behavior on opacity { NumberAnimation { duration: 400 } }
                                    visible: opacity > 0

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 14
                                        width: Math.min(parent.width - 60, 600)

                                        Image {
                                            source: "../archiso/airootfs/usr/share/pixmaps/umbrella-logo.png"
                                            Layout.preferredWidth: 84
                                            Layout.preferredHeight: 84
                                            Layout.alignment: Qt.AlignHCenter
                                            fillMode: Image.PreserveAspectFit
                                            smooth: true
                                        }

                                        Text {
                                            text: "UMBRELLA CORPORATION OS"
                                            font.pixelSize: 20
                                            font.bold: true
                                            font.letterSpacing: 2
                                            color: "#ffffff"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "RED QUEEN AI & SECURITY ARCHITECTURE"
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: "#cc0000"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "Umbrella OS is a high-performance Arch-based workstation engineered for autonomous systems development, security research, and local machine learning inference."
                                            font.pixelSize: 12
                                            color: "#a0a0a0"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillWidth: true
                                        }
                                    }
                                }

                                // SLIDE 2: Developer & Local AI Stack
                                Item {
                                    anchors.fill: parent
                                    opacity: root.currentSlideIndex === 1 ? 1.0 : 0.0
                                    Behavior on opacity { NumberAnimation { duration: 400 } }
                                    visible: opacity > 0

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 14
                                        width: Math.min(parent.width - 60, 600)

                                        Rectangle {
                                            Layout.preferredWidth: 70
                                            Layout.preferredHeight: 70
                                            Layout.alignment: Qt.AlignHCenter
                                            radius: 35
                                            color: "#180303"
                                            border.color: "#cc0000"
                                            border.width: 1.5

                                            Text {
                                                anchors.centerIn: parent
                                                text: "AI"
                                                font.pixelSize: 28
                                                font.bold: true
                                                color: "#ff2222"
                                            }
                                        }

                                        Text {
                                            text: "LOCAL AI & MACHINE LEARNING READY"
                                            font.pixelSize: 18
                                            font.bold: true
                                            color: "#ffffff"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "OLLAMA • PYTORCH • NUMPY • FASTAPI • PYTHON 3"
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: "#cc0000"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "Preloaded with Ollama for zero-leak local LLM inference, PyTorch ML acceleration, Docker Compose containerization, and modern cyber security toolchains."
                                            font.pixelSize: 12
                                            color: "#a0a0a0"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillWidth: true
                                        }
                                    }
                                }

                                // SLIDE 3: KDE Plasma 6 Desktop
                                Item {
                                    anchors.fill: parent
                                    opacity: root.currentSlideIndex === 2 ? 1.0 : 0.0
                                    Behavior on opacity { NumberAnimation { duration: 400 } }
                                    visible: opacity > 0

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 14
                                        width: Math.min(parent.width - 60, 600)

                                        Rectangle {
                                            Layout.preferredWidth: 70
                                            Layout.preferredHeight: 70
                                            Layout.alignment: Qt.AlignHCenter
                                            radius: 12
                                            color: "#180303"
                                            border.color: "#cc0000"
                                            border.width: 1.5

                                            Text {
                                                anchors.centerIn: parent
                                                text: "6"
                                                font.pixelSize: 32
                                                font.bold: true
                                                color: "#ffffff"
                                            }
                                        }

                                        Text {
                                            text: "KDE PLASMA 6 DESKTOP ENVIRONMENT"
                                            font.pixelSize: 18
                                            font.bold: true
                                            color: "#ffffff"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "RED QUEEN 60-30-10 CHROMATIC ACCENTS & SILENT BOOT"
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: "#cc0000"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "Synchronized dark desktop experience with KWin Gaussian blur, Wayland acceleration, custom Plymouth boot animations, and the Red Queen HUD terminal."
                                            font.pixelSize: 12
                                            color: "#a0a0a0"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillWidth: true
                                        }
                                    }
                                }

                                // SLIDE 4: Disk Installation & NVMe
                                Item {
                                    anchors.fill: parent
                                    opacity: root.currentSlideIndex === 3 ? 1.0 : 0.0
                                    Behavior on opacity { NumberAnimation { duration: 400 } }
                                    visible: opacity > 0

                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 14
                                        width: Math.min(parent.width - 60, 600)

                                        Rectangle {
                                            Layout.preferredWidth: 70
                                            Layout.preferredHeight: 70
                                            Layout.alignment: Qt.AlignHCenter
                                            radius: 12
                                            color: "#180303"
                                            border.color: "#cc0000"
                                            border.width: 1.5

                                            Text {
                                                anchors.centerIn: parent
                                                text: "SSD"
                                                font.pixelSize: 22
                                                font.bold: true
                                                font.family: "Monospace"
                                                color: "#00cc66"
                                            }
                                        }

                                        Text {
                                            text: "INSTALLING TO STORAGE DRIVE"
                                            font.pixelSize: 18
                                            font.bold: true
                                            color: "#ffffff"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "OPTIMIZED NVME / SSD STORAGE • GRUB UEFI • BTRFS"
                                            font.pixelSize: 11
                                            font.bold: true
                                            color: "#cc0000"
                                            Layout.alignment: Qt.AlignHCenter
                                        }

                                        Text {
                                            text: "Calamares is deploying the complete system directly to /dev/nvme0n1 with continuous TRIM support, modern PipeWire audio, and secure user sandboxing."
                                            font.pixelSize: 12
                                            color: "#a0a0a0"
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillWidth: true
                                        }
                                    }
                                }

                                // Collapsible Terminal Logs Drawer (Overlay)
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    height: root.showTerminalLog ? 160 : 0
                                    Behavior on height { NumberAnimation { duration: 250 } }
                                    color: "#050101"
                                    opacity: 0.95
                                    border.color: "#cc0000"
                                    border.width: 1
                                    clip: true

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 8
                                        spacing: 4

                                        RowLayout {
                                            Layout.fillWidth: true
                                            Text { text: "TERMINAL CONSOLE OUTPUT (PACMAN / MKINITCPIO / CALAMARES):"; font.pixelSize: 9; font.bold: true; font.family: "Monospace"; color: "#ff3333" }
                                            Item { Layout.fillWidth: true }
                                            Rectangle {
                                                width: hideLogsText.contentWidth + 12
                                                height: 20
                                                radius: 3
                                                color: "#2a0505"
                                                border.color: "#661111"
                                                Text {
                                                    id: hideLogsText
                                                    anchors.centerIn: parent
                                                    text: "HIDE LOGS [X]"
                                                    font.pixelSize: 9
                                                    font.bold: true
                                                    font.family: "Monospace"
                                                    color: "#dddddd"
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: root.showTerminalLog = false
                                                }
                                            }
                                        }

                                        ListView {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            model: root.terminalLogs
                                            delegate: Text {
                                                text: modelData
                                                font.pixelSize: 9
                                                font.family: "Monospace"
                                                color: "#00cc66"
                                            }
                                        }
                                    }
                                }
                            }

                            // Bottom Installation Progress Bar & Slide Controls
                            Rectangle {
                                Layout.fillWidth: true
                                height: 96
                                color: "#090101"

                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    height: 1
                                    color: "#2a0808"
                                }

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 6

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: root.getInstallStepText()
                                            font.pixelSize: 11
                                            font.family: "Monospace"
                                            color: "#cccccc"
                                        }
                                        Item { Layout.fillWidth: true }
                                        Text {
                                            text: Math.floor(root.installProgress * 100) + "%"
                                            font.pixelSize: 12
                                            font.bold: true
                                            font.family: "Monospace"
                                            color: "#ff2222"
                                        }
                                    }

                                    // Progress Bar
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: 6
                                        radius: 3
                                        color: "#1a0404"

                                        Rectangle {
                                            width: parent.width * root.installProgress
                                            height: parent.height
                                            radius: 3
                                            gradient: Gradient {
                                                orientation: Gradient.Horizontal
                                                GradientStop { position: 0.0; color: "#880000" }
                                                GradientStop { position: 1.0; color: "#ff1111" }
                                            }
                                        }
                                    }

                                    // Slide Navigation & Simulator Controls Row
                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        // Slide dots
                                        Row {
                                            spacing: 5
                                            Repeater {
                                                model: root.totalSlidesCount
                                                Rectangle {
                                                    width: index === root.currentSlideIndex ? 20 : 6
                                                    height: 6
                                                    radius: 3
                                                    color: index === root.currentSlideIndex ? "#cc0000" : "#333333"
                                                    Behavior on width { NumberAnimation { duration: 200 } }
                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onClicked: { root.currentSlideIndex = index; autoSlideTimer.restart() }
                                                    }
                                                }
                                            }
                                        }

                                        // Prev / Next Slides
                                        Rectangle {
                                            width: 60; height: 24; radius: 3; color: "#160303"; border.color: "#551111"
                                            Text { anchors.centerIn: parent; text: "◀ Prev"; font.pixelSize: 10; color: "#ddd" }
                                            MouseArea { anchors.fill: parent; onClicked: { root.currentSlideIndex = (root.currentSlideIndex - 1 + root.totalSlidesCount) % root.totalSlidesCount; autoSlideTimer.restart() } }
                                        }
                                        Rectangle {
                                            width: 60; height: 24; radius: 3; color: "#160303"; border.color: "#551111"
                                            Text { anchors.centerIn: parent; text: "Next ▶"; font.pixelSize: 10; color: "#ddd" }
                                            MouseArea { anchors.fill: parent; onClicked: { root.currentSlideIndex = (root.currentSlideIndex + 1) % root.totalSlidesCount; autoSlideTimer.restart() } }
                                        }

                                        // AutoPlay toggle
                                        Rectangle {
                                            width: 72; height: 24; radius: 3
                                            color: root.autoPlayEnabled ? "#220505" : "#160303"
                                            border.color: root.autoPlayEnabled ? "#cc0000" : "#551111"
                                            Text { anchors.centerIn: parent; text: root.autoPlayEnabled ? "⏸ Pause" : "▶ Play"; font.pixelSize: 10; color: "#ddd" }
                                            MouseArea { anchors.fill: parent; onClicked: root.autoPlayEnabled = !root.autoPlayEnabled }
                                        }

                                        Item { Layout.fillWidth: true }

                                        // Toggle Terminal Log button
                                        Rectangle {
                                            width: 105; height: 24; radius: 3; color: "#1a0505"; border.color: "#cc0000"
                                            Text { anchors.centerIn: parent; text: root.showTerminalLog ? "▼ Hide Logs" : "▲ Show Logs"; font.pixelSize: 10; font.bold: true; color: "#ff4444" }
                                            MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.showTerminalLog = !root.showTerminalLog }
                                        }

                                        // Fast Forward (100%) Simulation button
                                        Rectangle {
                                            width: 130; height: 24; radius: 3; color: "#250808"; border.color: "#ff3333"
                                            Text { anchors.centerIn: parent; text: "⏩ Complete (100%)"; font.pixelSize: 10; font.bold: true; color: "#ffffff" }
                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: {
                                                    root.installProgress = 1.0
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // --------------------------------------------------------
                    // SECTION 8: FINISH
                    // --------------------------------------------------------
                    Item {
                        anchors.fill: parent
                        visible: root.currentSectionIndex === 7
                        anchors.margins: 24

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 18
                            width: Math.min(parent.width - 60, 600)

                            // Glowing Umbrella Emblem
                            Item {
                                Layout.preferredWidth: 96
                                Layout.preferredHeight: 96
                                Layout.alignment: Qt.AlignHCenter

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 96
                                    height: 96
                                    radius: 48
                                    color: "#160303"
                                    border.color: "#00cc66"
                                    border.width: 2

                                    Image {
                                        anchors.centerIn: parent
                                        source: "../archiso/airootfs/usr/share/pixmaps/umbrella-logo.png"
                                        width: 72
                                        height: 72
                                        fillMode: Image.PreserveAspectFit
                                        smooth: true
                                    }
                                }
                            }

                            Text {
                                text: "Installation Complete"
                                font.pixelSize: 22
                                font.bold: true
                                color: "#ffffff"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "UMBRELLA OS HAS BEEN SUCCESSFULLY INSTALLED"
                                font.pixelSize: 12
                                font.bold: true
                                color: "#00cc66"
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: "The Red Queen Hive Operating System has been successfully deployed to /dev/nvme0n1. You may now restart into your newly installed system, or continue exploring the live ISO environment."
                                font.pixelSize: 12
                                color: "#bbbbbb"
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                                Layout.fillWidth: true
                            }

                            // Telemetry Badges
                            Rectangle {
                                Layout.fillWidth: true
                                height: 60
                                radius: 6
                                color: "#140404"
                                border.color: "#330808"
                                border.width: 1

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 16

                                    ColumnLayout {
                                        spacing: 1
                                        Text { text: "OPERATING SYSTEM:"; font.pixelSize: 9; font.family: "Monospace"; color: "#888" }
                                        Text { text: "Umbrella OS 1.0 (x86_64)"; font.pixelSize: 11; font.bold: true; color: "#fff" }
                                    }

                                    ColumnLayout {
                                        spacing: 1
                                        Text { text: "TARGET DRIVE:"; font.pixelSize: 9; font.family: "Monospace"; color: "#888" }
                                        Text { text: "/dev/nvme0n1 (GPT Btrfs)"; font.pixelSize: 11; font.bold: true; color: "#00cc66" }
                                    }

                                    ColumnLayout {
                                        spacing: 1
                                        Text { text: "DEFAULT OPERATOR:"; font.pixelSize: 9; font.family: "Monospace"; color: "#888" }
                                        Text { text: root.userName + "@" + root.hostName; font.pixelSize: 11; font.bold: true; color: "#fff" }
                                    }
                                }
                            }

                            // Restart now toggle checkbox
                            RowLayout {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 10

                                Rectangle {
                                    width: 20
                                    height: 20
                                    radius: 4
                                    color: root.restartNowChecked ? "#cc0000" : "#1a0404"
                                    border.color: "#ff3333"
                                    border.width: 1

                                    Text {
                                        anchors.centerIn: parent
                                        text: root.restartNowChecked ? "✓" : ""
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "#ffffff"
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: root.restartNowChecked = !root.restartNowChecked
                                    }
                                }

                                Text {
                                    text: "Restart now"
                                    font.pixelSize: 13
                                    font.bold: true
                                    color: "#ffffff"
                                }
                            }
                        }
                    }
                }

                // ============================================================
                // BOTTOM CALAMARES NAVIGATION BAR
                // ============================================================
                Rectangle {
                    Layout.fillWidth: true
                    height: 52
                    color: "#080101"

                    // Dividing Line
                    Rectangle {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 1
                        color: "#2a0808"
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 20
                        spacing: 14

                        // Section status badge
                        Rectangle {
                            height: 26
                            Layout.preferredWidth: secBadgeText.contentWidth + 18
                            radius: 3
                            color: "#180303"
                            border.color: "#551111"
                            border.width: 1

                            Text {
                                id: secBadgeText
                                anchors.centerIn: parent
                                text: "STEP [ " + (root.currentSectionIndex + 1) + " / 8 ] : " + root.stepNames[root.currentSectionIndex].toUpperCase()
                                font.pixelSize: 10
                                font.bold: true
                                font.family: "Monospace"
                                color: "#ff3333"
                            }
                        }

                        Item { Layout.fillWidth: true }

                        // Cancel Button
                        Rectangle {
                            width: 80
                            height: 30
                            radius: 4
                            color: cancelMouse.containsMouse ? "#240404" : "#140202"
                            border.color: "#441111"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "Cancel"
                                font.pixelSize: 11
                                color: "#cccccc"
                            }

                            MouseArea {
                                id: cancelMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Qt.quit()
                            }
                        }

                        // Back Button
                        Rectangle {
                            width: 80
                            height: 30
                            radius: 4
                            enabled: root.currentSectionIndex > 0 && root.currentSectionIndex !== 6
                            opacity: enabled ? 1.0 : 0.4
                            color: backMouse.containsMouse ? "#260606" : "#160303"
                            border.color: "#551111"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "◀ Back"
                                font.pixelSize: 11
                                color: "#ffffff"
                            }

                            MouseArea {
                                id: backMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: parent.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                                onClicked: root.prevSection()
                            }
                        }

                        // Next / Install / Done Button
                        Rectangle {
                            width: root.currentSectionIndex === 5 ? 120 : (root.currentSectionIndex === 7 ? 130 : 90)
                            height: 30
                            radius: 4
                            color: root.currentSectionIndex === 5 ? "#cc0000" : (nextMouse.containsMouse ? "#aa0000" : "#880000")
                            border.color: root.currentSectionIndex === 5 ? "#ff4444" : "#cc2222"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: root.currentSectionIndex === 5 ? "Install Now ▶" : (root.currentSectionIndex === 7 ? "Done / Reboot" : (root.currentSectionIndex === 6 ? (root.installProgress >= 1.0 ? "Next ▶" : "Installing...") : "Next ▶"))
                                font.pixelSize: 11
                                font.bold: true
                                color: "#ffffff"
                            }

                            MouseArea {
                                id: nextMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.nextSection()
                            }
                        }
                    }
                }
            }
        }
    }

    // ========================================================================
    // MODAL DIALOGS (REBOOT SIMULATION)
    // ========================================================================
    Rectangle {
        id: rebootModal
        anchors.fill: parent
        color: "#d0000000"
        visible: false

        Rectangle {
            anchors.centerIn: parent
            width: 440
            height: 220
            radius: 8
            color: "#160303"
            border.color: "#cc0000"
            border.width: 1.5

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 14

                Text {
                    text: root.restartNowChecked ? "REBOOTING UMBRELLA OS NODE..." : "INSTALLATION FINISHED"
                    font.pixelSize: 14
                    font.bold: true
                    font.family: "Monospace"
                    color: "#ff2222"
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: root.restartNowChecked ?
                          "System will now restart into Umbrella OS (Red Queen Edition) on /dev/nvme0n1.\n\nAll security directives active. Live ISO unmounted." :
                          "You may now close the installer and explore the live Arch Linux environment."
                    font.pixelSize: 11
                    color: "#dddddd"
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 16

                    Rectangle {
                        width: 110
                        height: 32
                        radius: 4
                        color: "#cc0000"
                        Text { anchors.centerIn: parent; text: "OK / Exit"; font.pixelSize: 11; font.bold: true; color: "#fff" }
                        MouseArea { anchors.fill: parent; onClicked: Qt.quit() }
                    }

                    Rectangle {
                        width: 110
                        height: 32
                        radius: 4
                        color: "#2a0808"
                        border.color: "#551111"
                        Text { anchors.centerIn: parent; text: "Back to UI"; font.pixelSize: 11; color: "#fff" }
                        MouseArea { anchors.fill: parent; onClicked: rebootModal.visible = false }
                    }
                }
            }
        }
    }
}
