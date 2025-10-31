import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 15

    property var workspaceIcons: [
        {"id": 1, "icon": "1"},  // Temporarily use numbers
        {"id": 2, "icon": "2"},
        {"id": 3, "icon": "3"},
        {"id": 4, "icon": "4"},
        {"id": 5, "icon": "5"},
        {"id": 6, "icon": "6"},
        {"id": 7, "icon": "7"},
        {"id": 8, "icon": "8"},
        {"id": 9, "icon": "9"}
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
                id: wsText
                anchors.centerIn: parent
                text: parent.wsIcon
                color: parent.isActive ? Qt.rgba(0.184, 0.467, 0.867, 1.0) : Qt.rgba(0.725, 0.937, 0.973, 1.0)  // blue or cyan
                font.pixelSize: 14
                font.family: "FiraCode"
                font.bold: parent.isActive

                // Debug border
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "red"
                    border.width: 1
                    z: -1
                }

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
                color: Qt.rgba(0.184, 0.467, 0.867, 1.0)  // blue
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
