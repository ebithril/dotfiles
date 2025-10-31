import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: bar

    color: Colors.background

    // Bottom border
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 3
        color: Colors.color6
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Left modules
        RowLayout {
            Layout.alignment: Qt.AlignLeft
            spacing: 0

            Workspaces {
                id: workspaces
            }
        }

        // Center modules
        Item {
            Layout.fillWidth: true

            WindowTitle {
                anchors.centerIn: parent
            }
        }

        // Right modules
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 0

            CpuWidget {}
            MemoryWidget {}
            TemperatureWidget {}
            BacklightWidget {}
            NetworkWidget {}
            BatteryWidget {}
            AudioWidget {
                id: audioWidget
            }
            ClockWidget {}
            SystemTray {}
        }
    }
}
