#!/usr/bin/env bash

WAL_COLORS="$HOME/.cache/wal/colors.sh"
SWAYLOCK_CONFIG="$HOME/.config/swaylock/config"

[ -f "$WAL_COLORS" ] || { echo "Missing: $WAL_COLORS"; exit 1; }
# shellcheck disable=SC1090
source "$WAL_COLORS"

# "#RRGGBB" -> "rrggbb" or "rrggbbaa" (alpha at END)
hex() {
  local c="${1//#/}"       # remove '#'
  local a="${2:-}"         # optional alpha like "cc" or "00"
  echo "${c}${a}"
}

cat > "$SWAYLOCK_CONFIG" << EOF
# Auto-generated from pywal (~/.cache/wal/colors.sh)
screenshots

effect-blur=7x7
effect-vignette=0.5:0.5

clock
indicator
timestr=%H:%M
datestr=%a, %d %b

indicator-radius=200
indicator-thickness=10
ignore-empty-password
show-failed-attempts
fade-in=0.5

# Colors from pywal (format: rrggbb[aa])
inside-color=$(hex "$background")
bs-hl-color=$(hex "$color0")

ring-color=$(hex "$color4")
line-color=00000000

text-color=$(hex "$foreground")
key-hl-color=$(hex "$background")
separator-color=00000000

inside-clear-color=$(hex "$background")
ring-clear-color=$(hex "$color2")

inside-wrong-color=$(hex "$background")
ring-wrong-color=$(hex "$color1")
text-wrong-color=$(hex "$color1")

inside-ver-color=00000000
line-ver-color=$(hex "$color4")
text-ver-color=$(hex "$color4")

font=SF Pro Display
font-size=70
hide-keyboard-layout
EOF

