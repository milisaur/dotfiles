# Personal NixOS configuration using **flakes** with **Home Manager**, built for a multi-machine setup.

---

## Overview

This repository contains my system and user configuration for multiple NixOS machines.  
It separates host-specific configuration from shared components while keeping the setup simple and maintainable.

---

This setup is built around:

- **NixOS + flakes**
- **Home Manager**
- **Modular configuration**
- **Multi-host support**

Each machine has its own configuration while sharing common modules where appropriate.

---

## Structure
```text

├── assets
│   └── wallpapers
│       └── main.jpg
├── flake.lock
├── flake.nix
├── hosts
│   ├── ankylosaurus
│   │   ├── home-manager/
│   │   ├── hypr/
│   │   ├── mako/
│   │   ├── nixos/
│   │   └── waybar/
│   ├── spinosaurus
│   │   ├── home-manager/
│   │   └── nixos/
│   └── uniraptor
│       ├── home-manager/
│       └── nixos/
├── modules
│   ├── common.nix
│   └── home
│       ├── dev.nix
│       ├── fonts.nix
│       ├── gaming.nix
│       ├── gpg.nix
│       ├── hyprland/
│       ├── kitty.nix
│       ├── mako.nix
│       ├── nvim.nix
│       ├── r.nix
│       ├── rofi/
│       ├── rofi.nix
│       ├── waybar.nix
│       ├── yazi/
│       └── zsh.nix
├── README.md
└── scripts
    ├── apply-system.sh
    ├── apply-users.sh
    ├── update-system.sh
    └── update-user.sh
```

## Structure

- **hosts/** – machine-specific NixOS configurations  
- **home/** – Home Manager user configuration  
- **modules/** – shared configuration (in progress)  
- **flake.nix** – entry point for building systems 

---

### Hosts

Each host defines:
- hardware configuration
- system-specific settings
- imported shared modules

### Modules

Reusable configs for:
- desktop environments
- programs
- services
- shared system logic

### Home

User-level configuration managed via Home Manager.

---

## Machines

| Host          | Purpose                          |
|---------------|----------------------------------|
| ankylosaurus  | Gaming desktop                   |
| spinosaurus   | University / development laptop  |
| uniraptor     | University / development desktop |


---

## Features

- NixOS with flake-based configuration  
- Home Manager integration  
- Multi-host setup  
- Wayland environment (Hyprland)  
- Waybar, Rofi, Kitty, Mako  
- Delelopment + gaming environments

---

## Caveats

- Not plug-and-play
- Hardware-specific configs exist
- Some modules are still experimental

---

## Installation

Requirements:
- NixOs with flakes enabled in ` configuration.nix ` [nix.settings.experimental-features = ["nix-command" "flakes"];]
- Git
- Internet connection

Clone the repository:

```bash
git clone git@github.com:milisaur/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/
```

Usage:

- Change hostname in ` configuration.nix` + `flake.nix`
- Adjust hardware config per machine
- Modify modules in `modules/`

Rebuild system:

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

---

## Workflow 

```bash
git pull
# make changes
git add .
git commit -m "message"
git push

sudo nixos-rebuild switch --flake .#<hostname>
```

---

## Notes

- hardware-configuration.nix is specific to each machine
- This setup is tailored to my hardware and may require adjustments on other systems
- Shared modules are gradually being introduced

---

## License

This repository is provided as-is for personal use and reference.
