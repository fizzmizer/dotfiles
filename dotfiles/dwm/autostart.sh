#!/bin/bash

#wal -i ~/Pictures/Comics\ and\ wallpapers/wallpapers/ &
feh --bg-fill --randomize  ~/Pictures/Comics\ and\ wallpapers/wallpapers/*
xmodmap ~/dotfiles/xmodmap &
picom -f --config ~/.config/picom.conf &
dwmblocks &
nextcloud --background &
#dropbox &
