#!/usr/bin/env bash

WAL="$HOME/.cache/wal/colors.sh"
OUT="$HOME/.cache/wal/colors-rofi-alpha.rasi"

# تحميل ألوان pywal
source "$WAL"

# Alpha للخلفية فقط (85%)
ALPHA="D9"

cat > "$OUT" <<EOF
* {
    background: ${background}${ALPHA};

    normal-background: ${color0};
    selected-normal-background: ${color2};
    normal-foreground: ${foreground};
}
EOF

