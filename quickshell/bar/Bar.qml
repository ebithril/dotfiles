import "components"
import "components/workspaces"
import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            // the screen from the screens list will be injected into this
            // property
            required property var modelData

            // we can then set the window's screen to the injected property
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            Rectangle {
                id: workspaces

                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.top: osIcon.bottom
                anchors.topMargin: 12

                radius: 1000
                color: "#201F25"

                implicitWidth: workspacesInner.implicitWidth + 5 * 2
                implicitHeight: workspacesInner.implicitHeight + 5 * 2

                MouseArea {
                    anchors.fill: parent
                    anchors.leftMargin: -10
                    anchors.rightMargin: -10

                    function onWheel(event: WheelEvent): void {
                        const activeWs = Hyprland.activeToplevel?.workspace?.name;
                        if (activeWs?.startsWith("special:"))
                            Hyprland.dispatch(`togglespecialworkspace ${activeWs.slice(8)}`);
                        else if (event.angleDelta.y < 0 || Hyprland.activeWsId > 1)
                            Hyprland.dispatch(`workspace r${event.angleDelta.y > 0 ? "-" : "+"}1`);
                    }
                }

                Workspaces {
                    id: workspacesInner

                    anchors.centerIn: parent
                }
            }

            ClockWidget {
                anchors.centerIn: parent
            }
        }
    }
}
