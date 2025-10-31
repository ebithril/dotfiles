import QtQuick
import Quickshell

Rectangle {
    id: clockWidget
    implicitWidth: label.width + 10
    implicitHeight: 25
    color: "transparent"

    property date currentTime: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currentTime = new Date()
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: Qt.formatDateTime(currentTime, "hh:mm")
        color: Colors.color8
        font.pixelSize: 10
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Could open a calendar popup here
        }
    }
}
