import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: root
    width: 1366
    height: 768
    visible: true
    title: "Umbrella OS — Red Queen SDDM Login Screen (Raccoon City Edition)"
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

    // Fullscreen Background Wallpaper
    Image {
        id: bg
        anchors.fill: parent
        source: "../assets/wallpapers/Welcome_Wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true

        // Left Ambient Dark Vignette
        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width * 0.50
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#d8000000" }
                GradientStop { position: 0.70; color: "#70000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }
    }

    // Left-Shifted Master Container (Shifted Upwards for bottom breathing room)
    Item {
        id: leftContainer
        anchors.left: parent.left
        anchors.leftMargin: Math.max(70, parent.width * 0.08)
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -35
        width: 440
        height: 620

        ColumnLayout {
            anchors.fill: parent
            spacing: 12

            // ── TIME & DATE HUD (CF Glitch City Font - Uppercase) ──────────────
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 2

                // Time (Top - Large Glitch Font)
                Text {
                    id: timeText
                    Layout.alignment: Qt.AlignHCenter
                    font.family: glitchFont.name || "CF Glitch City"
                    font.pixelSize: 50
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

                // Date (Bottom - Glitch City)
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

            Item { Layout.preferredHeight: 4 }

            // ── COMPLETELY FRAMELESS / TRANSPARENT LOGIN INTERFACE ─────────────
            Item {
                id: loginCard
                Layout.fillWidth: true
                Layout.preferredHeight: 380

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 12

                    // Big Animated Biohazard Emblem
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "../assets/Resident-Evil-Logo.png"
                        sourceSize.width: 90
                        sourceSize.height: 90
                        fillMode: Image.PreserveAspectFit
                        smooth: true

                        SequentialAnimation on opacity {
                            loops: Animation.Infinite
                            NumberAnimation { from: 0.88; to: 1.0; duration: 1100; easing.type: Easing.InOutQuad }
                            NumberAnimation { from: 1.0; to: 0.88; duration: 1100; easing.type: Easing.InOutQuad }
                        }
                    }

                    // Main Header Text (CF Glitch City Font)
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "UMBRELLA CORPORATION"
                        font.family: glitchFont.name || "CF Glitch City"
                        font.pixelSize: 22
                        font.bold: true
                        color: "#ffffff"
                        style: Text.Outline
                        styleColor: "#440000"
                    }

                    // Subtitle Text (HACKED Font)
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Red Queen Security Protocol"
                        font.family: hackedFont.name || "HACKED"
                        font.pixelSize: 13
                        font.bold: true
                        color: "#ff2222"
                    }

                    Item { Layout.preferredHeight: 4 }

                    // Username Input Field ("User" in HACKED Red Font)
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        Text {
                            text: "User"
                            font.family: hackedFont.name || "HACKED"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#ff2222"
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 42
                            color: "#181818"
                            radius: 8
                            border.color: usernameInput.activeFocus ? "#ff2222" : "#383838"
                            border.width: usernameInput.activeFocus ? 2 : 1

                            TextInput {
                                id: usernameInput
                                anchors.fill: parent
                                anchors.margins: 10
                                text: "umbrella"
                                font.family: "JetBrains Mono"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#ffffff"
                                verticalAlignment: TextInput.AlignVCenter
                                selectByMouse: true
                            }
                        }
                    }

                    // Password Input Field ("Password" in HACKED Red Font)
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        Text {
                            text: "Password"
                            font.family: hackedFont.name || "HACKED"
                            font.pixelSize: 14
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
                                text: "umbrella"
                                echoMode: TextInput.Password
                                font.family: "JetBrains Mono"
                                font.pixelSize: 14
                                font.bold: true
                                color: "#ffffff"
                                verticalAlignment: TextInput.AlignVCenter
                                selectByMouse: true
                                Keys.onReturnPressed: authButton.triggerAuth()
                            }
                        }
                    }

                    Item { Layout.preferredHeight: 2 }

                    // Authenticate Button
                    Rectangle {
                        id: authButton
                        Layout.fillWidth: true
                        height: 44
                        color: authArea.containsMouse ? "#e60000" : "#cc0000"
                        radius: 8

                        function triggerAuth() {
                            authLabel.text = "AUTHENTICATED ✓";
                            authButton.color = "#00aa44";
                        }

                        Text {
                            id: authLabel
                            anchors.centerIn: parent
                            text: "AUTHENTICATE"
                            font.family: hackedFont.name || "HACKED"
                            font.bold: true
                            font.pixelSize: 14
                            color: "#ffffff"
                        }

                        MouseArea {
                            id: authArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: authButton.triggerAuth()
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 8 }

            // ── PERFECTLY CENTERED 3D NEON POWER BUTTONS (SOLID VECTOR SVG ICONS) ───
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 40

                // 🔴 1. 3D NEON RED SHUTDOWN BUTTON
                ColumnLayout {
                    spacing: 6
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        id: shutBtn
                        width: 52
                        height: 52
                        radius: 26
                        scale: shutMouse.pressed ? 0.92 : (shutMouse.containsMouse ? 1.08 : 1.0)
                        gradient: Gradient {
                            orientation: Gradient.Vertical
                            GradientStop { position: 0.0; color: shutMouse.containsMouse ? "#ff2a4b" : "#d91438" }
                            GradientStop { position: 1.0; color: shutMouse.containsMouse ? "#99001b" : "#55000e" }
                        }
                        border.color: shutMouse.containsMouse ? "#ff6680" : "#ff1133"
                        border.width: 2

                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

                        // Glowing Aura
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            radius: 30
                            color: "transparent"
                            border.color: "#ff0033"
                            border.width: 1.5
                            opacity: shutMouse.containsMouse ? 0.85 : 0.0
                            Behavior on opacity { NumberAnimation { duration: 200 } }
                        }

                        // Native Crisp SVG Vector Icon
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "../assets/icon-shutdown.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: shutMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                authLabel.text = "SHUTDOWN INITIATED...";
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "SHUTDOWN"
                        font.family: hackedFont.name || "HACKED"
                        font.pixelSize: 11
                        font.bold: true
                        color: shutMouse.containsMouse ? "#ff4d6a" : "#999999"
                    }
                }

                // 🟠 2. 3D NEON AMBER REBOOT BUTTON
                ColumnLayout {
                    spacing: 6
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        id: rebBtn
                        width: 52
                        height: 52
                        radius: 26
                        scale: rebMouse.pressed ? 0.92 : (rebMouse.containsMouse ? 1.08 : 1.0)
                        gradient: Gradient {
                            orientation: Gradient.Vertical
                            GradientStop { position: 0.0; color: rebMouse.containsMouse ? "#ffaa00" : "#d97706" }
                            GradientStop { position: 1.0; color: rebMouse.containsMouse ? "#92400e" : "#451a03" }
                        }
                        border.color: rebMouse.containsMouse ? "#ffcc66" : "#f59e0b"
                        border.width: 2

                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            radius: 30
                            color: "transparent"
                            border.color: "#ff9900"
                            border.width: 1.5
                            opacity: rebMouse.containsMouse ? 0.85 : 0.0
                            Behavior on opacity { NumberAnimation { duration: 200 } }
                        }

                        // Native Crisp SVG Vector Icon
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "../assets/icon-reboot.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: rebMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                authLabel.text = "REBOOT INITIATED...";
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "REBOOT"
                        font.family: hackedFont.name || "HACKED"
                        font.pixelSize: 11
                        font.bold: true
                        color: rebMouse.containsMouse ? "#ffb733" : "#999999"
                    }
                }

                // 🔵 3. 3D NEON ELECTRIC BLUE SLEEP BUTTON
                ColumnLayout {
                    spacing: 6
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        id: sleepBtn
                        width: 52
                        height: 52
                        radius: 26
                        scale: sleepMouse.pressed ? 0.92 : (sleepMouse.containsMouse ? 1.08 : 1.0)
                        gradient: Gradient {
                            orientation: Gradient.Vertical
                            GradientStop { position: 0.0; color: sleepMouse.containsMouse ? "#00e5ff" : "#0284c7" }
                            GradientStop { position: 1.0; color: sleepMouse.containsMouse ? "#0369a1" : "#082f49" }
                        }
                        border.color: sleepMouse.containsMouse ? "#80f2ff" : "#0ea5e9"
                        border.width: 2

                        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: -4
                            radius: 30
                            color: "transparent"
                            border.color: "#00e5ff"
                            border.width: 1.5
                            opacity: sleepMouse.containsMouse ? 0.85 : 0.0
                            Behavior on opacity { NumberAnimation { duration: 200 } }
                        }

                        // Native Crisp SVG Vector Icon
                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "../assets/icon-sleep.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: sleepMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                authLabel.text = "SLEEP MODE...";
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "SLEEP"
                        font.family: hackedFont.name || "HACKED"
                        font.pixelSize: 11
                        font.bold: true
                        color: sleepMouse.containsMouse ? "#33ebff" : "#999999"
                    }
                }
            }
        }
    }
}
