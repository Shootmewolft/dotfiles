#!/usr/bin/env bash
# Prints battery percentage + charging state for the lock screen status label.
BAT="/sys/class/power_supply/BAT0"

if [ -d "$BAT" ]; then
    capacity=$(cat "$BAT/capacity" 2>/dev/null)
    status=$(cat "$BAT/status" 2>/dev/null)
    case "$status" in
        Charging) icon="󰂄" ;;
        Full) icon="󰁹" ;;
        *)
            if [ "$capacity" -le 15 ]; then icon="󰁺"
            elif [ "$capacity" -le 50 ]; then icon="󰁽"
            else icon="󰁹"
            fi
            ;;
    esac
    echo "$icon  ${capacity}%"
fi
