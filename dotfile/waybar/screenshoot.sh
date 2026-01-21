#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/screenshot-$(date +%s).png"

OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused==true).name')

grim -o "$OUTPUT" "$FILE"

notify-send "Screenshot saved" "$FILE"

