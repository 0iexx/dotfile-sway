#!/usr/bin/env bash

WALLDIR="$HOME/Pictures/Wallpaper"
CACHEDIR="$HOME/.cache/wall-thumbs"

mkdir -p "$CACHEDIR"

shopt -s nullglob
images=("$WALLDIR"/*.{jpg,jpeg,png,webp})
shopt -u nullglob

[ ${#images[@]} -eq 0 ] && {
  notify-send "rofiwal" "No wallpapers found in $WALLDIR"
  exit 1
}

# توليد thumbnails
for img in "${images[@]}"; do
  name="$(basename "$img")"
  thumb="$CACHEDIR/$name.png"

  if [ ! -f "$thumb" ]; then
    magick "$img" \
      -resize 640x360 \
      -gravity center \
      "$thumb"
  fi
done

# rofi grid
selection=$(for img in "${images[@]}"; do
  name="$(basename "$img")"
  echo -e "$name\x00icon\x1f$CACHEDIR/$name.png"
done | rofi -dmenu \
  -theme ~/.config/rofi/wallpaper.rasi \
  -p "Select Wallpaper")

[ -z "$selection" ] && exit 0

# pywal
wal -i "$WALLDIR/$selection"
pkill waybar; waybar \
  -c ~/.config/waybar/current/config.jsonc \
  -s ~/.config/waybar/current/style.css &
~/.config/swaylock/swaylock-pywal.sh

