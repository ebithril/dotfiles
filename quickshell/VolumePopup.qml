import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.PulseAudio

Scope {
    id: volumeScope

    property var sink: PulseAudio.defaultSink

    // Watch for volume changes
    Connections {
        target: sink
        function onVolumeChanged() {
            volumePopupWindow.show()
        }
        function onMutedChanged() {
            volumePopupWindow.show()
        }
    }

    FloatingWindow {
        id: volumePopupWindow

        visible: false
        width: 300
        height: 100

        screen: Quickshell.screens[0]

        anchors {
            horizontalCenter: true
            top: true
            topMargin: 50
        }

        color: "transparent"

        function show() {
            visible = true
            hideTimer.restart()
        }

        Timer {
            id: hideTimer
            interval: 2000
            onTriggered: volumePopupWindow.visible = false
        }

        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.8)
            radius: 10
            border.width: 2
            border.color: Colors.color6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                // Volume icon and percentage
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    Text {
                        text: {
                            if (!sink) return ""
                            if (sink.muted) return ""

                            var volume = Math.round(sink.volume * 100)
                            if (volume >= 70) return ""
                            if (volume >= 30) return ""
                            return ""
                        }
                        color: "#ffffff"
                        font.pixelSize: 32
                        font.family: "FontAwesome"
                    }

                    Text {
                        text: sink ? `${Math.round(sink.volume * 100)}%` : "0%"
                        color: "#ffffff"
                        font.pixelSize: 24
                        font.bold: true
                    }

                    Text {
                        text: sink?.muted ? "MUTED" : ""
                        color: "#f53c3c"
                        font.pixelSize: 18
                        font.bold: true
                        visible: sink?.muted ?? false
                    }
                }

                // Volume bar
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10
                    color: Qt.rgba(1, 1, 1, 0.2)
                    radius: 5

                    Rectangle {
                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: parent.width * (sink?.volume ?? 0)
                        color: sink?.muted ? "#666666" : Colors.color6
                        radius: 5

                        Behavior on width {
                            NumberAnimation { duration: 100 }
                        }
                    }
                }
            }
        }
    }
}
