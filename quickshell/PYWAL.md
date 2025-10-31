# Pywal Integration

The quickshell theme system automatically integrates with pywal to generate colorschemes for all your pywal-compatible applications.

## How It Works

When you switch themes in the control center, quickshell automatically:
1. Changes the wallpaper using hyprpaper
2. Runs `wal -i <wallpaper_path> -n -q` to generate a colorscheme from the wallpaper
3. Updates all pywal-compatible applications with the new colors

## Setup

### 1. Install pywal

```bash
# Arch Linux
sudo pacman -S python-pywal

# Other distros
pip install pywal
```

### 2. Add Wallpapers

Place wallpaper images in `~/dotfiles/assets/wallpapers/`:
- `solarized.jpg` - For Solarized Dark theme
- `onepiece.jpg` - For One Piece theme
- `brynas.jpg` - For Brynäs theme

### 3. Configure Applications

Make your applications use pywal colors. Common examples:

**Terminal (kitty, alacritty, etc.):**
Add to your config to source pywal colors:
```bash
# In ~/.config/kitty/kitty.conf
include ~/.cache/wal/colors-kitty.conf
```

**Rofi:**
```bash
# In ~/.config/rofi/config.rasi
@theme "~/.cache/wal/colors-rofi-dark.rasi"
```

**Dunst:**
```bash
# Dunst automatically reloads from ~/.cache/wal/colors-dunst
```

**Other Applications:**
Check the [pywal wiki](https://github.com/dylanaraps/pywal/wiki/Customization) for templates for your applications.

## Pywal Command Options

The theme system runs: `wal -i <wallpaper_path> -n -q`

Flags explained:
- `-i <path>`: Use this image to generate colors
- `-n`: Don't set the wallpaper (quickshell handles this via hyprpaper)
- `-q`: Quiet mode (suppress output)

## Generated Files

Pywal stores generated colorschemes in:
- `~/.cache/wal/colors.sh` - Shell variables
- `~/.cache/wal/colors.json` - JSON format
- `~/.cache/wal/colors-<app>.conf` - App-specific configs

## Reloading Applications

Most applications automatically reload when pywal generates new colors. Some may need manual reload:
```bash
# Example: Reload specific services
systemctl --user restart dunst
```

## Troubleshooting

**Pywal not found:**
Ensure pywal is installed and in your PATH:
```bash
which wal
```

**Colors not updating:**
Check if your application supports pywal by looking for templates in:
```bash
ls ~/.cache/wal/
```

**Wallpaper not found:**
Ensure your wallpaper files exist and the paths in `quickshell/Theme.qml` are correct.
