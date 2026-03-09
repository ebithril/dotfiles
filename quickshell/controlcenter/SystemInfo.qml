import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Rectangle {
    implicitHeight: row.implicitHeight + 6
    color: Qt.lighter(Theme.backgroundColor, 1.05)
    radius: 5
    border.width: 1
    border.color: Qt.lighter(Theme.backgroundColor, 1.15)

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 3
        spacing: 5

        // CPU
        SystemStatShell {
            label: Theme.icons.cpu
            command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | sed 's/%us,//'"]
            statColor: Theme.accent1Color
        }

        // RAM
        SystemStatShell {
            label: Theme.icons.memory
            command: ["sh", "-c", "free | grep Mem | awk '{print ($3/$2) * 100.0}'"]
            statColor: Theme.accent2Color
        }

        // Disk
        SystemStatShell {
            label: Theme.icons.disk
            command: ["sh", "-c", "df / | tail -1 | awk '{print $5}' | sed 's/%//'"]
            statColor: Theme.accent3Color
        }

        // Battery (using UPower)
        Item {
            id: batteryWidget
            implicitWidth: 60
            implicitHeight: 60
            visible: UPower.displayDevice.isLaptopBattery

            property real value: UPower.displayDevice.percentage
            property color statColor: Theme.accent4Color
            property string label: Theme.icons.battery

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
                id: batteryCanvas
                anchors.fill: parent

                property real watchedValue: batteryWidget.value
                onWatchedValueChanged: requestPaint()

                onPaint: {
                    var ctx = getContext("2d");
                    var centerX = width / 2;
                    var centerY = height / 2;
                    var radius = 27.5;

                    ctx.reset();

                    // Draw arc
                    ctx.beginPath();
                    ctx.arc(centerX, centerY, radius, -Math.PI / 2, -Math.PI / 2 + (batteryWidget.value * 2.0 * Math.PI), false);
                    ctx.lineWidth = 5;
                    ctx.strokeStyle = batteryWidget.statColor;
                    ctx.stroke();
                }

                Component.onCompleted: requestPaint()
            }

            // Label
            Text {
                anchors.centerIn: parent
                text: batteryWidget.label
                color: batteryWidget.statColor
                font.pixelSize: 20
            }
        }
    }
}
