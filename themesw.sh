#!/usr/bin/env bash

WAYBAR_SCRIPT="$HOME/waybartheme.sh"
WALLPAPER_SCRIPT="$HOME/rofiwal.sh"
THEME="$HOME/.config/rofi/main-theme-rofi.rasi"
CHOICE=$(printf "󰕮  Change Waybar\n󰋫  Change Wallpaper\n  Change GTK" | \
  rofi -dmenu -i -theme "$THEME")

case "$CHOICE" in
  "󰕮  Change Waybar")
    bash "$WAYBAR_SCRIPT"
    ;;
  "󰋫  Change Wallpaper")
    bash "$WALLPAPER_SCRIPT"
    ;;
  "  Change GTK")
    nwg-look &
    ;;
  *)
    exit 0
    ;;
esac

