pragma Singleton
import QtQuick

QtObject {
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
            accent4: "#cb4b16"   // orange
        },
        "nord": {
            name: "Nord",
            background: "#2e3440",
            foreground: "#d8dee9",
            highlight: "#88c0d0",
            accent1: "#bf616a",  // red
            accent2: "#ebcb8b",  // yellow
            accent3: "#81a1c1",  // blue
            accent4: "#b48ead"   // purple
        },
        "dracula": {
            name: "Dracula",
            background: "#282a36",
            foreground: "#f8f8f2",
            highlight: "#bd93f9",
            accent1: "#ff5555",  // red
            accent2: "#f1fa8c",  // yellow
            accent3: "#8be9fd",  // cyan
            accent4: "#ffb86c"   // orange
        },
        "gruvbox": {
            name: "Gruvbox Dark",
            background: "#282828",
            foreground: "#ebdbb2",
            highlight: "#458588",
            accent1: "#cc241d",  // red
            accent2: "#d79921",  // yellow
            accent3: "#458588",  // blue
            accent4: "#d65d0e"   // orange
        },
        "eww": {
            name: "EWW Original",
            background: "#2E333F",
            foreground: "#B9EFF8",
            highlight: "#2f76dc",
            accent1: "#E62C39",  // crimson
            accent2: "#DFC18A",  // gold
            accent3: "#2f76dc",  // blue
            accent4: "#FBC920"   // mango
        }
    })

    property string currentTheme: "eww"

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
    readonly property var themeNames: ["eww", "solarized", "nord", "dracula", "gruvbox"]
}
