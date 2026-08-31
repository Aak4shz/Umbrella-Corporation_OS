import QtQuick
import QtQuick.Window

/*
 * Umbrella Corporation — Red Queen Post-Login Native QML Splash Screen
 * Lightweight, hardware-accelerated, zero video codec dependency.
 */
Item {
    id: root
    width: Screen.width
    height: Screen.height

    property int stage: 0

    // Canvas Background
    Rectangle {
        anchors.fill: parent
        color: "#0a0a0a"

        // Ambient Crimson Hologram Vignette
        Rectangle {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 1.1
            height: width
            radius: width / 2
            color: "#180000"
            opacity: 0.45
        }
    }

    // Center HUD Container
    Item {
        id: container
        anchors.centerIn: parent
        width: 520
        height: 380

        // Pulsing Biohazard / Umbrella Emblem
        Item {
            id: logoWrapper
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -44
            width: 140
            height: 140

            // Ambient Glow Ring
            Rectangle {
                anchors.centerIn: parent
                width: 130
                height: 130
                radius: 65
                color: "transparent"
                border.color: "#cc0000"
                border.width: 1
                opacity: 0.35

                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.95; to: 1.12; duration: 1600; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 1.12; to: 0.95; duration: 1600; easing.type: Easing.InOutSine }
                }
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.2; to: 0.55; duration: 1600; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 0.55; to: 0.2; duration: 1600; easing.type: Easing.InOutSine }
                }
            }

            Image {
                id: emblem
                anchors.centerIn: parent
                width: 110
                height: 110
                source: "images/biohazard-logo.png"
                fillMode: Image.PreserveAspectFit
                smooth: true

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.82; to: 1.0; duration: 1200; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1.0; to: 0.82; duration: 1200; easing.type: Easing.InOutQuad }
                }

                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.98; to: 1.02; duration: 1200; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1.02; to: 0.98; duration: 1200; easing.type: Easing.InOutQuad }
                }
            }
        }

        // Master Title
        Text {
            id: titleText
            anchors.top: logoWrapper.bottom
            anchors.topMargin: 22
            anchors.horizontalCenter: parent.horizontalCenter
            text: "UMBRELLA CORPORATION"
            font.family: "Transformers Movie"
            font.pixelSize: 22
            font.bold: true
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#660000"
        }

        // Subtitle Status Text
        Text {
            id: statusText
            anchors.top: titleText.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                if (root.stage <= 0) return "CONNECTING TO RED QUEEN MAINFRAME...";
                if (root.stage === 1) return "INITIALIZING SYSTEM CORE SERVICES...";
                if (root.stage === 2) return "CONFIGURING GRAPHICAL SUBSYSTEMS...";
                if (root.stage === 3) return "LOADING SECURE USER ENVIRONMENT...";
                if (root.stage === 4) return "INITIALIZING LOCAL AI NEURAL ENGINE...";
                return "SECURITY CLEARANCE GRANTED. ACCESSING WORKSPACE.";
            }
            font.family: "JetBrains Mono"
            font.pixelSize: 12
            font.bold: true
            color: root.stage >= 5 ? "#00ff88" : "#ff2222"
        }

        // Progress Bar
        Rectangle {
            id: progressTrack
            anchors.top: statusText.bottom
            anchors.topMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            width: 320
            height: 4
            color: "#220000"
            radius: 2

            Rectangle {
                id: progressBar
                height: parent.height
                width: parent.width * Math.min(1.0, Math.max(0.1, (root.stage + 1) / 6.0))
                color: root.stage >= 5 ? "#00ff88" : "#cc0000"
                radius: 2

                Behavior on width {
                    NumberAnimation { duration: 400; easing.type: Easing.OutCubic }
                }
            }
        }

        // Security Clearance Level Badge
        Text {
            anchors.top: progressTrack.bottom
            anchors.topMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            text: "SECURITY CLEARANCE LEVEL 5 // RED QUEEN AI ACTIVE"
            font.family: "JetBrains Mono"
            font.pixelSize: 10
            font.bold: true
            color: "#555555"
        }
    }
}
