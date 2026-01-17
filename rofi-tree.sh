#!/usr/bin/env bash

THEME="$HOME/.config/rofi/main-rofi.rasi"

MENU=$(cat <<EOF
󰏘  Appearance
  Sway
  Script
  System
󰐥  Power
EOF
)

CHOICE=$(printf "%s\n" "$MENU" \
  | rofi -dmenu -i -theme "$THEME")

[ -z "$CHOICE" ] && exit 0

case "$CHOICE" in
  *Appearance)
    $HOME/themesw.sh
    ;;
  *Sway)
    $HOME/sway-rofi.sh
    ;;
  *Script)
    $HOME/script.sh
    ;;
  *System)
   alacritty --class infosys -e bash -lc $HOME/infosys.sh
    ;;
  *Power)
    wlogout &
    ;;
esac
