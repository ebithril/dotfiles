import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Rectangle {
    implicitHeight: row.implicitHeight + 10
    color: Theme.backgroundColor
    radius: 5

    property var audioSink: Pipewire.defaultAudioSink

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 5
        spacing: 44

        // Volume Mute Toggle
        ToggleButton {
            inactiveLabel: ""
            activeLabel: "🔊"
            active: audioSink ? !audioSink.audio.muted : false
            buttonColor: Theme.accent1Color
            onClicked: {
                if (audioSink) {
                    audioSink.audio.muted = !audioSink.audio.muted
                }
            }
        }

        // WiFi Toggle
        ToggleButton {
            id: wifiToggle
            activeLabel: "󰤨"
            inactiveLabel: "󰤭"
            active: wifiEnabled === "enabled"
            buttonColor: Theme.accent2Color
            onClicked: {
                Quickshell.exec("nmcli radio wifi " + (active ? "off" : "on"))
            }

            property string wifiEnabled: ""

            Process {
                id: wifiProc
                command: ["nmcli", "radio", "wifi"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: wifiToggle.wifiEnabled = this.text.trim()
                }
            }

            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: wifiProc.running = true
            }
        }

        // Bluetooth Toggle
        ToggleButton {
            id: btToggle
            activeLabel: "󰂯"
            inactiveLabel: "󰂲"
            active: btEnabled.includes("Running")
            buttonColor: Theme.accent3Color
            onClicked: {
                Quickshell.exec(active ? "systemctl stop bluetooth" : "systemctl start bluetooth")
            }

            property string btEnabled: ""

            Process {
                id: btProc
                command: ["sh", "-c", "systemctl status bluetooth | grep Status | awk '{print $2}'"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: btToggle.btEnabled = this.text.trim()
                }
            }

            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: btProc.running = true
            }
        }

        // Idle Inhibit Toggle
        ToggleButton {
            id: idleToggle
            activeLabel: ""
            inactiveLabel: ""
            active: idleStatus === "0"
            buttonColor: Theme.accent4Color
            onClicked: {
                Quickshell.exec("~/dotfiles/eww/scripts/toggle-idle")
            }

            property string idleStatus: "0"

            Process {
                id: idleProc
                command: ["sh", "-c", "~/dotfiles/eww/scripts/check-idle"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: idleToggle.idleStatus = this.text.trim()
                }
            }

            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: idleProc.running = true
            }
        }
    }
}
