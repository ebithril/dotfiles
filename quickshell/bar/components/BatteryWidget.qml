import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    id: batteryWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: {
        if (battery && battery.percentage <= 15 && !battery.charging) {
            return "#f53c3c"
        }
        return "transparent"
    }

    property var battery: UPower.displayDevice

    Text {
        id: label
        anchors.centerIn: parent
        text: {
            if (!battery || !battery.isPresent) return ""

            var icon = ""
            if (battery.charging) {
                icon = Theme.icons.batteryCharging
            } else if (battery.percentage >= 90) {
                icon = Theme.icons.batteryFull
            } else if (battery.percentage >= 70) {
                icon = Theme.icons.battery70
            } else if (battery.percentage >= 50) {
                icon = Theme.icons.battery50
            } else if (battery.percentage >= 30) {
                icon = Theme.icons.battery30
            } else {
                icon = Theme.icons.batteryLow
            }

            return `${Math.round(battery.percentage)}% ${icon}`
        }
        color: Colors.color8
        font.pixelSize: 10
        font.family: Theme.iconFont
    }

    SequentialAnimation on opacity {
        running: battery && battery.percentage <= 15 && !battery.charging
        loops: Animation.Infinite
        NumberAnimation { to: 0.3; duration: 500 }
        NumberAnimation { to: 1.0; duration: 500 }
    }
}
