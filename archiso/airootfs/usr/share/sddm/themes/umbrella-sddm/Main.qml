import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents

/*
 * Umbrella Corporation — Red Queen SDDM Login Interface
 * Structure ready for login image & UI styling.
 */
Rectangle {
    id: container
    width: 1920
    height: 1080
    color: "#0a0a0a"

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    Image {
        id: bg
        anchors.fill: parent
        source: config.background || "images/background.jpg"
        fillMode: Image.PreserveAspectCrop
        clip: true

        Rectangle {
            anchors.fill: parent
            color: "#000000"
            opacity: 0.45
        }
    }

    Rectangle {
        id: loginCard
        anchors.centerIn: parent
        width: 380
        height: 460
        color: "#121212"
        opacity: 0.92
        radius: 8
        border.color: "#cc0000"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 30
            spacing: 16

            Image {
                Layout.alignment: Qt.AlignHCenter
                source: config.logo || "images/umbrella-logo.png"
                sourceSize.width: 72
                sourceSize.height: 72
                fillMode: Image.PreserveAspectFit
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "UMBRELLA CORPORATION"
                font.family: "JetBrains Mono"
                font.pixelSize: 14
                font.bold: true
                color: "#cc0000"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "RED QUEEN AI SECURITY SYSTEM"
                font.family: "JetBrains Mono"
                font.pixelSize: 10
                color: "#888888"
            }

            Item { Layout.fillHeight: true }

            TextBox {
                id: name
                Layout.fillWidth: true
                height: 40
                text: userModel.lastUser
                font.pixelSize: 13
                radius: 4
                color: "#1a1a1a"
                textColor: "#f0f0f0"
                borderColor: "#333333"
                focusColor: "#cc0000"

                KeyNavigation.backtab: rebootButton
                KeyNavigation.tab: password
            }

            PasswordBox {
                id: password
                Layout.fillWidth: true
                height: 40
                font.pixelSize: 13
                radius: 4
                color: "#1a1a1a"
                textColor: "#f0f0f0"
                borderColor: "#333333"
                focusColor: "#cc0000"

                KeyNavigation.backtab: name
                KeyNavigation.tab: loginButton

                Keys.onReturnPressed: sddm.login(name.text, password.text, session.index)
            }

            Button {
                id: loginButton
                Layout.fillWidth: true
                height: 42
                text: "AUTHENTICATE"
                font.family: "JetBrains Mono"
                font.bold: true
                font.pixelSize: 12
                color: "#cc0000"
                textColor: "#ffffff"
                radius: 4

                onClicked: sddm.login(name.text, password.text, session.index)
            }

            Item { Layout.fillHeight: true }
        }
    }
}
