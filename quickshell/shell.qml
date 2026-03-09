//@ pragma IconTheme oxygen
import Quickshell
import Quickshell.Hyprland
import "bar"
import "osd"
import "controlcenter"
import "themepicker"

Scope {
    Bar {
        id: bar
        controlCenterShown: controlCenter.shown
        onToggleControlCenter: controlCenter.shown = !controlCenter.shown
    }

    Osd {}

    ControlCenter {
        id: controlCenter
    }

    ThemePicker {
        id: themePicker
    }

    GlobalShortcut {
        appid: "quickshell"
        name: "theme"
        onPressed: themePicker.shown = !themePicker.shown
    }
}
