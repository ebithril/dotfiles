import "components"
import "components/workspaces"
import Quickshell
import QtQuick
import QtQuick.Layouts

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
            color: "transparent"

            // Main container using RowLayout for left-center-right layout
            RowLayout {
                anchors.fill: parent
                spacing: 0

                // Left side - Workspaces
                Rectangle {
                    id: workspaces

                    Layout.alignment: Qt.AlignLeft
                    Layout.leftMargin: 10

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

                // Center - Music player
                Item {
                    Layout.fillWidth: true

                    MusicWidget {
                        anchors.centerIn: parent
                    }
                }

                // Right side - System info and time
                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 10
                    spacing: 15

                    ClockWidget {}
                }
            }
        }
    }
}
