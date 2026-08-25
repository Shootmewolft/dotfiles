#!/usr/bin/env bash
# File previewer for lf.
# Args (per lf's `previewer` spec): file, width, height, x, y, mode
file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

mime="$(file --mime-type -Lb -- "$file" 2>/dev/null)"

case "$mime" in
    image/*)
        if [ -n "$KITTY_WINDOW_ID" ] && command -v kitty >/dev/null 2>&1; then
            kitty +kitten icat --clear --transfer-mode=memory --stdin=no \
                --place="${w}x${h}@${x}x${y}" -- "$file" < /dev/tty > /dev/tty
            exit 1
        elif command -v chafa >/dev/null 2>&1; then
            chafa --size="${w}x${h}" --format=symbols -- "$file"
        else
            echo "Image preview needs 'chafa' (or kitty). Install: sudo pacman -S chafa"
        fi
        ;;
    *)
        if command -v bat >/dev/null 2>&1; then
            bat --color=always --style=plain --paging=never -- "$file"
        else
            cat -- "$file"
        fi
        ;;
esac
