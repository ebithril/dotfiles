import QtQuick
import Quickshell
import Quickshell.Services.Backlight

Rectangle {
    id: backlightWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    property var backlight: Backlight.devices[0]

    Text {
        id: label
        anchors.centerIn: parent
        text: {
            if (!backlight) return ""
            var percent = Math.round(backlight.brightness * 100)
            var icon = ""
            if (percent >= 90) icon = Theme.icons.brightnessHigh
            else if (percent >= 60) icon = Theme.icons.brightnessMedium
            else if (percent >= 30) icon = Theme.icons.brightnessLow
            else icon = Theme.icons.brightnessMin
            return `${percent}% ${icon}`
        }
        color: Colors.color8
        font.pixelSize: 10
        font.family: Theme.iconFont
    }

    visible: backlight !== null
}
