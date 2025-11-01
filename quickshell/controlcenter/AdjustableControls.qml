import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

ColumnLayout {
    spacing: 10

    property var audioSink: Pipewire.defaultAudioSink

    // Volume Control
    ControlMetric {
        Layout.fillWidth: true
        label: audioSink && audioSink.audio.muted ? "🔇" : "🔊"
        value: audioSink ? audioSink.audio.volume * 100 : 0
        onSliderMoved: (newValue) => {
            if (audioSink) {
                audioSink.audio.volume = newValue / 100
            }
        }
    }

    // Brightness Control
    BrightnessControl {
        Layout.fillWidth: true
    }
}
