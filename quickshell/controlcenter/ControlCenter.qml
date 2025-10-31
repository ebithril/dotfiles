import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Theme
import Quickshell.Services.Pipewire
import Quickshell.Io

LazyLoader {
    id: root
    property bool shown: false
    active: shown

    PanelWindow {
        anchors {
            right: true
            top: true
        }

        margins {
            right: 2
            top: 5
        }

        width: 300
        height: screen.height - 10
        color: "transparent"
        exclusiveZone: 0

        mask: Region { item: bg }

        Rectangle {
            id: bg
            anchors.fill: parent
            color: Theme.backgroundColor
            radius: 10

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                // Header - Time
                Text {
                    Layout.fillWidth: true
                    text: Time.time
                    color: Theme.foregroundColor
                    font.pixelSize: 14
                    font.family: "FiraCode"
                }

                // Theme Selector
                ThemeSelector {
                    Layout.fillWidth: true
                }

                // Control Card
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: childrenRect.height + 20
                    color: Qt.darker(Theme.backgroundColor, 1.2)
                    radius: 10

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

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

        // Click outside to close
        MouseArea {
            anchors.fill: parent
            z: -1
            onPressed: root.shown = false
        }
    }
}
