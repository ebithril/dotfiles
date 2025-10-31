import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemStats
import Quickshell.Services.UPower
import Quickshell.Io

Rectangle {
    implicitHeight: row.implicitHeight + 10
    color: "#2E333F"
    radius: 5

    property var battery: UPower.displayDevice

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 5
        spacing: 10

        // CPU
        SystemStat {
            label: ""
            value: SystemStats.cpuUsage
            color: "#E62C39"  // crimson
        }

        // RAM
        SystemStat {
            label: ""
            value: SystemStats.memoryUsage * 100
            color: "#DFC18A"  // gold
        }

        // Disk
        SystemStat {
            id: diskStat
            label: "💾"
            value: diskUsage
            color: "#2f76dc"  // blue

            property real diskUsage: 0

            Process {
                id: diskProc
                command: ["sh", "-c", "df / | tail -1 | awk '{print $5}' | sed 's/%//'"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: diskStat.diskUsage = parseFloat(this.text.trim())
                }
            }

            Timer {
                interval: 5000
                running: true
                repeat: true
                onTriggered: diskProc.running = true
            }
        }

        // Battery
        SystemStat {
            visible: battery && battery.isPresent
            label: "󰁹"
            value: battery ? battery.percentage : 0
            color: "#FBC920"  // mango
        }
    }
}
