pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Available themes
    readonly property var themes: ({
        "solarized": {
            name: "Solarized Dark",
            background: "#002b36",
            foreground: "#839496",
            highlight: "#268bd2",
            accent1: "#dc322f",  // crimson
            accent2: "#b58900",  // gold
            accent3: "#268bd2",  // blue
            accent4: "#cb4b16",  // orange
            wallpaper: "~/dotfiles/assets/wallpapers/solarized.jpg"
        },
        "onepiece": {
            name: "One Piece",
            background: "#1a1a2e",  // dark navy (placeholder)
            foreground: "#eee",     // light text (placeholder)
            highlight: "#dc143c",   // crimson red for Luffy (placeholder)
            accent1: "#dc143c",     // red (placeholder)
            accent2: "#ffd700",     // straw hat gold (placeholder)
            accent3: "#4169e1",     // ocean blue (placeholder)
            accent4: "#ff6347",     // orange-red (placeholder)
            wallpaper: "~/dotfiles/assets/wallpapers/onepiece.jpg"
        },
        "brynas": {
            name: "Brynäs",
            background: "#0a0a0a",  // black background
            foreground: "#ffffff",  // white text
            highlight: "#e30613",   // Brynäs red
            accent1: "#e30613",     // red
            accent2: "#ffd700",     // gold
            accent3: "#e30613",     // red
            accent4: "#ffc107",     // lighter gold
            wallpaper: "~/dotfiles/assets/wallpapers/brynas.jpg"
        }
    })

    property string currentTheme: "solarized"

    // Wallpaper changer
    onCurrentThemeChanged: {
        var wallpaperPath = themes[currentTheme].wallpaper
        if (wallpaperPath) {
            wallpaperProcess.command = ["sh", "-c", "hyprctl hyprpaper reload ,\"" + wallpaperPath + "\""]
            wallpaperProcess.running = true
        }
    }

    Process {
        id: wallpaperProcess
        running: false
    }

    // Current theme colors
    readonly property string background: themes[currentTheme].background
    readonly property string foreground: themes[currentTheme].foreground
    readonly property string highlight: themes[currentTheme].highlight
    readonly property string accent1: themes[currentTheme].accent1
    readonly property string accent2: themes[currentTheme].accent2
    readonly property string accent3: themes[currentTheme].accent3
    readonly property string accent4: themes[currentTheme].accent4

    // Convert hex to Qt.rgba
    function hexToRgba(hex) {
        var r = parseInt(hex.substring(1, 3), 16) / 255
        var g = parseInt(hex.substring(3, 5), 16) / 255
        var b = parseInt(hex.substring(5, 7), 16) / 255
        return Qt.rgba(r, g, b, 1.0)
    }

    readonly property color backgroundColor: hexToRgba(background)
    readonly property color foregroundColor: hexToRgba(foreground)
    readonly property color highlightColor: hexToRgba(highlight)
    readonly property color accent1Color: hexToRgba(accent1)
    readonly property color accent2Color: hexToRgba(accent2)
    readonly property color accent3Color: hexToRgba(accent3)
    readonly property color accent4Color: hexToRgba(accent4)

    // Theme names for selector
    readonly property var themeNames: ["solarized", "onepiece", "brynas"]
}
