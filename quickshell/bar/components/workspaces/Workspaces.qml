pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root

    readonly property list<Workspace> workspaces: layout.children.filter(c => c.isWorkspace).sort((w1, w2) => w1.ws - w2.ws)
    readonly property var occupied: Hyprland.workspaces.values.reduce((acc, curr) => {
        acc[curr.id] = curr.lastIpcObject.windows > 0;
        return acc;
    }, {})
    readonly property int groupOffset: Math.floor((Hyprland.activeWsId - 1) / 5) * 5

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    RowLayout {
        id: layout

        spacing: 0
        layer.enabled: true
        layer.smooth: true

        Repeater {
            model: 9

            Workspace {
                occupied: root.occupied
                groupOffset: root.groupOffset
            }
        }
    }

    Loader {
        active: false
        asynchronous: true

        z: -1
        anchors.fill: parent

        sourceComponent: OccupiedBg {
            workspaces: root.workspaces
            occupied: root.occupied
            groupOffset: root.groupOffset
        }
    }

    Loader {
        active: true
        asynchronous: true

        sourceComponent: ActiveIndicator {
            workspaces: root.workspaces
            mask: layout
            maskWidth: root.width
            maskHeight: root.height
            groupOffset: root.groupOffset
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: event => {
            const ws = layout.childAt(event.x, event.y).index + root.groupOffset + 1;
            if (Hyprland.activeWsId !== ws)
                Hyprland.dispatch(`workspace ${ws}`);
        }
    }
}
