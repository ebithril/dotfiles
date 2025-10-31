import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Theme
import Quickshell.Hyprland

RowLayout {
    spacing: 15

    // Using simpler Unicode symbols that work without Nerd Fonts
    // Install a Nerd Font for better icons
    property var workspaceIcons: [
        {"id": 1, "icon": "●"},  // Circle for workspace 1
        {"id": 2, "icon": "●"},
        {"id": 3, "icon": "●"},
        {"id": 4, "icon": "●"},
        {"id": 5, "icon": "●"},
        {"id": 6, "icon": "●"},
        {"id": 7, "icon": "●"},
        {"id": 8, "icon": "●"},
        {"id": 9, "icon": "●"}
    ]

    Repeater {
        model: workspaceIcons

        Rectangle {
            required property var modelData
            property int wsId: modelData.id
            property string wsIcon: modelData.icon
            property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId

            Layout.preferredWidth: 20
            Layout.preferredHeight: 20

            color: "transparent"

            Text {
                id: wsText
                anchors.centerIn: parent
                text: parent.wsIcon
                color: parent.isActive ? Theme.highlightColor : Theme.foregroundColor
                font.pixelSize: 10
                font.bold: parent.isActive

                // Scale up active workspace circle
                scale: parent.isActive ? 1.3 : 1.0

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                Behavior on scale {
                    NumberAnimation { duration: 150 }
                }
            }

            // Underline for active workspace
            Rectangle {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width - 4
                height: 2
                color: Theme.highlightColor
                visible: parent.isActive
                radius: 1

                Behavior on visible {
                    NumberAnimation { duration: 150 }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch(`workspace ${parent.wsId}`)
            }
        }
    }
}
