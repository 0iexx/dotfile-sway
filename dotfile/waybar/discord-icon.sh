#!/usr/bin/env bash

# Nerd Font icon
ICON="  "

# Check Discord Flatpak process
if pgrep -f "com.discordapp.Discord" >/dev/null; then
    echo "$ICON"
    exit 0
fi

exit 1

