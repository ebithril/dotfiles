import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 15

    function getWorkspaceIcon(id) {
        if (Theme.character === "luffy") return Theme.icons.wsLuffy
        if (Theme.character === "zoro") return Theme.icons.wsZoro
        if (Theme.character === "nami") return Theme.icons.wsNami
        if (Theme.character === "usopp") return Theme.icons.wsUsopp
        if (Theme.character === "sanji") return Theme.icons.wsSanji
        if (Theme.character === "chopper") return Theme.icons.wsChopper
        if (Theme.character === "robin") return Theme.icons.wsRobin
        if (Theme.character === "franky") return Theme.icons.wsFranky
        if (Theme.character === "brook") return Theme.icons.wsBrook
        if (Theme.character === "jinbe") return Theme.icons.wsJinbe
        return Theme.icons.wsDefault
    }

    // Using simpler Unicode symbols that work without Nerd Fonts
    // Install a Nerd Font for better icons
    property var workspaceIcons: [
        {"id": 1},
        {"id": 2},
        {"id": 3},
        {"id": 4},
        {"id": 5},
        {"id": 6},
        {"id": 7},
        {"id": 8},
        {"id": 9}
    ]

    Repeater {
        model: workspaceIcons

        Rectangle {
            required property var modelData
            property int wsId: modelData.id
            property string wsIcon: getWorkspaceIcon(wsId)
            property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId

            Layout.preferredWidth: 20
            Layout.preferredHeight: 20

            color: "transparent"

            Text {
                id: wsText
                anchors.centerIn: parent
                text: parent.wsIcon
                color: parent.isActive ? Theme.highlightColor : Theme.foregroundColor
                font.pixelSize: 14
                font.family: Theme.iconFont
                font.bold: parent.isActive

                // Scale up active workspace circle
                scale: parent.isActive ? 1.3 : 1.0

                Behavior on color {
                    ColorAnimation { duration: Theme.animDuration; easing.type: Theme.animEasing }
                }

                Behavior on scale {
                    NumberAnimation { duration: Theme.animDuration; easing.type: Theme.animEasing }
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
                    NumberAnimation { duration: Theme.animDuration; easing.type: Theme.animEasing }
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
