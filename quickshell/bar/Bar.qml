import "components"
import "components/workspaces"
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    id: barScope

    // Property to track control center state
    property bool controlCenterShown: false

    // Signal to toggle control center
    signal toggleControlCenter()

    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 25
            color: "transparent"

            // Background bar
            Rectangle {
                anchors.fill: parent
                color: "#2E333F"  // eww grey background

                // Main layout - left, center, right
                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    // Left side - Workspaces
                    Rectangle {
                        Layout.alignment: Qt.AlignLeft
                        Layout.leftMargin: 0
                        color: "#2E333F"

                        implicitWidth: workspacesInner.implicitWidth + 20
                        implicitHeight: parent.height

                        WorkspacesEwwStyle {
                            id: workspacesInner
                            anchors.centerIn: parent
                        }
                    }

                    // Center - Music player
                    Item {
                        Layout.fillWidth: true

                        Rectangle {
                            anchors.centerIn: parent
                            color: "#2E333F"
                            implicitWidth: musicWidget.implicitWidth
                            implicitHeight: parent.height

                            MusicWidget {
                                id: musicWidget
                                anchors.centerIn: parent
                            }
                        }
                    }

                    // Right side - Control center button and time
                    Rectangle {
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 0
                        color: "#2E333F"
                        implicitWidth: rightContent.implicitWidth + 20
                        implicitHeight: parent.height

                        RowLayout {
                            id: rightContent
                            anchors.centerIn: parent
                            spacing: 15

                            ControlCenterButton {
                                controlCenterShown: barScope.controlCenterShown
                                onClicked: barScope.toggleControlCenter()
                            }

                            ClockWidget {
                                id: timeWidget
                            }
                        }
                    }
                }
            }
        }
    }
}
