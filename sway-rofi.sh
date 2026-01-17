#!/usr/bin/env bash

CONF_DIR="$HOME/.config/sway/conf.d"

declare -A FILES=(
  ["󰍹  Display"]="10-Display.conf"
  ["󰁪  Autostart"]="20-AutoStart.conf"
  ["󰖯  App Window"]="30-AppWindow.conf"
  ["󰌌  Keybinds"]="40-KeyBind.conf"
  ["  Window Border"]="50-WindowBorder.conf"
  ["  Workspaces"]="60-Workspaces.conf"
)

CHOICE=$(printf "%s\n" "${!FILES[@]}" \
  | sort \
  | rofi -dmenu -i -theme ~/.config/rofi/sway-menu.rasi)

[ -z "$CHOICE" ] && exit 0

FILE="${FILES[$CHOICE]}"

[ -z "$FILE" ] && exit 0
exec emacs -L "$EDITOR" "$CONF_DIR/$FILE"

