import QtQuick
import QtQuick.Window

/*
 * Umbrella OS - Post-Login Splash Preview Runner (Pure Fullscreen)
 * Runs the exact production Splash.qml in pure fullscreen with zero overlay elements.
 */
Window {
    id: win
    visibility: Window.FullScreen
    visible: true
    title: "Umbrella OS - Post-Login Splash Fullscreen Preview"
    color: "#000000"

    // Load the production Splash.qml directly
    Loader {
        anchors.fill: parent
        source: "../archiso/airootfs/usr/share/plasma/look-and-feel/org.umbrella.redqueen.desktop/contents/splash/Splash.qml"
    }

    // Exit handlers: Click anywhere or press Escape / Space to exit cleanly
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.BlankCursor
        onClicked: Qt.quit()
    }

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }

    Shortcut {
        sequence: "Space"
        onActivated: Qt.quit()
    }
}
