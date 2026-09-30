import QtQuick
import QtQuick.Window

/*
 * Umbrella Corporation - Red Queen Post-Login Fullscreen Cinematic Splash Screen
 * Ultra-clean, edge-to-edge fullscreen animation, zero video codec dependency.
 */
Item {
    id: root
    width: Screen.width
    height: Screen.height

    property int stage: 0

    // Deep Canvas Background
    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    // Fullscreen Edge-to-Edge Animated Emblem
    AnimatedImage {
        id: splashAnimation
        anchors.fill: parent
        source: "images/umbrella-splash.gif"
        fillMode: Image.PreserveAspectCrop
        smooth: true
        mipmap: true
        playing: true

        // Smooth cinematic fade-in on load
        opacity: 0.0
        Component.onCompleted: {
            fadeInAnim.start()
        }

        NumberAnimation on opacity {
            id: fadeInAnim
            from: 0.0
            to: 1.0
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }
}
