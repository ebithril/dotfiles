import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 15

    property var workspaceIcons: [
        {"id": 1, "icon": ""},
        {"id": 2, "icon": ""},
        {"id": 3, "icon": ""},
        {"id": 4, "icon": ""},
        {"id": 5, "icon": ""},
        {"id": 6, "icon": ""},
        {"id": 7, "icon": ""},
        {"id": 8, "icon": ""},
        {"id": 9, "icon": ""}
    ]

    Repeater {
        model: workspaceIcons

        Rectangle {
            required property var modelData
            property int wsId: modelData.id
            property string wsIcon: modelData.icon
            property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId

            Layout.preferredWidth: 30
            Layout.preferredHeight: 20

            color: "transparent"

            Text {
                anchors.centerIn: parent
                text: wsIcon
                color: parent.isActive ? "#2f76dc" : "#B9EFF8"  // blue highlight or cyan
                font.pixelSize: 14
                font.family: "FiraCode"
                font.bold: parent.isActive

                Behavior on color {
                    ColorAnimation { duration: 150 }
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
                color: "#2f76dc"
                visible: parent.isActive
                radius: 1

                Behavior on visible {
                    NumberAnimation { duration: 150 }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch(`workspace ${wsId}`)
            }
        }
    }
}
