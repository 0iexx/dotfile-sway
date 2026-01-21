#!/usr/bin/env bash

HOUR=$(date +%H)

if [ "$HOUR" -ge 7 ] && [ "$HOUR" -lt 18 ]; then
    echo ""
else
    echo "󰒲"
fi

