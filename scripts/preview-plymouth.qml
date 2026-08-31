import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

Window {
    id: root
    width: 1280
    height: 720
    visible: true
    title: "Umbrella OS — Red Queen Plymouth Boot Splash (Biohazard Edition)"
    color: "#0a0a0a"

    property int frameIndex: 0
    property real bootProgress: 0.0

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
        id: hackedFont
        source: "../archiso/airootfs/usr/share/fonts/TTF/Hacked-KerX.ttf"
    }

    // 36-Frame Smooth Rotation Timer (40 FPS loop)
    Timer {
        interval: 32
        running: true
        repeat: true
        onTriggered: {
            root.frameIndex = (root.frameIndex + 1) % 36
        }
    }

    // Simulated Boot Sequence Timer
    Timer {
        interval: 80
        running: true
        repeat: true
        onTriggered: {
            if (root.bootProgress < 1.0) {
                root.bootProgress = Math.min(1.0, root.bootProgress + 0.012);
            } else {
                root.bootProgress = 0.0;
            }
        }
    }

    // Deep Obsidian Canvas with subtle red ambient vignette
    Rectangle {
        anchors.fill: parent
        color: "#0a0a0a"

        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.85
            height: parent.height * 0.85
            radius: width / 2
            color: "#1a0000"
            opacity: 0.22
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 16

        // Rock-Solid Center-Aligned Rotating Biohazard Symbol
        Item {
            Layout.alignment: Qt.AlignHCenter
            width: 240
            height: 240

            Image {
                id: spinnerImage
                anchors.centerIn: parent
                width: 240
                height: 240
                source: "../archiso/airootfs/usr/share/plymouth/themes/umbrella-plymouth/spinner-" + root.frameIndex + ".png"
                fillMode: Image.PreserveAspectFit
                smooth: true
                asynchronous: false
            }
        }

        Item { Layout.preferredHeight: 8 }

        // White Title with CF Glitch City Custom Font
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

        // Loading Percentage Display (CF Glitch City Font)
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Math.floor(root.bootProgress * 100) + " %"
            font.family: glitchFont.name || "CF Glitch City"
            font.pixelSize: 32
            font.bold: true
            color: "#ff0000"
            style: Text.Outline
            styleColor: "#440000"
        }

        // Cyberpunk Solid Rectangular Loading Bar (480x36px)
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 480
            height: 36
            color: "#0d0d0d"
            border.color: "#cc0000"
            border.width: 2
            radius: 4

            // Fill Bar
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 4
                width: Math.max(4, (parent.width - 8) * root.bootProgress)
                color: "#ff0000"
                radius: 2

                Behavior on width {
                    NumberAnimation { duration: 100; easing.type: Easing.Linear }
                }
            }

            // Glow Border Effect
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: "#ff3333"
                border.width: 1
                opacity: 0.4
                radius: 4
            }
        }
    }
}
