import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: presentation
    width: 680
    height: 480

    property int currentSlide: 0
    property int totalSlides: 4

    Timer {
        id: slideTimer
        interval: 6500
        running: true
        repeat: true
        onTriggered: {
            presentation.currentSlide = (presentation.currentSlide + 1) % presentation.totalSlides
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#0d0202"

        // Red subtle glowing gradient at top
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 3
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "#00000000" }
                GradientStop { position: 0.5; color: "#cc0000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
        }

        // Slide Container
        Item {
            anchors.fill: parent
            anchors.margins: 40

            // Slide 1: Welcome & Red Queen
            Item {
                id: slide1
                anchors.fill: parent
                opacity: presentation.currentSlide === 0 ? 1.0 : 0.0
                Behavior on opacity { NumberAnimation { duration: 500 } }
                visible: opacity > 0

                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    width: parent.width

                    Image {
                        source: "umbrella-logo.png"
                        width: 96
                        height: 96
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }

                    Text {
                        text: "UMBRELLA CORPORATION OS"
                        font.pixelSize: 22
                        font.bold: true
                        font.letterSpacing: 2
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "RED QUEEN AI & SECURITY ARCHITECTURE"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#cc0000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Welcome to Umbrella OS — a high-performance Arch-based workstation engineered for autonomous systems development, security research, and advanced machine learning."
                        font.pixelSize: 13
                        color: "#a0a0a0"
                        width: parent.width * 0.85
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Slide 2: Developer & Local AI Stack
            Item {
                id: slide2
                anchors.fill: parent
                opacity: presentation.currentSlide === 1 ? 1.0 : 0.0
                Behavior on opacity { NumberAnimation { duration: 500 } }
                visible: opacity > 0

                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    width: parent.width

                    Text {
                        text: "LOCAL AI & MACHINE LEARNING READY"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "OLLAMA • PYTORCH • NUMPY • FASTAPI • PYTHON 3"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#cc0000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Umbrella OS comes preloaded with Ollama for zero-leak local LLM inference, PyTorch ML libraries, Docker Compose containerization, and modern development runtimes out of the box."
                        font.pixelSize: 13
                        color: "#a0a0a0"
                        width: parent.width * 0.85
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Slide 3: KDE Plasma 6 Cyberpunk Interface
            Item {
                id: slide3
                anchors.fill: parent
                opacity: presentation.currentSlide === 2 ? 1.0 : 0.0
                Behavior on opacity { NumberAnimation { duration: 500 } }
                visible: opacity > 0

                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    width: parent.width

                    Text {
                        text: "KDE PLASMA 6 DESKTOP ENVIRONMENT"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "RED QUEEN 60-30-10 CHROMATIC ACCENTS & SILENT BOOT"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#cc0000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Enjoy a seamlessly synchronized dark desktop experience with KWin Gaussian blur, Wayland acceleration, custom Plymouth boot animations, and the Red Queen HUD terminal."
                        font.pixelSize: 13
                        color: "#a0a0a0"
                        width: parent.width * 0.85
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Slide 4: Fast & Rock-Solid SSD Performance
            Item {
                id: slide4
                anchors.fill: parent
                opacity: presentation.currentSlide === 3 ? 1.0 : 0.0
                Behavior on opacity { NumberAnimation { duration: 500 } }
                visible: opacity > 0

                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    width: parent.width

                    Text {
                        text: "INSTALLING TO STORAGE DRIVE"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#ffffff"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "OPTIMIZED NVME / SSD STORAGE • GRUB UEFI • BTRFS / EXT4"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#cc0000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        text: "Calamares is deploying the complete system directly to your disk with continuous TRIM support, modern PipeWire audio, and secure user sandboxing. Please keep your machine connected."
                        font.pixelSize: 13
                        color: "#a0a0a0"
                        width: parent.width * 0.85
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        // Slide Indicators (Dots at bottom)
        Row {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            Repeater {
                model: presentation.totalSlides
                Rectangle {
                    width: index === presentation.currentSlide ? 24 : 8
                    height: 8
                    radius: 4
                    color: index === presentation.currentSlide ? "#cc0000" : "#333333"
                    Behavior on width { NumberAnimation { duration: 250 } }
                    Behavior on color { ColorAnimation { duration: 250 } }
                }
            }
        }
    }
}
