import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property int index
    required property var occupied
    required property int groupOffset

    readonly property bool isWorkspace: true // Flag for finding workspace children
    // Unanimated prop for others to use as reference
    readonly property real size: childrenRect.height + (hasWindows ? 7 : 0)

    readonly property int ws: groupOffset + index + 1
    readonly property bool isOccupied: occupied[ws] ?? false
    readonly property bool hasWindows: isOccupied && true

    Layout.preferredWidth: childrenRect.width
    Layout.preferredHeight: size

    Text {
        id: indicator

        readonly property string label: "  " || root.ws
        readonly property string occupiedLabel: "󰮯 " || label
        readonly property string activeLabel: "󰮯 " || (root.isOccupied ? occupiedLabel : label)

        //animate: true
        text: Hyprland.focusedWorkspace.id === root.ws ? activeLabel : root.isOccupied ? occupiedLabel : label
        color: false || Hyprland.focusedWorkspace.id === root.ws ? "#E5E1E9" : "#48454E"
        horizontalAlignment: Text.AlignCenter
        verticalAlignment: Text.AlignCenter

        width: 30
        height: 30
    }

    Loader {
        id: windows

        active: true
        asynchronous: true

        anchors.horizontalCenter: indicator.horizontalCenter
        anchors.top: indicator.bottom
        anchors.topMargin: -30 / 10

        sourceComponent: Row {
            spacing: 0

            add: Transition {
                Anim {
                    properties: "scale"
                    from: 0
                    to: 1
                    easing.bezierCurve: [0, 0, 0, 1, 1, 1]
                }
            }

            move: Transition {
                Anim {
                    properties: "scale"
                    to: 1
                    easing.bezierCurve: [0, 0, 0, 1, 1, 1]
                }
                Anim {
                    properties: "x,y"
                }
            }

            Repeater {
                model: ScriptModel {
                    values: Hyprland.toplevels.values.filter(c => c.workspace?.id === root.ws)
                }

                Text {
                    required property var modelData

                    //grade: 0
                    text: Icons.getAppCategoryIcon(modelData.lastIpcObject.class, "terminal")
                    color: "#48454E"
                }
            }
        }
    }

    Behavior on Layout.preferredWidth {
        Anim {}
    }

    Behavior on Layout.preferredHeight {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: 400
        easing.type: Easing.BezierSpline
        easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
    }
}
