#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

rm ~/.config/polybar/Shadybar/config
files=(~/.config/polybar/Shadybar/Shadyconfigs/*)

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

echo "[color]" >> ~/.config/polybar/Shadybar/config
cat "${files[RANDOM % ${#files[@]}]}" >> ~/.config/polybar/Shadybar/config
cat ~/.config/polybar/Shadybar/modules >> ~/.config/polybar/Shadybar/config
# Launch polybar
polybar main -c ~/.config/polybar/Shadybar/config &









