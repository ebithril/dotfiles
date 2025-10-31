//@ pragma IconTheme oxygen
import Quickshell
import "bar"
import "osd"
import "controlcenter"

Scope {
    Bar {}
    Osd {}

    ControlCenter {
        id: controlCenter
    }

    // Global shortcut or way to toggle control center
    // You can bind this to a key in hyprland.conf:
    // bind = $mainMod, C, exec, qdbus org.quickshell /controlcenter toggle
}
