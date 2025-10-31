import QtQuick
import Quickshell
import Quickshell.Services.SystemStats

Rectangle {
    id: cpuWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: `${Math.round(SystemStats.cpuUsage)}% `
        color: Colors.color8
        font.pixelSize: 10
    }
}
