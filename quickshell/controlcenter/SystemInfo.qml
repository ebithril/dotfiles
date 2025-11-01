import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Rectangle {
    implicitHeight: row.implicitHeight + 10
    color: Theme.backgroundColor
    radius: 5

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 5
        spacing: 10

        // CPU
        SystemStatShell {
            label: ""
            command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | sed 's/%us,//'"]
            statColor: Theme.accent1Color
        }

        // RAM
        SystemStatShell {
            label: ""
            command: ["sh", "-c", "free | grep Mem | awk '{print ($3/$2) * 100.0}'"]
            statColor: Theme.accent2Color
        }

        // Disk
        SystemStatShell {
            label: "💾"
            command: ["sh", "-c", "df / | tail -1 | awk '{print $5}' | sed 's/%//'"]
            statColor: Theme.accent3Color
        }

        // Battery
        SystemStatShell {
            label: "󰁹"
            command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1"]
            statColor: Theme.accent4Color
            visible: batteryExists

            property bool batteryExists: false

            Process {
                id: checkBattery
                command: ["sh", "-c", "test -e /sys/class/power_supply/BAT0 && echo 1 || echo 0"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: parent.batteryExists = this.text.trim() === "1"
                }
            }
        }
    }
}
