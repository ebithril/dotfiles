import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Rectangle {
    id: musicWidget
    implicitWidth: label.visible ? label.width + 20 : 0
    implicitHeight: 25
    color: "transparent"

    property var player: Mpris.players[0]

    Text {
        id: label
        anchors.centerIn: parent
        visible: player && player.playbackState === MprisPlaybackState.Playing
        text: {
            if (!player) return ""
            var artist = player.metadata.artist || ""
            var title = player.metadata.title || ""
            if (artist && title) {
                return `🎵 ${artist} - ${title}`
            } else if (title) {
                return `🎵 ${title}`
            }
            return ""
        }
        color: "#E5E1E9"
        font.pixelSize: 10
        elide: Text.ElideRight
        maximumLineCount: 1
    }
}
