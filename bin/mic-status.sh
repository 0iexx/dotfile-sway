#!/usr/bin/env bash

SOURCE=$(pactl get-default-source)
MUTED=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    pactl set-source-mute "$SOURCE" 0
else
    pactl set-source-mute "$SOURCE" 1
fi

