import QtQuick
import Quickshell
import Quickshell.Services.SystemStats

Rectangle {
    id: memoryWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: `${Math.round(SystemStats.memoryUsage * 100)}% `
        color: Colors.color8
        font.pixelSize: 10
    }
}
