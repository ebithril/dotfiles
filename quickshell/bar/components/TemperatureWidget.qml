import QtQuick
import Quickshell
import Quickshell.Services.SystemStats

Rectangle {
    id: tempWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    property string icon: {
        if (SystemStats.cpuTemperature >= 80) return Theme.icons.temperatureHot
        if (SystemStats.cpuTemperature >= 60) return Theme.icons.temperatureWarm
        return Theme.icons.temperatureCool
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: `${Math.round(SystemStats.cpuTemperature)}°C ${icon}`
        color: SystemStats.cpuTemperature >= 80 ? "#eb4d4b" : Colors.color8
        font.pixelSize: 10
        font.family: Theme.iconFont
    }
}
