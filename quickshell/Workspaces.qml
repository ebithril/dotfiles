import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    id: workspaces
    spacing: 0

    property var workspaceIcons: ({
        "1": "",
        "2": "",
        "3": "",
        "4": "",
        "9": "",
        "default": ""
    })

    Repeater {
        model: HyprlandWorkspaces {}

        Rectangle {
            id: workspaceButton
            required property HyprlandWorkspace modelData

            Layout.preferredWidth: 40
            Layout.preferredHeight: 25

            color: {
                if (modelData.active) return Colors.color6
                return "transparent"
            }

            Text {
                anchors.centerIn: parent
                text: {
                    var wsNum = workspaceButton.modelData.id.toString()
                    return workspaceIcons[wsNum] || workspaceIcons["default"]
                }
                color: workspaceButton.modelData.active ? Colors.color7 : Colors.color8
                font.family: "FontAwesome"
                font.pixelSize: 10
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch(`workspace ${workspaceButton.modelData.id}`)
            }
        }
    }
}
