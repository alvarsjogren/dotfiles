# Dotfiles

Hyprland desktop environment configuration for Arch Linux.

## Overview

| Package | Description |
|---------|-------------|
| **hypr** | Hyprland window manager — dwindle layout, per-host GPU/monitor config (see below) |
| **waybar** | Status bar — workspaces, clock, CPU, memory, network, battery, audio, tray |
| **wofi** | Application launcher |
| **mako** | Notification daemon |
| **kitty** | Terminal emulator |
| **starship** | Shell prompt — git status, language versions |
| **gtk** | GTK3/GTK4 color overrides (themes Nemo + GTK apps) |
| **qt** | Qt theming via qt5ct (Fusion + custom palette) |
| **yazi** | Terminal file manager (Super+Y) — image previews in kitty |
| **fastfetch** | System info splash |
| **wallpapers** | Desktop wallpapers (awww) |

File managers: **yazi** (terminal, primary) and **nemo** (GUI, `Super+E`).

All configs use the **Wallhaven Polllj** color scheme with **JetBrainsMono Nerd Font**.

## Dependencies

```
hyprland waybar wofi mako kitty starship awww grim slurp wl-copy
brightnessctl networkmanager nm-applet polkit-kde-agent
papirus-icon-theme ttf-jetbrains-mono-nerd stow fastfetch
nemo yazi ffmpegthumbnailer poppler fd fzf zoxide jq imagemagick
qt5ct kvantum                       # Qt theming
bibata-cursor-theme                 # AUR — cursor theme
```

## Installation

```bash
git clone git@github.com:alvarsjogren/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr waybar wofi mako kitty starship gtk qt yazi fastfetch wallpapers -t ~
```

### Per-host hypr config (laptop vs PC)

GPU env vars and monitor layout differ between machines (PC: NVIDIA, dual monitor; laptop:
Intel iGPU, single `eDP-1`). `hyprland.conf` sources a local, gitignored `host.conf` symlink
so both machines share one `main` branch instead of diverging into separate branches:

```
hypr/.config/hypr/hosts/pc.conf       # tracked — NVIDIA, dual monitor
hypr/.config/hypr/hosts/laptop.conf   # tracked — Intel iGPU, eDP-1
hypr/.config/hypr/host.conf           # gitignored symlink -> one of the above, made once per machine
```

One-time setup on a new machine, after stowing `hypr`:

```bash
cd ~/.config/hypr
ln -sf hosts/laptop.conf host.conf   # or hosts/pc.conf
```

## Uninstalling a package

```bash
cd ~/dotfiles
stow -D <package>   # e.g. stow -D waybar
```
