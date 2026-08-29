import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents

/*
 * Umbrella Corporation — Red Queen Lock Screen Component (KDE Plasma 6)
 */
Item {
    id: lockScreenRoot
    anchors.fill: parent

    FontLoader {
        id: glitchFont
        source: "/usr/share/fonts/TTF/CfGlitchCityRegular_L1vZ.ttf"
    }

    FontLoader {
        id: transformersFont
        source: "/usr/share/fonts/TTF/Transformers_Movie.ttf"
    }

    FontLoader {
        id: uniNeueBold
        source: "/usr/share/fonts/TTF/UniNeue-Trial-Bold.ttf"
    }

    FontLoader {
        id: hackedFont
        source: "/usr/share/fonts/TTF/Hacked-KerX.ttf"
    }

    // Background Image with dark security dimming
    Image {
        id: bgImage
        anchors.fill: parent
        source: "/usr/share/wallpapers/UmbrellaOS/Welcome_Wallpaper.png"
        fillMode: Image.PreserveAspectCrop
        clip: true

        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.65
        }

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

            Item {
                Layout.alignment: Qt.AlignHCenter
                width: 90
                height: 90

                Image {
                    anchors.centerIn: parent
                    width: 86
                    height: 86
                    source: "/usr/share/sddm/themes/umbrella-sddm/images/biohazard-logo.png"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

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
                    }
                }
            }

            Rectangle {
                id: unlockButton
                Layout.fillWidth: true
                height: 44
                color: unlockArea.containsMouse ? "#e60000" : "#cc0000"
                radius: 8

                Text {
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
                }
            }
        }
    }
}
