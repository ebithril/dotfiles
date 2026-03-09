import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    property string label: ""
    property var command: []
    property color statColor: "#2f76dc"
    property real value: statValue

    implicitWidth: 60
    implicitHeight: 60

    property real statValue: 0

    // Get stat value periodically
    Process {
        id: getStatProc
        command: root.command || []
        running: command.length > 0

        stdout: StdioCollector {
            onStreamFinished: {
                var val = parseFloat(this.text.trim())
                if (!isNaN(val)) {
                    root.statValue = val
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: if (root.command.length > 0) getStatProc.running = true
    }

    // Background circle
    Rectangle {
        anchors.centerIn: parent
        width: 60
        height: 60
        radius: 30
        color: "transparent"
        border.width: 5
        border.color: Qt.lighter(Theme.backgroundColor, 1.5)
    }

    // Progress arc
    Canvas {
        id: canvas
        anchors.fill: parent

        property real watchedValue: root.statValue
        onWatchedValueChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d")
            var centerX = width / 2
            var centerY = height / 2
            var radius = 27.5

            ctx.reset()

            // Draw arc
            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, -Math.PI / 2, -Math.PI / 2 + (root.value / 100 * 2 * Math.PI), false)
            ctx.lineWidth = 5
            ctx.strokeStyle = root.statColor
            ctx.stroke()
        }

        Component.onCompleted: requestPaint()
    }

    // Label
    Text {
        anchors.centerIn: parent
        text: root.label
        color: root.statColor
        font.pixelSize: 20
    }
}
