#!/usr/bin/env bash

SOURCE=$(pactl get-default-source)
MUTED=$(pactl get-source-mute "$SOURCE" | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    # أيقونة مايك مكتوم
    echo "󰍭"
else
    # أيقونة مايك شغال
    echo "󰍬"
fi

