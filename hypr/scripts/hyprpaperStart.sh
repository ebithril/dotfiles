#!/bin/bash

WALLPAPER_DIR="$HOME/dotfiles/assets/wallpapers/"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

hyprctl hyprpaper wallpaper ,"$WALLPAPER"
