#!/usr/bin/env bash
# Clears any kitty-rendered image left over from the previous preview.
if [ -n "$KITTY_WINDOW_ID" ] && command -v kitty >/dev/null 2>&1; then
    kitty +kitten icat --clear --transfer-mode=memory --stdin=no --silent < /dev/tty > /dev/tty
fi
