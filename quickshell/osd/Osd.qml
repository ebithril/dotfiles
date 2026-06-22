import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
    id: root

    // Bind the pipewire node so its volume will be tracked
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
        enabled: target !== null && target !== undefined

        function onVolumeChanged() {
            root.shouldShowVolOsd = true;
            hideTimer.restart();
        }
    }

    property bool shouldShowVolOsd: false

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowVolOsd = false
    }

    PanelWindow {
        id: osdWindow
        visible: root.shouldShowVolOsd

        anchors.bottom: true
        margins.bottom: screen.height / 12
        exclusiveZone: 0

        implicitWidth: 400
        implicitHeight: 50
        color: "transparent"

        // An empty click mask prevents the window from blocking mouse events.
        mask: Region {}

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: Qt.rgba(Theme.backgroundColor.r, Theme.backgroundColor.g, Theme.backgroundColor.b, 0.9)

            opacity: root.shouldShowVolOsd ? 1.0 : 0.0
            scale: root.shouldShowVolOsd ? 1.0 : (Theme.themes[Theme.currentTheme].character === "luffy" ? 0.5 : 0.9)

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.animDuration
                    easing.type: Theme.animEasing
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: Theme.animDuration
                    easing.type: Theme.animEasing
                }
            }

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 10
                    rightMargin: 15
                }

                Text {
                    text: Theme.icons.volumeHigh
                    font.pixelSize: 24
                    font.family: Theme.iconFont
                    color: Theme.foregroundColor
                }

                Rectangle {
                    // Stretches to fill all left-over space
                    Layout.fillWidth: true

                    implicitHeight: 10
                    radius: 20
                    color: Qt.rgba(Theme.foregroundColor.r, Theme.foregroundColor.g, Theme.foregroundColor.b, 0.3)

                    Rectangle {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }

                        implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                        radius: parent.radius
                        color: Theme.accent1Color
                    }
                }
            }
        }
    }
}
