import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: root
    width: 1366
    height: 768
    visible: true
    title: "Umbrella OS — Full Boot Lifecycle (Plymouth → SDDM → Splash → Lockscreen)"
    color: "#050505"

    // 0: Plymouth Boot -> 1: SDDM Login -> 2: Video Splash -> 3: Lock Screen
    property int currentStage: 0
    property int plymouthFrameIndex: 0
    property real plymouthProgress: 0.0

    // ── LOAD CUSTOM SYSTEM FONTS ──────────────────────────────────────────────
    FontLoader { id: glitchFont; source: "../archiso/airootfs/usr/share/fonts/TTF/CfGlitchCityRegular_L1vZ.ttf" }
    FontLoader { id: transformersFont; source: "../archiso/airootfs/usr/share/fonts/TTF/Transformers_Movie.ttf" }
    FontLoader { id: uniNeueBold; source: "../archiso/airootfs/usr/share/fonts/TTF/UniNeue-Trial-Bold.ttf" }
    FontLoader { id: uniNeueRegular; source: "../archiso/airootfs/usr/share/fonts/TTF/UniNeue-Trial-Regular.ttf" }
    FontLoader { id: hackedFont; source: "../archiso/airootfs/usr/share/fonts/TTF/Hacked-KerX.ttf" }
    FontLoader { id: bladeRunnerFont; source: "../archiso/airootfs/usr/share/fonts/TTF/BLADRMF_.ttf" }

    // ═════════════════════════════════════════════════════════════════════════
    // STAGE 0: PLYMOUTH EARLY BOOT SPLASH
    // ═════════════════════════════════════════════════════════════════════════
    Rectangle {
        id: plymouthView
        anchors.fill: parent
        color: "#0a0a0a"
        visible: root.currentStage === 0
        opacity: root.currentStage === 0 ? 1.0 : 0.0

        Behavior on opacity { NumberAnimation { duration: 400 } }

        Timer {
            interval: 32
            running: root.currentStage === 0
            repeat: true
            onTriggered: root.plymouthFrameIndex = (root.plymouthFrameIndex + 1) % 36
        }

        Timer {
            interval: 45
            running: root.currentStage === 0
            repeat: true
            onTriggered: {
                if (root.plymouthProgress < 1.0) {
                    root.plymouthProgress = Math.min(1.0, root.plymouthProgress + 0.012);
                } else {
                    // Natural seamless transition to SDDM Login on 100% completion
                    transitionToSddmTimer.start();
                }
            }
        }

        Timer {
            id: transitionToSddmTimer
            interval: 600
            repeat: false
            onTriggered: root.currentStage = 1
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 16

            Item {
                Layout.alignment: Qt.AlignHCenter
                width: 240; height: 240
                Image {
                    anchors.centerIn: parent
                    width: 240; height: 240
                    source: "../archiso/airootfs/usr/share/plymouth/themes/umbrella-plymouth/spinner-" + root.plymouthFrameIndex + ".png"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "UMBRELLA CORPORATION"
                font.family: glitchFont.name || "CF Glitch City"
                font.pixelSize: 30
                font.bold: true
                color: "#ffffff"
                style: Text.Outline
                styleColor: "#440000"
            }

            Item { Layout.preferredHeight: 12 }

            // CF Glitch City Loading Percentage
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Math.floor(root.plymouthProgress * 100) + " %"
                font.family: glitchFont.name || "CF Glitch City"
                font.pixelSize: 32
                font.bold: true
                color: "#ff0000"
                style: Text.Outline
                styleColor: "#440000"
            }

            // Cyberpunk Rectangular Loading Bar
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 480; height: 36
                color: "#0d0d0d"
                border.color: "#cc0000"; border.width: 2
                radius: 4

                Rectangle {
                    anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom
                    anchors.margins: 4
                    width: Math.max(4, (parent.width - 8) * root.plymouthProgress)
                    color: "#ff0000"; radius: 2
                }
            }
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    // STAGE 1: SDDM LOGIN GREETER (RACCOON CITY EDITION)
    // ═════════════════════════════════════════════════════════════════════════
    Item {
        id: sddmView
        anchors.fill: parent
        visible: root.currentStage === 1
        opacity: root.currentStage === 1 ? 1.0 : 0.0

        Behavior on opacity { NumberAnimation { duration: 400 } }

        Image {
            anchors.fill: parent
            source: "../assets/wallpapers/Welcome_Wallpaper.png"
            fillMode: Image.PreserveAspectCrop
            smooth: true

            Rectangle {
                anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.left: parent.left
                width: parent.width * 0.50
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#d8000000" }
                    GradientStop { position: 0.70; color: "#70000000" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
            }
        }

        Item {
            anchors.left: parent.left
            anchors.leftMargin: Math.max(70, parent.width * 0.08)
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -35
            width: 440; height: 620

            ColumnLayout {
                anchors.fill: parent
                spacing: 12

                // CF Glitch City HUD Clock & Date
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 2

                    Text {
                        id: sddmTime
                        Layout.alignment: Qt.AlignHCenter
                        font.family: glitchFont.name || "CF Glitch City"
                        font.pixelSize: 50; font.bold: true; color: "#ffffff"
                        style: Text.Outline; styleColor: "#660000"

                        Timer {
                            interval: 1000; running: root.currentStage === 1; repeat: true; triggeredOnStart: true
                            onTriggered: {
                                var d = new Date();
                                sddmTime.text = Qt.formatDateTime(d, "hh:mm:ss AP").toUpperCase();
                                sddmDate.text = Qt.formatDateTime(d, "dddd  •  d MMMM yyyy").toUpperCase();
                            }
                        }
                    }

                    Text {
                        id: sddmDate
                        Layout.alignment: Qt.AlignHCenter
                        font.family: glitchFont.name || "CF Glitch City"
                        font.pixelSize: 20; font.bold: true; color: "#ff2222"
                    }
                }

                Item { Layout.preferredHeight: 4 }

                // Frameless Login Form
                Item {
                    Layout.fillWidth: true; Layout.preferredHeight: 380

                    ColumnLayout {
                        anchors.fill: parent; spacing: 12

                        Image {
                            Layout.alignment: Qt.AlignHCenter
                            source: "../assets/Resident-Evil-Logo.png"
                            sourceSize.width: 90; sourceSize.height: 90
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "UMBRELLA CORPORATION"
                            font.family: glitchFont.name || "CF Glitch City"
                            font.pixelSize: 22; font.bold: true; color: "#ffffff"
                            style: Text.Outline
                            styleColor: "#440000"
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Red Queen Security Protocol"
                            font.family: hackedFont.name || "HACKED"
                            font.pixelSize: 13
                            font.bold: true
                            color: "#ff2222"
                        }

                        Item { Layout.preferredHeight: 4 }

                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4
                            Text { text: "User"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 14; font.bold: true; color: "#ff2222" }
                            Rectangle {
                                Layout.fillWidth: true; height: 42; color: "#181818"; radius: 8; border.color: "#383838"
                                TextInput { anchors.fill: parent; anchors.margins: 10; text: "umbrella"; font.family: "JetBrains Mono"; font.pixelSize: 14; font.bold: true; color: "#ffffff"; verticalAlignment: TextInput.AlignVCenter }
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4
                            Text { text: "Password"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 14; font.bold: true; color: "#ff2222" }
                            Rectangle {
                                Layout.fillWidth: true; height: 42; color: "#181818"; radius: 8; border.color: "#383838"
                                TextInput { id: pwdField; anchors.fill: parent; anchors.margins: 10; text: "umbrella"; echoMode: TextInput.Password; font.family: "JetBrains Mono"; font.pixelSize: 14; font.bold: true; color: "#ffffff"; verticalAlignment: TextInput.AlignVCenter; Keys.onReturnPressed: authBtn.triggerLogin() }
                            }
                        }

                        Item { Layout.preferredHeight: 2 }

                        Rectangle {
                            id: authBtn
                            Layout.fillWidth: true; height: 44; color: authMouse.containsMouse ? "#e60000" : "#cc0000"; radius: 8

                            function triggerLogin() {
                                root.currentStage = 2;
                            }

                            Text { anchors.centerIn: parent; text: "AUTHENTICATE"; font.family: hackedFont.name || "HACKED"; font.bold: true; font.pixelSize: 14; color: "#ffffff" }
                            MouseArea { id: authMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: authBtn.triggerLogin() }
                        }
                    }
                }

                Item { Layout.preferredHeight: 4 }

                // 3D Neon Power Buttons
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter; spacing: 40

                    ColumnLayout {
                        spacing: 6; Layout.alignment: Qt.AlignHCenter
                        Rectangle {
                            width: 52; height: 52; radius: 26; color: "#99001b"; border.color: "#ff1133"; border.width: 2
                            Image { anchors.centerIn: parent; width: 24; height: 24; source: "../assets/icon-shutdown.svg" }
                        }
                        Text { Layout.alignment: Qt.AlignHCenter; text: "SHUTDOWN"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 11; font.bold: true; color: "#999999" }
                    }

                    ColumnLayout {
                        spacing: 6; Layout.alignment: Qt.AlignHCenter
                        Rectangle {
                            width: 52; height: 52; radius: 26; color: "#92400e"; border.color: "#f59e0b"; border.width: 2
                            Image { anchors.centerIn: parent; width: 24; height: 24; source: "../assets/icon-reboot.svg" }
                        }
                        Text { Layout.alignment: Qt.AlignHCenter; text: "REBOOT"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 11; font.bold: true; color: "#999999" }
                    }

                    ColumnLayout {
                        spacing: 6; Layout.alignment: Qt.AlignHCenter
                        Rectangle {
                            width: 52; height: 52; radius: 26; color: "#0369a1"; border.color: "#0ea5e9"; border.width: 2
                            Image { anchors.centerIn: parent; width: 24; height: 24; source: "../assets/icon-sleep.svg" }
                        }
                        Text { Layout.alignment: Qt.AlignHCenter; text: "SLEEP"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 11; font.bold: true; color: "#999999" }
                    }
                }
            }
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    // STAGE 2: POST-LOGIN NATIVE QML SPLASH SCREEN
    // ═════════════════════════════════════════════════════════════════════════
    Rectangle {
        id: splashView
        anchors.fill: parent
        color: "#0a0a0a"
        visible: root.currentStage === 2
        opacity: root.currentStage === 2 ? 1.0 : 0.0

        Behavior on opacity { NumberAnimation { duration: 400 } }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 16

            Image {
                Layout.alignment: Qt.AlignHCenter
                width: 120; height: 120
                source: "../assets/Resident-Evil-Logo.png"
                fillMode: Image.PreserveAspectFit
                smooth: true

                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.96; to: 1.04; duration: 1100; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1.04; to: 0.96; duration: 1100; easing.type: Easing.InOutQuad }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "UMBRELLA CORPORATION"
                font.family: transformersFont.name || "Transformers Movie"
                font.pixelSize: 26
                font.bold: true
                color: "#ffffff"
                style: Text.Outline
                styleColor: "#660000"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "INITIALIZING RED QUEEN CORE SERVICES..."
                font.family: hackedFont.name || "HACKED"
                font.pixelSize: 13
                font.bold: true
                color: "#ff2222"
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 320
                height: 4
                color: "#220000"
                radius: 2

                Rectangle {
                    height: parent.height
                    width: parent.width * 0.75
                    color: "#cc0000"
                    radius: 2
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "SECURITY CLEARANCE LEVEL 5 // RED QUEEN AI ACTIVE"
                font.family: "JetBrains Mono"
                font.pixelSize: 10
                color: "#555555"
            }

            Item { Layout.preferredHeight: 12 }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 16

                Rectangle {
                    width: 200; height: 46; radius: 23
                    color: lockBtnMouse.containsMouse ? "#cc0000" : "#1a1a1a"
                    border.color: "#444444"

                    Text {
                        anchors.centerIn: parent
                        text: "LOCK SCREEN →"
                        font.family: uniNeueBold.name || "Uni Neue"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#ffffff"
                    }

                    MouseArea {
                        id: lockBtnMouse
                        anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: root.currentStage = 3
                    }
                }
            }
        }
    }

    // ═════════════════════════════════════════════════════════════════════════
    // STAGE 3: RED QUEEN LOCK SCREEN
    // ═════════════════════════════════════════════════════════════════════════
    Item {
        id: lockscreenView
        anchors.fill: parent
        visible: root.currentStage === 3
        opacity: root.currentStage === 3 ? 1.0 : 0.0

        Behavior on opacity { NumberAnimation { duration: 400 } }

        Image {
            anchors.fill: parent
            source: "../assets/wallpapers/Welcome_Wallpaper.png"
            fillMode: Image.PreserveAspectCrop; smooth: true
            Rectangle { anchors.fill: parent; color: "#000000"; opacity: 0.65 }
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 16; width: 440

            // CF Glitch City HUD Clock & Date
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter; spacing: 2
                Text {
                    id: lockTime
                    Layout.alignment: Qt.AlignHCenter
                    font.family: glitchFont.name || "CF Glitch City"
                    font.pixelSize: 56; font.bold: true; color: "#ffffff"
                    style: Text.Outline; styleColor: "#660000"
                    Timer {
                        interval: 1000; running: root.currentStage === 3; repeat: true; triggeredOnStart: true
                        onTriggered: {
                            var d = new Date();
                            lockTime.text = Qt.formatDateTime(d, "hh:mm:ss AP").toUpperCase();
                            lockDate.text = Qt.formatDateTime(d, "dddd  •  d MMMM yyyy").toUpperCase();
                        }
                    }
                }
                Text {
                    id: lockDate
                    Layout.alignment: Qt.AlignHCenter
                    font.family: glitchFont.name || "CF Glitch City"
                    font.pixelSize: 20; font.bold: true; color: "#ff2222"
                }
            }

            Item { Layout.preferredHeight: 10 }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter; Layout.fillWidth: true; spacing: 14
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    width: 86; height: 86
                    source: "../assets/Resident-Evil-Logo.png"
                    fillMode: Image.PreserveAspectFit
                }

                Text { Layout.alignment: Qt.AlignHCenter; text: "umbrella"; font.family: transformersFont.name || "Transformers Movie"; font.pixelSize: 22; font.bold: true; color: "#ffffff" }
                Text { Layout.alignment: Qt.AlignHCenter; text: "Red Queen Security Protocol"; font.family: uniNeueBold.name || "Uni Neue"; font.pixelSize: 13; font.bold: true; color: "#ff2222" }

                Item { Layout.preferredHeight: 4 }

                ColumnLayout {
                    Layout.fillWidth: true; spacing: 4
                    Text { text: "Password"; font.family: uniNeueBold.name || "Uni Neue"; font.pixelSize: 13; font.bold: true; color: "#ff2222" }
                    Rectangle {
                        Layout.fillWidth: true; height: 42; color: "#181818"; radius: 8; border.color: "#383838"
                        TextInput { anchors.fill: parent; anchors.margins: 10; text: ""; echoMode: TextInput.Password; font.family: "JetBrains Mono"; font.pixelSize: 14; font.bold: true; color: "#ffffff"; verticalAlignment: TextInput.AlignVCenter; Keys.onReturnPressed: unlockBtn.triggerUnlock() }
                    }
                }

                Rectangle {
                    id: unlockBtn
                    Layout.fillWidth: true; height: 44; color: unlockMouse.containsMouse ? "#e60000" : "#cc0000"; radius: 8
                    function triggerUnlock() {
                        unlockText.text = "UNLOCKED ✓";
                        unlockBtn.color = "#00aa44";
                    }
                    Text { id: unlockText; anchors.centerIn: parent; text: "UNLOCK WORKSPACE"; font.family: uniNeueBold.name || "Uni Neue"; font.bold: true; font.pixelSize: 13; color: "#ffffff" }
                    MouseArea { id: unlockMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: unlockBtn.triggerUnlock() }
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "// WORKSPACE SECURE // AUTHORIZED ACCESS ONLY //"
                    font.family: hackedFont.name || "HACKED"
                    font.pixelSize: 10
                    color: "#555555"
                }
            }
        }

        // Bottom Power Controls
        RowLayout {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 32; spacing: 36
            Rectangle {
                width: 46; height: 46; radius: 23; color: "#99001b"; border.color: "#ff1133"; border.width: 2
                Image { anchors.centerIn: parent; width: 20; height: 20; source: "../assets/icon-shutdown.svg" }
            }
            Rectangle {
                width: 46; height: 46; radius: 23; color: "#92400e"; border.color: "#f59e0b"; border.width: 2
                Image { anchors.centerIn: parent; width: 20; height: 20; source: "../assets/icon-reboot.svg" }
            }
            Rectangle {
                width: 46; height: 46; radius: 23; color: "#0369a1"; border.color: "#0ea5e9"; border.width: 2
                Image { anchors.centerIn: parent; width: 20; height: 20; source: "../assets/icon-sleep.svg" }
            }
        }
    }
}
