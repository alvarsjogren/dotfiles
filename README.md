# Dotfiles

Hyprland desktop environment configuration for Arch Linux.

## Overview

| Package | Description |
|---------|-------------|
| **hypr** | Hyprland window manager — dwindle layout, NVIDIA 40-series, dual monitor (DP-1 144Hz + HDMI-A-1 60Hz) |
| **waybar** | Status bar — workspaces, clock, CPU, memory, network, audio, tray |
| **wofi** | Application launcher |
| **mako** | Notification daemon |
| **kitty** | Terminal emulator |
| **starship** | Shell prompt — git status, language versions |
| **wallpapers** | Desktop wallpapers (swww) |

All configs use the **Night Owl** color scheme with **JetBrainsMono Nerd Font**.

## Dependencies

```
hyprland waybar wofi mako kitty starship swww grim slurp wl-copy
brightnessctl networkmanager nm-applet polkit-kde-agent
papirus-icon-theme ttf-jetbrains-mono-nerd stow
```

## Installation

```bash
git clone git@github.com:alvarsjogren/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr waybar wofi mako kitty starship wallpapers -t ~
```

## Uninstalling a package

```bash
cd ~/dotfiles
stow -D <package>   # e.g. stow -D waybar
```
