pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string time

    Process {
        id: dateProc
        command: ["date", "+%H:%M %b %d, %Y"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text.trim()
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
