#!/usr/bin/env bash
set -euo pipefail

link=$(readlink /nix/var/nix/profiles/system)

if [[ ! $link =~ ^system-([0-9]+)-link$ ]]; then
    printf '{"text":"❄ ?","tooltip":"Generation not found"}\n'
    exit 0
fi

generation="${BASH_REMATCH[1]}"

booted=$(readlink -f /run/booted-system)
active=$(readlink -f /run/current-system)
selected=$(readlink -f /nix/var/nix/profiles/system)

if [[ "$booted" == "$active" && "$active" == "$selected" ]]; then
    status="All system states match"
elif [[ "$active" == "$selected" ]]; then
    status="Active and selected match; changed since boot"
elif [[ "$booted" == "$active" ]]; then
    status="Active matches booted; different configuration selected"
else
    status="System states differ"
fi

printf '{"text":"❄ %s","tooltip":"NixOS-Generation: %s\\r%s"}\n' \
    "$generation" "$generation" "$status"
