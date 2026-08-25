# SDDM — Kanagawa Wave Blur

The SDDM login screen (what you see on boot, *before* your Hyprland session
starts) is a completely separate thing from hyprlock (which only locks an
already-running session). This folder holds the config for
`sddm-astronaut-theme` (already installed at
`/usr/share/sddm/themes/sddm-astronaut-theme`, a manual git checkout — not a
pacman package, so it's safe to edit in place, nothing will silently
overwrite it on a system update).

These files live under `/usr/share` and `/etc`, which need root, so this
folder is a plain snapshot (like `zed/icon-theme-overrides/`) — not a
symlink. Run `install.sh` once as yourself (it calls `sudo` internally where
needed) to apply it.

## What it does

1. Installs IosevkaTerm Nerd Font **system-wide** (`/usr/share/fonts`) — the
   font is currently only in `~/.local/share/fonts`, which SDDM's own user
   (`sddm`, home `/var/lib/sddm`) can't see. Without this the greeter falls
   back to a generic font.
2. Copies the same color-graded Great Wave off Kanagawa background used for
   hyprlock into the theme's `Backgrounds/` folder.
3. Copies `matugen.conf` (this folder) over the theme's active config at
   `Themes/matugen.conf` — same palette, blur, and Spanish text as hyprlock.
4. Switches `/etc/sddm.conf`'s `Current=` from `silent` to
   `sddm-astronaut-theme`.

## Preview safely before switching

Steps 1-3 are harmless on their own. Before running step 4 (or even before
running the script at all), you can preview the greeter in a window without
touching your real session:

    sddm-greeter --test-mode --theme /usr/share/sddm/themes/sddm-astronaut-theme

## Reapplying

If you ever re-clone/update `sddm-astronaut-theme` (`git pull` +
`setup.sh`), it may reset `Themes/matugen.conf`. Just rerun `install.sh`.
