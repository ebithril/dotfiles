pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Available themes
    readonly property var themes: ({
            "luffy": {
                name: "Luffy (Gear 5)",
                background: "#181825",
                foreground: "#ffffff",
                highlight: "#f9e2af",
                accent1: "#ffffff",
                accent2: "#f9e2af",
                accent3: "#cba6f7",
                accent4: "#fab387",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/luffy.jpg",
                wanted: "../../assets/wallpapers/luffy-wanted.jpeg",
                animDuration: 600,
                animEasing: Easing.OutElastic,
                character: "luffy",
                hyprAnim: "bezier=nika,0.34,1.56,0.64,1.2; animation=windows,1,10,nika,popin 60%; animation=workspaces,1,10,nika,slide"
            },
            "zoro": {
                name: "Zoro (Slash)",
                background: "#11111b",
                foreground: "#cdd6f4",
                highlight: "#a6e3a1",
                accent1: "#a6e3a1",
                accent2: "#94e2d5",
                accent3: "#313244",
                accent4: "#eba0ac",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/zoro.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/zoro-wanted.png",
                animDuration: 150,
                animEasing: Easing.OutQuint,
                character: "zoro",
                hyprAnim: "bezier=slash,0.1,1,0,1; animation=windows,1,4,slash,slide; animation=workspaces,1,5,slash,slide"
            },
            "nami": {
                name: "Nami (Clima-Tact)",
                background: "#1e1e2e",
                foreground: "#f9e2af",
                highlight: "#fab387",
                accent1: "#fab387",
                accent2: "#f9e2af",
                accent3: "#89dceb",
                accent4: "#a6e3a1",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/nami.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/nami-wanted.jpg",
                animDuration: 300,
                animEasing: Easing.InOutSine,
                character: "nami",
                hyprAnim: "bezier=wind,0.45,0,0.55,1; animation=windows,1,8,wind,slide; animation=workspaces,1,8,wind,slidefade"
            },
            "usopp": {
                name: "Usopp (Sniper)",
                background: "#181825",
                foreground: "#a6e3a1",
                highlight: "#f9e2af",
                accent1: "#f9e2af",
                accent2: "#a6e3a1",
                accent3: "#fab387",
                accent4: "#94e2d5",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/usopp.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/usopp-wanted.jpg",
                animDuration: 250,
                animEasing: Easing.OutBack,
                character: "usopp",
                hyprAnim: "bezier=target,0.175, 0.885, 0.32, 1.275; animation=windows,1,7,target,popin; animation=workspaces,1,7,target,slide"
            },
            "sanji": {
                name: "Sanji (Black Leg)",
                background: "#11111b",
                foreground: "#f9e2af",
                highlight: "#f38ba8",
                accent1: "#f38ba8",
                accent2: "#f9e2af",
                accent3: "#89b4fa",
                accent4: "#eba0ac",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/sanji.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/sanji-wanted.jpg",
                animDuration: 200,
                animEasing: Easing.InBack,
                character: "sanji",
                hyprAnim: "bezier=kick,0.6, -0.28, 0.735, 0.045; animation=windows,1,6,kick,slide; animation=workspaces,1,6,kick,slide"
            },
            "chopper": {
                name: "Chopper (Doctor)",
                background: "#1e1e2e",
                foreground: "#f5c2e7",
                highlight: "#f5c2e7",
                accent1: "#f5c2e7",
                accent2: "#89dceb",
                accent3: "#f9e2af",
                accent4: "#eba0ac",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/chopper.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/chopper-wanted.jpg",
                animDuration: 400,
                animEasing: Easing.InOutBack,
                character: "chopper",
                hyprAnim: "bezier=bounce,0.175, 0.885, 0.32, 1.275; animation=windows,1,10,bounce,popin; animation=workspaces,1,10,bounce,slide"
            },
            "robin": {
                name: "Robin (Fleur)",
                background: "#1e1e2e",
                foreground: "#cba6f7",
                highlight: "#cba6f7",
                accent1: "#cba6f7",
                accent2: "#f5c2e7",
                accent3: "#94e2d5",
                accent4: "#89b4fa",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/robin.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/robin-wanted.jpg",
                animDuration: 500,
                animEasing: Easing.InOutCubic,
                character: "robin",
                hyprAnim: "bezier=bloom,0.65, 0, 0.35, 1; animation=windows,1,12,bloom,slide; animation=workspaces,1,10,bloom,slidefade"
            },
            "franky": {
                name: "Franky (General)",
                background: "#181825",
                foreground: "#89dceb",
                highlight: "#f38ba8",
                accent1: "#f38ba8",
                accent2: "#89dceb",
                accent3: "#89b4fa",
                accent4: "#fab387",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/franky.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/franky-wanted.jpg",
                animDuration: 300,
                animEasing: Easing.Linear,
                character: "franky",
                hyprAnim: "bezier=metal,0,0,1,1; animation=windows,1,8,metal,slide; animation=workspaces,1,8,metal,slide"
            },
            "brook": {
                name: "Brook (Soul)",
                background: "#11111b",
                foreground: "#cdd6f4",
                highlight: "#cba6f7",
                accent1: "#cba6f7",
                accent2: "#313244",
                accent3: "#bac2de",
                accent4: "#ffffff",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/brook.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/brook-wanted.jpeg",
                animDuration: 800,
                animEasing: Easing.OutExpo,
                character: "brook",
                hyprAnim: "bezier=soul,0.16, 1, 0.3, 1; animation=windows,1,15,soul,slide; animation=workspaces,1,12,soul,slidefade"
            },
            "jinbe": {
                name: "Jinbe (Knight)",
                background: "#181825",
                foreground: "#89b4fa",
                highlight: "#fab387",
                accent1: "#fab387",
                accent2: "#89b4fa",
                accent3: "#94e2d5",
                accent4: "#f9e2af",
                wallpaper: "$HOME/dotfiles/assets/wallpapers/jinbei.jpg",
                wanted: "$HOME/dotfiles/assets/wallpapers/jinbei-wanted.jpg",
                animDuration: 400,
                animEasing: Easing.InOutQuad,
                character: "jinbe",
                hyprAnim: "bezier=wave,0.45, 0, 0.55, 1; animation=windows,1,10,wave,slide; animation=workspaces,1,10,wave,slide"
            }
        })

    property string currentTheme: "luffy"

    // Animation settings
    readonly property int animDuration: themes[currentTheme].animDuration ?? 200
    readonly property int animEasing: themes[currentTheme].animEasing ?? Easing.InOutQuad
    readonly property string character: themes[currentTheme].character ?? "none"

    // Wallpaper and pywal changer
    onCurrentThemeChanged: {
        var themeData = themes[currentTheme];
        var wallpaperPath = themeData.wallpaper;
        if (wallpaperPath) {
            // Change wallpaper
            wallpaperProcess.command = ["sh", "-c", "hyprctl hyprpaper wallpaper ,\"" + wallpaperPath + "\""];
            wallpaperProcess.running = true;

            // Prepare hyprland animation content
            var hyprContent = "";
            if (themeData.hyprAnim) {
                var anims = themeData.hyprAnim.split(";");
                for (var i = 0; i < anims.length; i++) {
                    hyprContent += "keyword " + anims[i].trim() + "\n";
                }
            }

            // Format for sourcing: just use keywords directly
            var hyprFileContent = themeData.hyprAnim ? themeData.hyprAnim.replace(/;/g, "\n") : "";

            // Apply pywal theme (using predefined colorscheme) and reload apps
            pywalProcess.command = ["sh", "-c", "wal --theme " + currentTheme + " -n -q && echo \"" + hyprFileContent + "\" > ~/.cache/wal/hyprland-anim.conf && walcord -t ~/.cache/wal/vesktop-walcord.theme.css -o ~/.config/vesktop/themes/walcord.theme.css -q && killall -SIGUSR1 kitty && hyprctl reload"];
            pywalProcess.running = true;
        }
    }

    Process {
        id: wallpaperProcess
        running: false
    }

    Process {
        id: pywalProcess
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
        var r = parseInt(hex.substring(1, 3), 16) / 255;
        var g = parseInt(hex.substring(3, 5), 16) / 255;
        var b = parseInt(hex.substring(5, 7), 16) / 255;
        return Qt.rgba(r, g, b, 1.0);
    }

    readonly property color backgroundColor: hexToRgba(background)
    readonly property color foregroundColor: hexToRgba(foreground)
    readonly property color highlightColor: hexToRgba(highlight)
    readonly property color accent1Color: hexToRgba(accent1)
    readonly property color accent2Color: hexToRgba(accent2)
    readonly property color accent3Color: hexToRgba(accent3)
    readonly property color accent4Color: hexToRgba(accent4)

    // Font settings
    readonly property string textFont: "FiraCode"
    readonly property string iconFont: "FiraCode Nerd Font"

    // Icon definitions (Nerd Font icons)
    readonly property QtObject icons: QtObject {
        // System stats
        readonly property string cpu: "󰻠"
        readonly property string memory: "󰍛"
        readonly property string disk: "󰋊"
        readonly property string battery: "󰁹"

        // Battery states
        readonly property string batteryCharging: "󰂄"
        readonly property string batteryFull: "󰁹"
        readonly property string battery70: "󰂂"
        readonly property string battery50: "󰂀"
        readonly property string battery30: "󰁾"
        readonly property string batteryLow: "󰁺"

        // Audio/Volume
        readonly property string volumeHigh: "󰕾"
        readonly property string volumeMedium: "󰖀"
        readonly property string volumeLow: "󰕿"
        readonly property string volumeMuted: "󰖁"

        // Network
        readonly property string wifi: "󰖨"
        readonly property string ethernet: "󰈀"
        readonly property string networkDisconnected: "󰖪"

        // Brightness
        readonly property string brightnessHigh: "󰃠"
        readonly property string brightnessMedium: "󰃟"
        readonly property string brightnessLow: "󰃞"
        readonly property string brightnessMin: "󰃝"

        // Temperature
        readonly property string temperatureHot: "󱃂"
        readonly property string temperatureWarm: "󰔏"
        readonly property string temperatureCool: "󰔐"

        // Bluetooth
        readonly property string bluetooth: "󰂯"
        readonly property string bluetoothDisabled: "󰂲"

        // Idle/Sleep
        readonly property string idleInhibit: "󰅶"
        readonly property string sleep: "󰒲"

        // Character workspace icons
        readonly property string wsLuffy: "󰚎"   // Straw hat
        readonly property string wsZoro: "󰓠"    // Swords
        readonly property string wsNami: "󰖐"    // Cloud
        readonly property string wsUsopp: "󰛋"   // Target
        readonly property string wsSanji: "󱗿"   // Chef hat
        readonly property string wsChopper: "󰄏" // Medical cross
        readonly property string wsRobin: "󱥔"   // Lotus flower
        readonly property string wsFranky: "󰚗"  // Robot
        readonly property string wsBrook: "󰝚"   // Music note
        readonly property string wsJinbe: "󰈼"   // Anchor
        readonly property string wsDefault: "●"
    }

    // Theme names for selector
    readonly property var themeNames: ["luffy", "zoro", "nami", "usopp", "sanji", "chopper", "robin", "franky", "brook", "jinbe"]
}
