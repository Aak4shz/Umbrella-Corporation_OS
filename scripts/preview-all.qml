import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

/*
 * Umbrella OS - Master End-to-End Boot Lifecycle Simulator
 * Simulates complete boot sequence:
 *   Stage 0: Plymouth Early Kernel Boot (Rotating Spinner & Progress)
 *   Stage 1: SDDM Login Greeter (Raccoon City Edition)
 *   Stage 2: KDE Post-Login Splash Screen (Fullscreen Cinematic Umbrella GIF)
 *   Stage 3: Red Queen Lock Screen UI & Workspace
 */
Window {
    id: root
    width: 1366
    height: 768
    visible: true
    title: "Umbrella OS - Complete Boot & Login Lifecycle Simulator"
    color: "#050505"

    // 0: Plymouth Boot -> 1: SDDM Login -> 2: Post-Login Splash (GIF) -> 3: Lock Screen
    property int currentStage: 0
    property int plymouthFrameIndex: 0
    property real plymouthProgress: 0.0
    property bool isFullscreen: false

    onCurrentStageChanged: {
        if (currentStage === 0) {
            plymouthProgress = 0.0
        } else if (currentStage === 1) {
            if (typeof authBtn !== "undefined") {
                authBtn.color = "#cc0000"
                authText.text = "AUTHENTICATE"
            }
            if (typeof autoLoginTimer !== "undefined") {
                autoLoginTimer.restart()
            }
        } else if (currentStage === 2) {
            if (typeof splashGif !== "undefined") {
                splashGif.currentFrame = 0
            }
            if (typeof autoSplashToLockTimer !== "undefined") {
                autoSplashToLockTimer.restart()
            }
        }
    }

    // -- LOAD SYSTEM FONTS -----------------------------------------------------
    FontLoader { id: glitchFont; source: "../archiso/airootfs/usr/share/fonts/TTF/CfGlitchCityRegular_L1vZ.ttf" }
    FontLoader { id: transformersFont; source: "../archiso/airootfs/usr/share/fonts/TTF/Transformers_Movie.ttf" }
    FontLoader { id: uniNeueBold; source: "../archiso/airootfs/usr/share/fonts/TTF/UniNeue-Trial-Bold.ttf" }
    FontLoader { id: uniNeueRegular; source: "../archiso/airootfs/usr/share/fonts/TTF/UniNeue-Trial-Regular.ttf" }
    FontLoader { id: hackedFont; source: "../archiso/airootfs/usr/share/fonts/TTF/Hacked-KerX.ttf" }
    FontLoader { id: bladeRunnerFont; source: "../archiso/airootfs/usr/share/fonts/TTF/BLADRMF_.ttf" }

    // =========================================================================
    // TOP FLOATING SWITCHER TOOLBAR
    // =========================================================================
    Rectangle {
        id: topToolbar
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 12
        width: Math.min(parent.width - 24, 1020)
        height: 48
        radius: 8
        color: "#121212"
        opacity: toolbarMouse.containsMouse ? 0.96 : (root.currentStage === 2 ? 0.25 : 0.88)
        border.color: "#330000"
        border.width: 1.5
        z: 9999

        Behavior on opacity { NumberAnimation { duration: 300 } }

        MouseArea {
            id: toolbarMouse
            anchors.fill: parent
            hoverEnabled: true
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            Text {
                text: "LIFECYCLE:"
                color: "#ff2222"
                font.bold: true
                font.pixelSize: 11
                font.family: "monospace"
            }

            // Stage Switchers
            Repeater {
                model: [
                    { name: "1. Plymouth Boot", stage: 0 },
                    { name: "2. SDDM Login", stage: 1 },
                    { name: "3. Post-Login Splash", stage: 2 },
                    { name: "4. Lock Screen", stage: 3 }
                ]

                Rectangle {
                    width: 150
                    height: 32
                    radius: 6
                    color: root.currentStage === modelData.stage ? "#cc0000" : (stageBtnMouse.containsMouse ? "#2a0000" : "#1a1a1a")
                    border.color: root.currentStage === modelData.stage ? "#ff4444" : "#333333"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: modelData.name
                        color: root.currentStage === modelData.stage ? "#ffffff" : "#aaaaaa"
                        font.bold: root.currentStage === modelData.stage
                        font.pixelSize: 11
                        font.family: "monospace"
                    }

                    MouseArea {
                        id: stageBtnMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (modelData.stage === 0) {
                                root.plymouthProgress = 0.0
                            }
                            root.currentStage = modelData.stage
                        }
                    }
                }
            }

            Rectangle { width: 1; height: 24; color: "#330000" }

            // Auto-Play Sequence Button
            Rectangle {
                width: 130
                height: 32
                radius: 6
                color: autoSeqMouse.containsMouse ? "#005522" : "#003311"
                border.color: "#00cc55"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "▶ REPLAY ALL"
                    color: "#00ff77"
                    font.bold: true
                    font.pixelSize: 11
                    font.family: "monospace"
                }

                MouseArea {
                    id: autoSeqMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.plymouthProgress = 0.0
                        root.currentStage = 0
                    }
                }
            }

            // Fullscreen Button
            Rectangle {
                width: 32
                height: 32
                radius: 6
                color: fsMouse.containsMouse ? "#333333" : "#222222"
                border.color: "#444444"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: root.isFullscreen ? "🗗" : "⛶"
                    color: "#ffffff"
                    font.pixelSize: 14
                }

                MouseArea {
                    id: fsMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.toggleFullscreen()
                }
            }
        }
    }

    function toggleFullscreen() {
        if (root.visibility === Window.FullScreen) {
            root.visibility = Window.Windowed
            root.isFullscreen = false
        } else {
            root.visibility = Window.FullScreen
            root.isFullscreen = true
        }
    }

    // Keyboard Shortcuts
    Shortcut { sequence: "F11"; onActivated: root.toggleFullscreen() }
    Shortcut { sequence: "Escape"; onActivated: Qt.quit() }
    Shortcut { sequence: "1"; onActivated: { root.plymouthProgress = 0.0; root.currentStage = 0 } }
    Shortcut { sequence: "2"; onActivated: root.currentStage = 1 }
    Shortcut { sequence: "3"; onActivated: root.currentStage = 2 }
    Shortcut { sequence: "4"; onActivated: root.currentStage = 3 }

    // =========================================================================
    // STAGE 0: PLYMOUTH EARLY BOOT SPLASH
    // =========================================================================
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
            interval: 38
            running: root.currentStage === 0
            repeat: true
            onTriggered: {
                if (root.plymouthProgress < 1.0) {
                    root.plymouthProgress = Math.min(1.0, root.plymouthProgress + 0.015)
                } else {
                    transitionToSddmTimer.start()
                }
            }
        }

        Timer {
            id: transitionToSddmTimer
            interval: 500
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

            Item { Layout.preferredHeight: 10 }

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
                width: 480; height: 32
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

    // =========================================================================
    // STAGE 1: SDDM LOGIN GREETER (RACCOON CITY EDITION)
    // =========================================================================
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
                width: parent.width * 0.52
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
            anchors.verticalCenterOffset: 10
            width: 440; height: 600

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                // HUD Clock & Date
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 2

                    Text {
                        id: sddmTime
                        Layout.alignment: Qt.AlignHCenter
                        font.family: glitchFont.name || "CF Glitch City"
                        font.pixelSize: 46; font.bold: true; color: "#ffffff"
                        style: Text.Outline; styleColor: "#660000"

                        Timer {
                            interval: 1000; running: root.currentStage === 1; repeat: true; triggeredOnStart: true
                            onTriggered: {
                                var d = new Date()
                                sddmTime.text = Qt.formatDateTime(d, "hh:mm:ss AP").toUpperCase()
                                sddmDate.text = Qt.formatDateTime(d, "dddd - d MMMM yyyy").toUpperCase()
                            }
                        }
                    }

                    Text {
                        id: sddmDate
                        Layout.alignment: Qt.AlignHCenter
                        font.family: glitchFont.name || "CF Glitch City"
                        font.pixelSize: 18; font.bold: true; color: "#ff2222"
                    }
                }

                Item { Layout.preferredHeight: 4 }

                // Login Form
                Item {
                    Layout.fillWidth: true; Layout.preferredHeight: 360

                    ColumnLayout {
                        anchors.fill: parent; spacing: 10

                        Image {
                            Layout.alignment: Qt.AlignHCenter
                            source: "../assets/branding/umbrella-corporation-logo.png"
                            sourceSize.width: 84; sourceSize.height: 84
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

                        Item { Layout.preferredHeight: 2 }

                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4
                            Text { text: "User"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 13; font.bold: true; color: "#ff2222" }
                            Rectangle {
                                Layout.fillWidth: true; height: 38; color: "#181818"; radius: 6; border.color: "#383838"
                                TextInput { anchors.fill: parent; anchors.margins: 8; text: "umbrella"; font.family: "JetBrains Mono"; font.pixelSize: 13; font.bold: true; color: "#ffffff"; verticalAlignment: TextInput.AlignVCenter }
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true; spacing: 4
                            Text { text: "Password"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 13; font.bold: true; color: "#ff2222" }
                            Rectangle {
                                Layout.fillWidth: true; height: 38; color: "#181818"; radius: 6; border.color: "#383838"
                                TextInput {
                                    id: pwdField
                                    anchors.fill: parent; anchors.margins: 8
                                    text: "umbrella"
                                    echoMode: TextInput.Password
                                    font.family: "JetBrains Mono"; font.pixelSize: 13; font.bold: true; color: "#ffffff"
                                    verticalAlignment: TextInput.AlignVCenter
                                    Keys.onReturnPressed: { autoLoginTimer.stop(); authBtn.triggerLogin() }
                                    onTextEdited: autoLoginTimer.stop()
                                }
                            }
                        }

                        Item { Layout.preferredHeight: 4 }

                        Rectangle {
                            id: authBtn
                            Layout.fillWidth: true; height: 42; color: authMouse.containsMouse ? "#e60000" : "#cc0000"; radius: 6

                            function triggerLogin() {
                                authBtn.color = "#00aa44"
                                authText.text = "ACCESS GRANTED // INITIALIZING SPLASH..."
                                transitionToSplashTimer.start()
                            }

                            Text { id: authText; anchors.centerIn: parent; text: "AUTHENTICATE"; font.family: hackedFont.name || "HACKED"; font.bold: true; font.pixelSize: 13; color: "#ffffff" }
                            MouseArea {
                                id: authMouse
                                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    autoLoginTimer.stop()
                                    authBtn.triggerLogin()
                                }
                            }
                        }

                        Timer {
                            id: autoLoginTimer
                            interval: 3200
                            running: root.currentStage === 1
                            repeat: false
                            onTriggered: authBtn.triggerLogin()
                        }

                        Timer {
                            id: transitionToSplashTimer
                            interval: 400
                            repeat: false
                            onTriggered: {
                                authBtn.color = "#cc0000"
                                authText.text = "AUTHENTICATE"
                                root.currentStage = 2
                            }
                        }
                    }
                }
            }
        }
    }

    // =========================================================================
    // STAGE 2: KDE POST-LOGIN SPLASH SCREEN (FULLSCREEN UMBRELLA GIF)
    // =========================================================================
    Item {
        id: splashView
        anchors.fill: parent
        visible: root.currentStage === 2
        opacity: root.currentStage === 2 ? 1.0 : 0.0

        Behavior on opacity { NumberAnimation { duration: 400 } }

        // Background
        Rectangle {
            anchors.fill: parent
            color: "#000000"
        }

        // Fullscreen Cinematic Animated GIF
        AnimatedImage {
            id: splashGif
            anchors.fill: parent
            source: "../archiso/airootfs/usr/share/plasma/look-and-feel/org.umbrella.redqueen.desktop/contents/splash/images/umbrella-splash.gif"
            fillMode: Image.PreserveAspectCrop
            smooth: true
            mipmap: true
            playing: root.currentStage === 2

            // Cinematic fade-in
            opacity: 0.0
            NumberAnimation on opacity {
                running: root.currentStage === 2
                from: 0.0; to: 1.0; duration: 400; easing.type: Easing.InOutQuad
            }
        }

        // Auto transition to Desktop / Lock Screen after full cycle (3.5 seconds)
        Timer {
            id: autoSplashToLockTimer
            interval: 3800
            running: root.currentStage === 2
            repeat: false
            onTriggered: root.currentStage = 3
        }

        // Click anywhere to advance immediately
        MouseArea {
            anchors.fill: parent
            onClicked: root.currentStage = 3
        }
    }

    // =========================================================================
    // STAGE 3: RED QUEEN LOCK SCREEN & WORKSPACE
    // =========================================================================
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
            Rectangle { anchors.fill: parent; color: "#000000"; opacity: 0.68 }
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 14; width: 440

            // HUD Clock & Date
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
                            var d = new Date()
                            lockTime.text = Qt.formatDateTime(d, "hh:mm:ss AP").toUpperCase()
                            lockDate.text = Qt.formatDateTime(d, "dddd - d MMMM yyyy").toUpperCase()
                        }
                    }
                }
                Text {
                    id: lockDate
                    Layout.alignment: Qt.AlignHCenter
                    font.family: glitchFont.name || "CF Glitch City"
                    font.pixelSize: 18; font.bold: true; color: "#ff2222"
                }
            }

            Item { Layout.preferredHeight: 8 }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter; Layout.fillWidth: true; spacing: 14

                // Animated Umbrella Corporation Emblem / User Badge
                Item {
                    Layout.alignment: Qt.AlignHCenter
                    width: 90
                    height: 90

                    Image {
                        anchors.centerIn: parent
                        width: 86
                        height: 86
                        source: "../assets/branding/umbrella-corporation-logo.png"
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

                ColumnLayout {
                    Layout.fillWidth: true; spacing: 4
                    Text { text: "Password"; font.family: hackedFont.name || "HACKED"; font.pixelSize: 13; font.bold: true; color: "#ff2222" }
                    Rectangle {
                        Layout.fillWidth: true; height: 42; color: "#181818"; radius: 8; border.color: lockPwdField.activeFocus ? "#ff2222" : "#383838"; border.width: lockPwdField.activeFocus ? 2 : 1
                        TextInput { id: lockPwdField; anchors.fill: parent; anchors.margins: 10; text: ""; echoMode: TextInput.Password; font.family: "JetBrains Mono"; font.pixelSize: 14; font.bold: true; color: "#ffffff"; verticalAlignment: TextInput.AlignVCenter; Keys.onReturnPressed: unlockBtn.triggerUnlock() }
                    }
                }

                Rectangle {
                    id: unlockBtn
                    Layout.fillWidth: true; height: 44; color: unlockMouse.containsMouse ? "#e60000" : "#cc0000"; radius: 8
                    function triggerUnlock() {
                        unlockText.text = "UNLOCKED [OK]"
                        unlockBtn.color = "#00aa44"
                    }
                    Text { id: unlockText; anchors.centerIn: parent; text: "UNLOCK WORKSPACE"; font.family: hackedFont.name || "HACKED"; font.bold: true; font.pixelSize: 14; color: "#ffffff" }
                    MouseArea { id: unlockMouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: unlockBtn.triggerUnlock() }
                }
            }
        }
    }
}
