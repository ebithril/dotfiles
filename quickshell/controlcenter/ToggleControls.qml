import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Rectangle {
    implicitHeight: row.implicitHeight + 6
    color: Qt.darker(Theme.backgroundColor, 1.05)
    radius: 5

    property var audioSink: Pipewire.defaultAudioSink

    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: 3
        spacing: 5

        // Volume Mute Toggle
        ToggleButton {
            inactiveLabel: Theme.icons.volumeMuted
            activeLabel: Theme.icons.volumeHigh
            active: audioSink ? !audioSink.audio.muted : false
            buttonColor: Theme.accent1Color
            onClicked: {
                if (audioSink) {
                    audioSink.audio.muted = !audioSink.audio.muted;
                }
            }
        }

        // WiFi Toggle
        ToggleButton {
            id: wifiToggle
            activeLabel: Theme.icons.wifi
            inactiveLabel: Theme.icons.networkDisconnected
            active: wifiEnabled === "enabled"
            buttonColor: Theme.accent2Color
            onClicked: {
                toggleWifiProc.command = ["nmcli", "radio", "wifi", active ? "off" : "on"]
                toggleWifiProc.running = true
            }

            property string wifiEnabled: ""

            Process {
                id: toggleWifiProc
                running: false
                onRunningChanged: {
                    if (!running) {
                        wifiProc.running = true
                    }
                }
            }

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
            activeLabel: Theme.icons.bluetooth
            inactiveLabel: Theme.icons.bluetoothDisabled
            active: btEnabled.includes("Running")
            buttonColor: Theme.accent3Color
            onClicked: {
                toggleBtProc.command = ["systemctl", active ? "stop" : "start", "bluetooth"]
                toggleBtProc.running = true
            }

            property string btEnabled: ""

            Process {
                id: toggleBtProc
                running: false
                onRunningChanged: {
                    if (!running) {
                        btProc.running = true
                    }
                }
            }

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
            activeLabel: Theme.icons.idleInhibit
            inactiveLabel: Theme.icons.sleep
            active: idleStatus === "0"
            buttonColor: Theme.accent4Color
            onClicked: {
                toggleIdleProc.running = true
                statusCheckDelay.start()
            }

            property string idleStatus: "0"

            Process {
                id: toggleIdleProc
                command: ["sh", "-c", "~/dotfiles/quickshell/scripts/toggle-idle"]
                running: false
            }

            Timer {
                id: statusCheckDelay
                interval: 500
                repeat: false
                onTriggered: idleProc.running = true
            }

            Process {
                id: idleProc
                command: ["sh", "-c", "~/dotfiles/quickshell/scripts/check-idle"]
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
