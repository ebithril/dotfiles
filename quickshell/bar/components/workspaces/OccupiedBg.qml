pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Item {
    id: root

    required property list<Workspace> workspaces
    required property var occupied
    required property int groupOffset

    property list<var> pills: []

    onOccupiedChanged: {
        let count = 0;
        const start = groupOffset;
        const end = start + 5;
        for (const [ws, occ] of Object.entries(occupied)) {
            if (ws > start && ws <= end && occ) {
                if (!occupied[ws - 1]) {
                    if (pills[count])
                        pills[count].start = ws;
                    else
                        pills.push(pillComp.createObject(root, {
                            start: ws
                        }));
                    count++;
                }
                if (!occupied[ws + 1])
                    pills[count - 1].end = ws;
            }
        }
        if (pills.length > count)
            pills.splice(count, pills.length - count).forEach(p => p.destroy());
    }

    Repeater {
        model: ScriptModel {
            values: root.pills.filter(p => p)
        }

        Rectangle {
            id: rect

            required property var modelData

            readonly property Workspace start: root.workspaces[modelData.start - 1 - root.groupOffset] ?? null
            readonly property Workspace end: root.workspaces[modelData.end - 1 - root.groupOffset] ?? null

            color: "#2B292F"
            radius: true ? 1000 : 0

            x: start?.x ?? 0
            y: start?.y ?? 0
            implicitWidth: 30
            implicitHeight: end?.y + end?.height - start?.y

            anchors.horizontalCenter: parent.horizontalCenter

            scale: 0
            Component.onCompleted: scale = 1

            Behavior on scale {
                Anim {
                    easing.bezierCurve: [0, 0, 0, 1, 1, 1]
                }
            }

            Behavior on x {
                Anim {}
            }

            Behavior on y {
                Anim {}
            }
        }
    }

    component Anim: NumberAnimation {
        duration: 400
        easing.type: Easing.BezierSpline
        easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
    }

    component Pill: QtObject {
        property int start
        property int end
    }

    Component {
        id: pillComp

        Pill {}
    }
}
