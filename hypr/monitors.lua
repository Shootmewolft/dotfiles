-- Explicit monitor setup, carried over from the previous hand-rolled hyprland.conf.
-- Overrides the generic wildcard rule in hyprland/general.lua for these two outputs.
-- Physical layout (confirmed by user): HDMI-A-1 is the left anchor, laptop (eDP-1)
-- sits physically to its right — declared in this order so "auto-right" resolves
-- against an already-placed HDMI-A-1. HDMI-A-1 is still the default workspace-1
-- monitor (main/primary), set below, independent of this left-to-right arrangement.
hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "0x0",
    scale = 1
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto-right",
    scale = 1.33
})

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })
