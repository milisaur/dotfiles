#!/usr/bin/env bash
set -euo pipefail

link=$(readlink /nix/var/nix/profiles/system)

if [[ $link =~ ^system-([0-9]+)-link$ ]]; then
    generation="${BASH_REMATCH[1]}"

    printf '{"text":"❄ %s","tooltip":"NixOS-Profilgeneration: %s"}\n' \
        "$generation" "$generation"
else
    printf '{"text":"❄ ?","tooltip":"Generation nicht ermittelbar","class":"warning"}\n'
fi
