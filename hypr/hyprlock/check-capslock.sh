#!/usr/bin/env bash
# Prints a warning line when Caps Lock is active on any keyboard device.
caps=$(hyprctl devices -j | jq -r '[.keyboards[].capsLock] | any')
if [ "$caps" = "true" ]; then
    echo "⇪ Caps Lock is on"
fi
