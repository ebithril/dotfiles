import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Services.Backlight

ColumnLayout {
    spacing: 10

    property var audioSink: Pipewire.defaultAudioSink
    property var backlight: Backlight.devices[0]

    // Volume Control
    ControlMetric {
        Layout.fillWidth: true
        label: audioSink && audioSink.audio.muted ? " " : "🔊"
        value: audioSink ? audioSink.audio.volume * 100 : 0
        onValueChanged: (newValue) => {
            if (audioSink) {
                audioSink.audio.volume = newValue / 100
            }
        }
    }

    // Brightness Control
    ControlMetric {
        Layout.fillWidth: true
        visible: backlight !== null
        label: "󰃠 "
        value: backlight ? backlight.brightness * 100 : 0
        onValueChanged: (newValue) => {
            if (backlight) {
                backlight.brightness = newValue / 100
            }
        }
    }
}
