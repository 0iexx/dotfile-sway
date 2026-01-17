#!/usr/bin/env bash

THEME_DIR="$HOME/.config/waybar/themes"
CURRENT="$HOME/.config/waybar/current"

THEME=$(ls "$THEME_DIR" | wofi --dmenu --prompt "Waybar Theme")

[[ -z "$THEME" ]] && exit 0

[[ ! -d "$THEME_DIR/$THEME" ]] && exit 1

cp "$THEME_DIR/$THEME/config.jsonc" "$CURRENT/config.jsonc"
cp "$THEME_DIR/$THEME/style.css" "$CURRENT/style.css"

pkill waybar
waybar -c "$CURRENT/config.jsonc" -s "$CURRENT/style.css" &

notify-send "Waybar" "Theme switched to $THEME"

