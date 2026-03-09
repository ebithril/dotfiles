import QtQuick
import Quickshell
import Quickshell.Services.PulseAudio

Rectangle {
    id: audioWidget
    implicitWidth: label.width + 14
    implicitHeight: 25
    color: "transparent"

    property var sink: PulseAudio.defaultSink

    Text {
        id: label
        anchors.centerIn: parent
        text: {
            if (!sink) return ""

            var volume = Math.round(sink.volume * 100)
            var icon = ""

            if (sink.muted) {
                return `(${volume}%) ${Theme.icons.volumeMuted}`
            }

            // Choose icon based on volume level
            if (volume >= 70) {
                icon = Theme.icons.volumeHigh
            } else if (volume >= 30) {
                icon = Theme.icons.volumeMedium
            } else {
                icon = Theme.icons.volumeLow
            }

            return `${volume}% ${icon}`
        }
        color: Colors.color8
        font.pixelSize: 10
        font.family: Theme.iconFont
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Launch pavucontrol
            Quickshell.exec("pavucontrol")
        }
        onWheel: (wheel) => {
            if (!sink) return
            var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
            sink.volume = Math.max(0, Math.min(1.5, sink.volume + delta))

            // Trigger volume popup
            volumePopupWindow.show()
        }
    }

    // Signal to trigger volume popup
    signal volumeChanged()
}
