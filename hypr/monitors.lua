-- Explicit monitor setup, carried over from the previous hand-rolled hyprland.conf.
-- Overrides the generic wildcard rule in hyprland/general.lua for these two outputs.
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = 1.33
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = "auto"
})
