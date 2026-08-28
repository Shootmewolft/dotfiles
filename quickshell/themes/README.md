# Quickshell themes

Themes here are **hand-authored**. Nothing generates them, and nothing overwrites them.

The active theme is whichever file
`~/.local/state/quickshell/user/generated/colors.json` symlinks to. The shell
watches that path (`services/MaterialThemeLoader.qml`, `FileView.watchChanges`),
so switching is a symlink swap plus a `touch` — no restart:

```sh
ln -sfn ~/dev/config/dotfiles/quickshell/themes/<name>.colors.json \
        ~/.local/state/quickshell/user/generated/colors.json
touch ~/dev/config/dotfiles/quickshell/themes/<name>.colors.json
```

## Themes

| Name | File | Look |
|---|---|---|
| Kanagawa Blur | `kanagawa-blur.colors.json` | True neutral dark — `#121212` base, grey ladder, white text. No hue on any surface |

## Apps wired to this palette

| App | Mechanism | File |
|---|---|---|
| quickshell bar / sidebars | `colors.json` symlink | `quickshell/themes/kanagawa-blur.colors.json` |
| Hyprland borders | hand-authored lua | `hypr/hyprland/colors.lua` |
| kitty / foot / ghostty | `background` only | their own configs |
| Zed | background-only `theme_overrides` | `~/.config/zed/settings.json` |
| zellij / wofi / fuzzel / hyprlock | `background` only | their own configs |
| btop | btop theme file | `btop/themes/kanagawa-blur.theme` + `btop.conf` |
| Nautilus and GTK4 apps | libadwaita `@define-color` | `gtk-4.0/gtk.css` |
| GTK3 apps (adw-gtk3-dark) | `@define-color` | `gtk-3.0/gtk.css` |
| Brave | unpacked theme extension | `brave/kanagawa-blur-theme/` |

btop deliberately uses the **chromatic** Kanagawa Wave palette rather than the
neutral greys: it lives in the terminal and its gauges need real hues to stay
readable. Everything outside the terminal uses the neutral set.

Brave needs a manual step:

- **Brave** — `brave://extensions`, enable Developer mode, *Load unpacked*,
  point it at `brave/kanagawa-blur-theme/`. Chromium has no user-CSS hook for
  its own UI, so a theme extension is the only complete route.

Note that `gtk-3.0/gtk.css` and `gtk-4.0/gtk.css` are also matugen output
targets. They survive for the same reason everything else does: adaptive
theming is off.

## Adaptive theming is off — keep it that way

Three switches had to be off for hand-authored themes to survive. All live in
`illogical-impulse/config.json`:

- `appearance.wallpaperTheming.enableAppsAndShell: false` — the big one.
  `scripts/colors/switchwall.sh:290` returns early on it, so **matugen never
  runs**. Turning it on overwrites `colors.json`, `hypr/hyprland/colors.lua`,
  `hypr/hyprlock/colors.conf`, `gtk-3.0/gtk.css`, `gtk-4.0/gtk.css` and
  `fuzzel/fuzzel_theme.ini` from the wallpaper.
- `appearance.wallpaperTheming.enableTerminal: false` — keeps `applycolor.sh`
  off the terminal palettes.
- `appearance.transparency.automatic: false` — with this on, opacity is derived
  from the wallpaper's colourfulness at runtime (`modules/common/Appearance.qml:19-32`),
  so the theme changes when the wallpaper does. The frozen values below are the
  ones that mode was producing, so turning it off changed nothing visually.

## Two constraints any new theme must satisfy

### 1. The surface ladder must share the background's colour bias

Inner blocks are not painted with the colour you write. `Appearance.qml:122`
paints them at 10% alpha and solves for the overlay
(`functions/ColorUtils.qml:163`):

```
overlay_channel = (target − base × 0.9) / 0.1     clamped to [0,1]
```

`0.1` is `1 − contentTransparency`, and `contentTransparency` is `0.9`. That
leaves a narrow window — **per channel**:

```
0.9 × base  ≤  target  ≤  0.9 × base + 25.5        (0–255)
```

Miss the floor and the channel clamps to 0, staining every card with the
complementary hue. A neutral grey ladder over a blue-tinted background clamps
blue and turns the sidebars olive.

So `background` and the whole `surface_container_*` ladder must carry the *same*
bias and climb in steps of about 8. The current theme sidesteps this entirely by
being fully neutral (R=G=B everywhere), which is the safest place to be. The chain is
`colLayer1 = surface_container_low`, `colLayer2 = surface_container`,
`colLayer3 = surface_container_high`, `colLayer4 = surface_container_highest`.

Verify before applying — the auditor replicates the shell's own arithmetic:

```sh
python3 check_layers.py themes/<name>.colors.json "<name>"
```

### 2. Panel alpha must clear the blur threshold

Hyprland skips blur below `ignore_alpha`. Panel alpha is
`1 − backgroundTransparency` = `0.81`. The upstream threshold is `0.79`
(`hypr/hyprland/rules.lua:134`) — two hundredths of margin — so
`hypr/custom/rules.lua` widens it to `0.6`. Raise `backgroundTransparency` past
`0.4` and the sidebars go flat again.

## Roles worth knowing

| Role | Where it shows |
|---|---|
| `primary` | active workspace pill (`bar/Workspaces.qml:303`) **and** toggled quick-toggle background (`sidebarRight/quickToggles/androidStyle/AndroidQuickToggleButton.qml:63`) — these two are coupled |
| `secondary_container` | the shadow behind occupied workspaces (`bar/Workspaces.qml:99`), at 40% transparency — needs ~28% lightness or it vanishes |
| `outline` | subtext throughout |
| `on_surface` / `on_surface_variant` | body text — kept warm to match the terminal |

Fill roles are neutral grey; text roles are warm. A warm off-white reads as
white in text but as beige across a large fill.

## Terminals: background only

The terminals share the `#0E0E0E` base but keep their **Kanagawa ANSI palette
untouched**. Colour carries information there - syntax highlighting, `git diff`,
`ls` categories - so greying colours 1-15 would trade readability for
consistency. Only `background` changed; `foreground` stays `#DCD7BA`.

Same principle as the shell, where `error`, `success` and `warning` stayed
chromatic while every surface went neutral: hue only where it means something.

## Opacity is not the background colour

The shell and the terminals both paint `#0E0E0E`, but what reaches the screen is
`opacity x base + (1 - opacity) x blurred backdrop`. Over a light patch of
wallpaper, `#0E0E0E` at `0.75` renders around `#191919` - visibly lighter than
the value in the config. Raising opacity is what darkens it; editing the hex is
not.

Measured, same window, empty area:

| opacity | renders as |
|---|---|
| `0.75` | `#191919` / `#171717` |
| `0.85` | `#141515` / `#141414` |

Current: kitty, foot and Zed at `0.85`; shell panels at `0.75`
(`appearance.transparency.backgroundTransparency = 0.25`). They differ on
purpose - the editing surfaces were asked to sit darker than the shell. Note
that `backgroundTransparency` above `0.4` kills the sidebar blur through
`ignore_alpha`.

Zed carries opacity inside the colour, as the last two hex digits: `0.85` is
`D9`. Its `background` is `#0E0E0ED9`. The seven keys the theme leaves at
`#00000000` must stay untouched - that transparency is what the compositor
blurs.
