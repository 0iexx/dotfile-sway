#!/usr/bin/env bash

THEME_DIR="$HOME/.config/waybar/themes"
CURRENT="$HOME/.config/waybar/current"

ROFI_THEME="$HOME/.config/rofi/main-rofi.rasi"

mkdir -p "$CURRENT"

CHOICE=$(ls "$THEME_DIR" \
  | rofi -dmenu -i -p "Waybar Theme" -theme "$ROFI_THEME")

[[ -z "$CHOICE" ]] && exit 0

cp "$THEME_DIR/$CHOICE/config.jsonc" "$CURRENT/config.jsonc"
cp "$THEME_DIR/$CHOICE/style.css"     "$CURRENT/style.css"

pkill waybar
waybar -c "$CURRENT/config.jsonc" -s "$CURRENT/style.css" &

notify-send "Waybar" "Theme applied" "$CHOICE"
