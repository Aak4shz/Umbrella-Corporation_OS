import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents

/*
 * Umbrella Corporation — Red Queen SDDM Login Interface (Raccoon City Edition)
 */
Rectangle {
    id: container
    width: 1920
    height: 1080
    color: "#0a0a0a"

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    FontLoader {
        id: glitchFont
        source: "CfGlitchCityRegular_L1vZ.ttf"
    }

    FontLoader {
        id: transformersFont
        source: "/usr/share/fonts/TTF/Transformers_Movie.ttf"
    }

    FontLoader {
        id: uniNeueBold
        source: "UniNeue-Trial-Bold.ttf"
    }

    FontLoader {
        id: hackedFont
        source: "Hacked-KerX.ttf"
    }

    // Fullscreen Background Wallpaper
    Image {
        id: bg
        anchors.fill: parent
        source: config.background || "images/Welcome_Wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        clip: true

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

    // Left-Shifted Master Container
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
                        source: "images/biohazard-logo.png"
                        sourceSize.width: 90
                        sourceSize.height: 90
                        fillMode: Image.PreserveAspectFit
                        smooth: true
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

                        TextBox {
                            id: name
                            Layout.fillWidth: true
                            height: 42
                            text: userModel.lastUser || "umbrella"
                            font.pixelSize: 14
                            radius: 8
                            color: "#181818"
                            textColor: "#f0f0f0"
                            borderColor: "#383838"
                            focusColor: "#ff2222"
                            KeyNavigation.tab: password
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

                        PasswordBox {
                            id: password
                            Layout.fillWidth: true
                            height: 42
                            font.pixelSize: 14
                            radius: 8
                            color: "#181818"
                            textColor: "#f0f0f0"
                            borderColor: "#383838"
                            focusColor: "#ff2222"
                            KeyNavigation.backtab: name
                            KeyNavigation.tab: loginButton
                            Keys.onReturnPressed: sddm.login(name.text, password.text, 0)
                        }
                    }

                    Item { Layout.preferredHeight: 2 }

                    // Authenticate Button
                    Button {
                        id: loginButton
                        Layout.fillWidth: true
                        height: 44
                        text: "AUTHENTICATE"
                        font.family: hackedFont.name || "HACKED"
                        font.bold: true
                        font.pixelSize: 14
                        color: "#cc0000"
                        textColor: "#ffffff"
                        radius: 8
                        onClicked: sddm.login(name.text, password.text, 0)
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

                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "images/icon-shutdown.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: shutMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: sddm.powerOff()
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

                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "images/icon-reboot.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: rebMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: sddm.reboot()
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

                        Image {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            sourceSize.width: 48
                            sourceSize.height: 48
                            source: "images/icon-sleep.svg"
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea {
                            id: sleepMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: sddm.suspend()
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
