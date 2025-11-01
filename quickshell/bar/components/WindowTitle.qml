import QtQuick
import Quickshell
import Quickshell.Hyprland

Text {
    id: windowTitle

    text: HyprlandFocusedMonitor.activeWindow?.title ?? ""
    color: Colors.foreground
    font.pixelSize: 10
    elide: Text.ElideRight
    maximumLineCount: 1

    states: [
        State {
            when: text === ""
            PropertyChanges {
                target: windowTitle
                visible: false
            }
        }
    ]
}
