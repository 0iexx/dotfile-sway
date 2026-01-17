#!/usr/bin/env bash

HEADPHONES="alsa_output.usb-Topping_DX1-00.HiFi__Headphones__sink"
HDMI="alsa_output.pci-0000_0b_00.1.hdmi-stereo"

CURRENT=$(pactl get-default-sink)

# Toggle on click
if [[ "$1" == "toggle" ]]; then
    if [[ "$CURRENT" == "$HEADPHONES" ]]; then
        pactl set-default-sink "$HDMI"
    else
        pactl set-default-sink "$HEADPHONES"
    fi
fi

# Print icon for Waybar
if [[ "$CURRENT" == "$HEADPHONES" ]]; then
    echo ""   # headphones
else
    echo "󰓃"   # speaker
fi

