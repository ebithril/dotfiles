import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Scope {
    id: root
    property bool shown: false

    PanelWindow {
        id: controlCenterWindow
        anchors {
            right: true
            top: true
        }

        // Start offscreen and animate in
        margins {
            right: root.shown ? 2 : -controlCenterWindow.implicitWidth - 10
            top: 5
        }

        Behavior on margins.right {
            NumberAnimation {
                duration: Theme.animDuration
                easing.type: Theme.animEasing
            }
        }

        implicitWidth: 300
        implicitHeight: screen.height - 10
        color: "transparent"
        exclusiveZone: 0

        mask: Region {
            item: bg
        }

        Rectangle {
            id: bg
            anchors.fill: parent
            color: Theme.backgroundColor
            radius: 10

            // Rubber stretch effect for Luffy
            transform: Scale {
                id: stretchScale
                origin.x: controlCenterWindow.width / 2
                origin.y: controlCenterWindow.height / 2
                xScale: Theme.themes[Theme.currentTheme].character === "luffy" ? (root.shown ? 1.0 : 0.8) : 1.0
                yScale: Theme.themes[Theme.currentTheme].character === "luffy" ? (root.shown ? 1.0 : 1.2) : 1.0

                Behavior on xScale {
                    NumberAnimation {
                        duration: Theme.animDuration
                        easing.type: Theme.animEasing
                    }
                }
                Behavior on yScale {
                    NumberAnimation {
                        duration: Theme.animDuration
                        easing.type: Theme.animEasing
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 15

                // Header - Time
                Text {
                    Layout.fillWidth: true
                    text: Time.time
                    color: Theme.foregroundColor
                    font.pixelSize: 14
                    font.family: Theme.textFont
                }

                // Notification Center
                NotificationCenter {
                    Layout.fillWidth: true
                }

                // Control Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: controlColumn.implicitHeight + 4
                    color: Qt.lighter(Theme.backgroundColor, 1.2)
                    radius: 10
                    border.width: 1
                    border.color: Qt.lighter(Theme.backgroundColor, 1.3)

                    ColumnLayout {
                        id: controlColumn
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 2

                        // Toggle Controls
                        ToggleControls {
                            Layout.fillWidth: true
                        }

                        // Volume and Brightness Sliders
                        AdjustableControls {
                            Layout.fillWidth: true
                        }

                        // System Info
                        SystemInfo {
                            Layout.fillWidth: true
                        }
                    }
                }

                // Spacer
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }
}
