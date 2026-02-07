#!/bin/sh
if hyprctl clients -j | grep -q "kitty-dropdown"; then
    hyprctl dispatch togglespecialworkspace dropdown
else
    kitty --class kitty-dropdown &
    while ! hyprctl clients -j | grep -q "kitty-dropdown"; do
        sleep 0.05
    done
    hyprctl dispatch togglespecialworkspace dropdown
fi
