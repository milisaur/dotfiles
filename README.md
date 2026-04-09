# Personal NixOS configuration using **flakes** with **Home Manager**, built for a multi-machine setup.

---

## Overview

This repository contains my system and user configuration for multiple NixOS machines.  
It separates host-specific configuration from shared components while keeping the setup simple and maintainable.

---

## Structure
```text

├── flake.nix
├── flake.lock
├── hosts/
│   ├── ankylosaurus/
│   │     ├── configuration.nix
│   │     └── hardware-configuration.nix
│   ├── spinosaurus/
│   │     └── ...
├── home/
│   └── mili/
│       └── home.nix
├── modules/
│   └── home/
│       ├── hyprland/
│       ├── rofi/
│       ├── dev.nix
│       ├── gaming.nix
│       ├── r.nix
│       ├── nvim.nix
│       ├── kitty.nix
│       ├── waybar.nix
│       ├── mako.nix
│       ├── zsh.nix
│       └── ...
│   └── common.nix
```

## Structure

- **hosts/** – machine-specific NixOS configurations  
- **home/** – Home Manager user configuration  
- **modules/** – shared configuration (in progress)  
- **flake.nix** – entry point for building systems  

---

## Hosts

| Host          | Description                                      |
|---------------|--------------------------------------------------|
| ankylosaurus  | gaming desktop                                   |
| spinosaurus   | university/dev laptop (with some gaming features)|

---

## Features

- NixOS with flake-based configuration  
- Home Manager integration  
- Multi-host setup  
- Wayland environment (Hyprland)  
- Waybar, Rofi, Kitty, Mako  

---

## Installation

Clone the repository:

git clone git@github.com:milisaur/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/

Usage:

Rebuild system
sudo nixos-rebuild switch --flake .#<hostname>

---

## Workflow 

git pull
# make changes
git add .
git commit -m "message"
git push

sudo nixos-rebuild switch --flake .#<hostname>

---

## Notes

- hardware-configuration.nix is specific to each machine
- This setup is tailored to my hardware and may require adjustments on other systems
- Shared modules are gradually being introduced

---

## License

This repository is provided as-is for personal use and reference.
