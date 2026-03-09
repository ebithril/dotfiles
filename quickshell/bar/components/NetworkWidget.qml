import QtQuick
import Quickshell
import Quickshell.Services.Network

Rectangle {
    id: networkWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    property var primaryConnection: Network.primaryConnection

    Text {
        id: label
        anchors.centerIn: parent
        text: {
            if (!primaryConnection) return `Disconnected ${Theme.icons.networkDisconnected}`
            if (primaryConnection.type === "wifi") {
                return `${primaryConnection.ssid || "WiFi"} (${primaryConnection.strength}%) ${Theme.icons.wifi}`
            }
            return `${Theme.icons.ethernet} `
        }
        color: Colors.color8
        font.pixelSize: 10
        font.family: Theme.iconFont
    }
}
