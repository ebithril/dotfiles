import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ControlMetric {
    id: brightnessControl

    label: Theme.icons.brightnessHigh
    value: brightnessValue

    property real brightnessValue: 0

    // Get brightness on start and periodically
    Process {
        id: getBrightness
        command: ["sh", "-c", "brightnessctl | grep Current | awk '{print $4}' | sed 's/[()%]//g'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var val = parseFloat(this.text.trim())
                if (!isNaN(val)) {
                    brightnessControl.brightnessValue = val
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: getBrightness.running = true
    }

    onSliderMoved: (newValue) => {
        // Set brightness via brightnessctl
        Quickshell.exec(`brightnessctl set ${Math.round(newValue)}%`)
    }
}
