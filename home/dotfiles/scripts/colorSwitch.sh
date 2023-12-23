#!/bin/bash

switch_nvim () {
    printf "updating nvim... "
    sed -i -e "s/color or \".*\"/color or \"$1\"/" ~/.config/nvim/after/plugin/colors.lua
    echo "done"
}

switch_bat () {
    printf "updating bat... "

    theme="$1"
    if [ "$1" = "catppuccin-latte" ]; then
        theme="Catppuccin-latte"
    fi
    if [ "$1" = "catppuccin-frappe" ]; then
        theme="Catppuccin-frappe"
    fi

    sed -i -e "s/--theme=".*"/--theme=\"$theme\"/" ~/.config/bat/config
    echo "done"
}

switch_iterm () {
    printf "updating iterm... "

    source ~/.dotfiles/scripts/.venv/bin/activate
    ~/.dotfiles/scripts/iterm2ColorSwitch.py "$1"
    deactivate

    echo "done"
}

update_all () {
    switch_nvim "$1"
    switch_bat "$1"
    switch_iterm "$1"
}

if [ "$1" = "catppuccin-latte" ]; then
    echo "switching theme to catppuccin-latte..."
    update_all "$1"
elif [ "$1" = "gruvbox" ]; then
    echo "switching theme to gruvbox..."
    update_all "$1"
elif [ "$1" = "catppuccin-frappe" ]; then
    echo "switching theme to catppuccin-frappe.."
    update_all "$1"
else
    echo "unknown theme"
fi

echo "done"
