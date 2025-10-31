import QtQuick
import Quickshell
import Quickshell.Io

Item {
    property string label: ""
    property var command: []
    property color color: "#2f76dc"
    property real value: statValue

    implicitWidth: 60
    implicitHeight: 60

    property real statValue: 0

    // Get stat value periodically
    Process {
        id: getStatProc
        command: parent.command
        running: command.length > 0

        stdout: StdioCollector {
            onStreamFinished: {
                var val = parseFloat(this.text.trim())
                if (!isNaN(val)) {
                    parent.statValue = val
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: if (command.length > 0) getStatProc.running = true
    }

    // Background circle
    Rectangle {
        anchors.centerIn: parent
        width: 60
        height: 60
        radius: 30
        color: "transparent"
        border.width: 5
        border.color: "#4A4F5B"  // lighter grey
    }

    // Progress arc
    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            var centerX = width / 2
            var centerY = height / 2
            var radius = 27.5

            ctx.reset()

            // Draw arc
            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, -Math.PI / 2, -Math.PI / 2 + (value / 100 * 2 * Math.PI), false)
            ctx.lineWidth = 5
            ctx.strokeStyle = parent.color
            ctx.stroke()
        }

        Connections {
            target: parent
            function onValueChanged() {
                canvas.requestPaint()
            }
        }

        Component.onCompleted: requestPaint()
    }

    // Label
    Text {
        anchors.centerIn: parent
        text: label
        color: parent.color
        font.pixelSize: 20
    }
}
