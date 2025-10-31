# Quickshell Configuration

Complete port of eww configuration to quickshell, including bar and control center.

## Features

### Bar
Matches the original eww bar design:
- **Left**: Hyprland workspace indicator with icons
- **Center**: Music player (shows currently playing via MPRIS/playerctl)
- **Right**: Clock/time display
- **Styling**: Grey background (#2E333F), cyan text (#B9EFF8), blue highlights (#2f76dc), FiraCode font

### Control Center
Full-featured control panel (opens on right side):
- **Toggle Controls**: Volume mute, WiFi, Bluetooth, Idle inhibitor (with colored buttons)
- **Sliders**: Volume and brightness adjustable controls
- **System Stats**: Circular progress indicators for CPU, RAM, Disk, Battery
- **Header**: Current time display

### Volume OSD
- Shows when volume changes via media keys or PulseAudio/Pipewire
- Visual progress bar at bottom center
- Auto-hides after 1 second

## Installation

1. Install quickshell: https://quickshell.outfoxxed.me

2. Link configuration:
   ```bash
   ln -s ~/dotfiles/quickshell ~/.config/quickshell
   ```

3. Ensure eww scripts are executable:
   ```bash
   chmod +x ~/dotfiles/eww/scripts/*
   ```

4. Launch quickshell (already configured in hyprland.conf)

## Usage

### Opening Control Center

The control center can be toggled by modifying `shell.qml` to set `controlCenter.shown = true/false`. You can bind this to a keybinding in hyprland or create a toggle mechanism.

To make it visible by default, edit `quickshell/shell.qml`:
```qml
ControlCenter {
    id: controlCenter
    shown: true  // Add this line
}
```

## Structure

```
quickshell/
├── shell.qml              # Main entry point
├── bar/
│   ├── Bar.qml            # Bar layout (eww-styled)
│   └── components/        # Bar widgets
│       ├── WorkspacesEwwStyle.qml
│       ├── MusicWidget.qml
│       ├── ClockWidget.qml
│       ├── Time.qml (singleton)
│       └── ... (additional widgets)
├── osd/
│   └── Osd.qml            # Volume popup
├── controlcenter/
│   ├── ControlCenter.qml  # Main control center window
│   ├── ToggleControls.qml # Mute/WiFi/BT/Idle toggles
│   ├── AdjustableControls.qml  # Volume/brightness sliders
│   ├── SystemInfo.qml     # CPU/RAM/Disk/Battery stats
│   ├── Time.qml (singleton)
│   └── ... (sub-components)
└── Colors.qml             # Color definitions
```

## Color Scheme

Based on eww configuration:
- **Background**: #2E333F (grey)
- **Foreground**: #B9EFF8 (cyan)
- **Highlight**: #2f76dc (blue)
- **Accent colors**:
  - Crimson: #E62C39 (volume/CPU)
  - Gold: #DFC18A (WiFi/RAM)
  - Blue: #2f76dc (Bluetooth/Disk)
  - Mango: #FBC920 (Idle/Battery)

## Additional Widgets

The following widgets are available in `bar/components/` but not currently displayed:
- AudioWidget, BacklightWidget, BatteryWidget
- CpuWidget, MemoryWidget, TemperatureWidget
- NetworkWidget, SystemTray, WindowTitle

To add them to the bar, edit `bar/Bar.qml`.

## Dependencies

- quickshell
- Hyprland
- playerctl (for music)
- brightnessctl (for brightness)
- NetworkManager (for WiFi)
- PulseAudio/Pipewire (for audio)
- eww scripts directory (for idle/bluetooth checks)
