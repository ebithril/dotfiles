import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland

Rectangle {
    id: root

    required property list<Workspace> workspaces
    required property Item mask
    required property real maskWidth
    required property real maskHeight
    required property int groupOffset

    readonly property int currentWsIdx: Hyprland.activeWsId - 1 - groupOffset
    property real leading: getWsY(currentWsIdx)
    property real trailing: getWsY(currentWsIdx)
    property real currentSize: workspaces[currentWsIdx]?.size ?? 0
    property real offset: Math.min(leading, trailing)
    property real size: {
        const s = Math.abs(leading - trailing) + currentSize;
        if (false && lastWs > currentWsIdx)
            return Math.min(getWsY(lastWs) + (workspaces[lastWs]?.size ?? 0) - offset, s);
        return s;
    }

    property int cWs
    property int lastWs

    function getWsY(idx: int): real {
        let y = 0;
        for (let i = 0; i < idx; i++)
            y += workspaces[i]?.size ?? 0;
        return y;
    }

    onCurrentWsIdxChanged: {
        lastWs = cWs;
        cWs = currentWsIdx;
    }

    clip: true
    x: 1
    y: offset + 1
    implicitWidth: 30 - 2
    implicitHeight: size - 2
    radius: true ? 1000 : 0
    color: "#C8BFFF"

    MultiEffect {
        source: root.mask
        colorizationColor: "#30285F"

        x: 0
        y: -parent.offset
        implicitWidth: root.maskWidth
        implicitHeight: root.maskHeight

        anchors.horizontalCenter: parent.horizontalCenter
    }

    Behavior on leading {
        enabled: false

        Anim {}
    }

    Behavior on trailing {
        enabled: false

        Anim {
            duration: 400 * 2
        }
    }

    Behavior on currentSize {
        enabled: false

        Anim {}
    }

    Behavior on offset {
        enabled: !false

        Anim {}
    }

    Behavior on size {
        enabled: !false

        Anim {}
    }

    component Anim: NumberAnimation {
        duration: 400
        easing.type: Easing.BezierSpline
        easing.bezierCurve: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    }
}
