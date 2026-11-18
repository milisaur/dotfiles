#!/usr/bin/env bash
set -euo pipefail

link=$(readlink /nix/var/nix/profiles/system)
generation="${link#system-}"
generation="${generation%-link}"

booted=$(readlink -f /run/booted-system)
active=$(readlink -f /run/current-system)
selected=$(readlink -f /nix/var/nix/profiles/system)

if [[ "$booted" == "$active" && "$active" == "$selected" ]]; then
    status="All system states match"
elif [[ "$active" == "$selected" ]]; then
    status="Changed since boot"
else
    status="System states differ"
fi

failed=$(systemctl --failed --no-legend --plain --no-pager | wc -l)

{
    printf '❄ Generation: %s\n' "$generation"
    printf '󰌽 Kernel: %s\n' "$(uname -r)"
    printf '󰥔 Uptime: %s\n' "$(uptime -p)"
    printf '⚠ Failed units: %s\n' "$failed"
    printf '↻ System: %s\n' "$status"
} | rofi -dmenu -i -p "NixOS"
