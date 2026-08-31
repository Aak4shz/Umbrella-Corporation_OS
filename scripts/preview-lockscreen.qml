import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: root
    width: 1366
    height: 768
    visible: true
    title: "Umbrella OS — Red Queen Lock Screen Preview (Simulation)"
    color: "#0a0a0a"

    // Load Custom Fonts
    FontLoader {
        id: glitchFont
        source: "../archiso/airootfs/usr/share/fonts/TTF/CfGlitchCityRegular_L1vZ.ttf"
    }

    FontLoader {
        id: transformersFont
        source: "../archiso/airootfs/usr/share/fonts/TTF/Transformers_Movie.ttf"
    }

    FontLoader {
        id: uniNeueBold
        source: "../archiso/airootfs/usr/share/fonts/TTF/UniNeue-Trial-Bold.ttf"
    }

    FontLoader {
        id: hackedFont
        source: "../archiso/airootfs/usr/share/fonts/TTF/Hacked-KerX.ttf"
    }

    // Background: Dark Atmospheric Wallpaper with subtle Gaussian blur/overlay
    Image {
        id: bg
        anchors.fill: parent
        source: "../assets/wallpapers/Welcome_Wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true

        // Dark Security Overlay (Simulates Screen Lock Dimming)
        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.65
        }

        // Ambient Red Hologram Vignette
        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.9
            height: parent.height * 0.9
            radius: width / 2
            color: "#1a0000"
            opacity: 0.25
        }
    }

    // Center Lock Screen Interface Container
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16
        width: 440

        // ── TIME & DATE HUD (CF Glitch City Font) ──────────────────────────
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 2

            Text {
                id: timeText
                Layout.alignment: Qt.AlignHCenter
                font.family: glitchFont.name || "CF Glitch City"
                font.pixelSize: 56
                font.bold: true
                color: "#ffffff"
                style: Text.Outline
                styleColor: "#660000"

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: {
                        var d = new Date();
                        timeText.text = Qt.formatDateTime(d, "hh:mm:ss AP").toUpperCase();
                        dateText.text = Qt.formatDateTime(d, "dddd  •  d MMMM yyyy").toUpperCase();
                    }
                }
            }

            Text {
                id: dateText
                Layout.alignment: Qt.AlignHCenter
                font.family: glitchFont.name || "CF Glitch City"
                font.pixelSize: 20
                font.bold: true
                color: "#ff2222"
                style: Text.Outline
                styleColor: "#330000"
            }
        }

        Item { Layout.preferredHeight: 10 }

        // ── USER PROFILE & UNLOCK FORM ─────────────────────────────────────
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            spacing: 14

            // Animated Biohazard Emblem / User Badge
            Item {
                Layout.alignment: Qt.AlignHCenter
                width: 90
                height: 90

                Image {
                    anchors.centerIn: parent
                    width: 86
                    height: 86
                    source: "../assets/Resident-Evil-Logo.png"
                    fillMode: Image.PreserveAspectFit
                    smooth: true

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { from: 0.85; to: 1.0; duration: 1200; easing.type: Easing.InOutQuad }
                        NumberAnimation { from: 1.0; to: 0.85; duration: 1200; easing.type: Easing.InOutQuad }
                    }
                }
            }

            // User Name Label
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "umbrella"
                font.family: glitchFont.name || "CF Glitch City"
                font.pixelSize: 22
                font.bold: true
                color: "#ffffff"
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

            // Password Field with Unlock Action
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    text: "Password"
                    font.family: hackedFont.name || "HACKED"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#ff2222"
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 42
                    color: "#181818"
                    radius: 8
                    border.color: passwordInput.activeFocus ? "#ff2222" : "#383838"
                    border.width: passwordInput.activeFocus ? 2 : 1

                    TextInput {
                        id: passwordInput
                        anchors.fill: parent
                        anchors.margins: 10
                        text: ""
                        echoMode: TextInput.Password
                        font.family: "JetBrains Mono"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#ffffff"
                        verticalAlignment: TextInput.AlignVCenter
                        focus: true
                        selectByMouse: true
                        Keys.onReturnPressed: unlockButton.triggerUnlock()
                    }
                }
            }

            // Unlock Button
            Rectangle {
                id: unlockButton
                Layout.fillWidth: true
                height: 44
                color: unlockArea.containsMouse ? "#e60000" : "#cc0000"
                radius: 8

                function triggerUnlock() {
                    unlockLabel.text = "UNLOCKED ✓";
                    unlockButton.color = "#00aa44";
                }

                Text {
                    id: unlockLabel
                    anchors.centerIn: parent
                    text: "UNLOCK WORKSPACE"
                    font.family: hackedFont.name || "HACKED"
                    font.bold: true
                    font.pixelSize: 14
                    color: "#ffffff"
                }

                MouseArea {
                    id: unlockArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: unlockButton.triggerUnlock()
                }
            }
        }
    }

    // Bottom Power Icons (Shutdown, Reboot, Sleep)
    RowLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 32
        spacing: 36

        // 🔴 Shutdown
        Rectangle {
            width: 46
            height: 46
            radius: 23
            scale: shutMouse.pressed ? 0.92 : (shutMouse.containsMouse ? 1.08 : 1.0)
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: shutMouse.containsMouse ? "#ff2a4b" : "#d91438" }
                GradientStop { position: 1.0; color: shutMouse.containsMouse ? "#99001b" : "#55000e" }
            }
            border.color: shutMouse.containsMouse ? "#ff6680" : "#ff1133"
            border.width: 2

            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

            Image {
                anchors.centerIn: parent
                width: 20
                height: 20
                sourceSize.width: 40
                sourceSize.height: 40
                source: "../assets/icon-shutdown.svg"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                id: shutMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: unlockLabel.text = "SHUTDOWN INITIATED..."
            }
        }

        // 🟠 Reboot
        Rectangle {
            width: 46
            height: 46
            radius: 23
            scale: rebMouse.pressed ? 0.92 : (rebMouse.containsMouse ? 1.08 : 1.0)
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: rebMouse.containsMouse ? "#ffaa00" : "#d97706" }
                GradientStop { position: 1.0; color: rebMouse.containsMouse ? "#92400e" : "#451a03" }
            }
            border.color: rebMouse.containsMouse ? "#ffcc66" : "#f59e0b"
            border.width: 2

            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

            Image {
                anchors.centerIn: parent
                width: 20
                height: 20
                sourceSize.width: 40
                sourceSize.height: 40
                source: "../assets/icon-reboot.svg"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                id: rebMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: unlockLabel.text = "REBOOT INITIATED..."
            }
        }

        // 🔵 Sleep
        Rectangle {
            width: 46
            height: 46
            radius: 23
            scale: sleepMouse.pressed ? 0.92 : (sleepMouse.containsMouse ? 1.08 : 1.0)
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: sleepMouse.containsMouse ? "#00e5ff" : "#0284c7" }
                GradientStop { position: 1.0; color: sleepMouse.containsMouse ? "#0369a1" : "#082f49" }
            }
            border.color: sleepMouse.containsMouse ? "#80f2ff" : "#0ea5e9"
            border.width: 2

            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

            Image {
                anchors.centerIn: parent
                width: 20
                height: 20
                sourceSize.width: 40
                sourceSize.height: 40
                source: "../assets/icon-sleep.svg"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                id: sleepMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: unlockLabel.text = "SLEEP MODE..."
            }
        }
    }
}
