import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Rectangle {
    implicitHeight: column.implicitHeight + 6
    color: Qt.darker(Theme.backgroundColor, 1.02)
    radius: 5
    border.width: 1
    border.color: Qt.lighter(Theme.backgroundColor, 1.15)

    property var audioSink: Pipewire.defaultAudioSink

    ColumnLayout {
        id: column
        anchors.fill: parent
        anchors.margins: 3
        spacing: 2

        // Volume Control
        ControlMetric {
            Layout.fillWidth: true
            label: audioSink && audioSink.audio.muted ? Theme.icons.volumeMuted : Theme.icons.volumeHigh
            value: audioSink ? audioSink.audio.volume * 100 : 0
            onSliderMoved: newValue => {
                if (audioSink) {
                    audioSink.audio.volume = newValue / 100;
                }
            }
        }

        // Brightness Control
        BrightnessControl {
            Layout.fillWidth: true
        }
    }
}
