import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Item {
    id: musicWidget
    implicitWidth: label.visible ? label.implicitWidth : 0
    implicitHeight: 25

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
        color: Theme.foregroundColor
        font.pixelSize: 12
        font.family: "FiraCode"
        elide: Text.ElideRight
        maximumLineCount: 1
    }
}
