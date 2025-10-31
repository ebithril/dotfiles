//@ pragma IconTheme oxygen
import Quickshell
import "bar"
import "osd"
import "controlcenter"

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
}
