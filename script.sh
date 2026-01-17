#!/usr/bin/env bash

THEME="$HOME/.config/rofi/main-rofi.rasi"

MENU=$(cat <<EOF
󰏘  Alias
  WebApp
󰇚  yt-tool
EOF
)

CHOICE=$(printf "%s\n" "$MENU" \
  | rofi -dmenu -i -theme "$THEME")

[ -z "$CHOICE" ] && exit 0

case "$CHOICE" in
  *Alias)
    alacritty --class aliasmaker -e bash -lc $HOME/aliasmaker.sh
    ;;
  *WebApp)
    alacritty --class webapp  -e bash -lc $HOME/webapp-brave.sh
    ;;
  *yt-tool)
    alacritty -e bash -lc $HOME/Script/yt-tool2.py
    ;;
esac
