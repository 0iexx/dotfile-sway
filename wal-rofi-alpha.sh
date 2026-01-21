#!/usr/bin/env bash

WAL="$HOME/.cache/wal/colors.sh"
OUT="$HOME/.cache/wal/colors-rofi-alpha.rasi"

source "$WAL"

ALPHA="D9"

cat > "$OUT" <<EOF
* {
    background: ${background}${ALPHA};

    normal-background: ${color0};
    selected-normal-background: ${color2};
    normal-foreground: ${foreground};
}
EOF

