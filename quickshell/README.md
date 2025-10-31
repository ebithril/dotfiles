# Quickshell Configuration

This is a quickshell configuration ported from eww, with a volume OSD (on-screen display).

## Features

### Bar
- **Hyprland workspace indicator** - Animated workspace switcher with mouse wheel support
- **Music player widget** - Shows currently playing track (via MPRIS)
- **Clock** - Time display

### OSD (On-Screen Display)
- **Volume popup** - Shows when volume changes via media keys or PulseAudio/Pipewire
- Displays volume icon and visual progress bar
- Auto-hides after 1 second
- Positioned at bottom center of screen

### Additional Widgets (Available but not in bar)
The following widgets are available in `bar/components/` but not currently displayed:
- CPU usage monitor
- Memory usage monitor
- Temperature monitor
- Network status
- Battery indicator
- Backlight/brightness control
- Audio widget with click controls
- System tray
- Window title display

## Installation

1. Install quickshell: Follow instructions at https://quickshell.outfoxxed.me

2. Link or copy this configuration:
   ```bash
   ln -s ~/dotfiles/quickshell ~/.config/quickshell
   ```

3. The quickshell config will launch automatically via hyprland.conf

## Structure

```
quickshell/
├── shell.qml           # Main entry point
├── bar/
│   ├── Bar.qml         # Bar layout and configuration
│   └── components/     # Individual widgets
│       ├── workspaces/
│       ├── ClockWidget.qml
│       ├── MusicWidget.qml
│       └── ...
├── osd/
│   └── Osd.qml         # Volume popup overlay
└── Colors.qml          # Color definitions (for future wal support)
```

## Customization

To add more widgets to the bar, edit `bar/Bar.qml` and add widgets from the `components/` directory to the right side RowLayout.

Example:
```qml
RowLayout {
    Layout.alignment: Qt.AlignRight
    Layout.rightMargin: 10
    spacing: 15

    BatteryWidget {}
    NetworkWidget {}
    ClockWidget {}
}
```

## Volume OSD

The volume OSD automatically shows when:
- Volume is changed via media keys (XF86AudioRaiseVolume, XF86AudioLowerVolume)
- Volume is changed via PulseAudio/Pipewire
- Mute state is toggled

The popup displays for 1 second and shows:
- Volume icon
- Visual volume bar with current volume level
