#!/bin/sh
#pacman -Syy;
pacman -Qu > ~/.local/share/pacman-updates;
#alacritty -e cat ~/.local/share/pacman-updates
