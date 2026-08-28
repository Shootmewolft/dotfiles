-- The base config disables blur for every normal window (only the shell's own
-- panels get blur). Re-enable it specifically for the terminals so the
-- transparency set in kitty.conf/foot.ini actually shows the blur effect.
hl.window_rule({ match = { class = "^(kitty|foot)$" }, no_blur = false })

-- Zed's Kanagawa Wave Blur theme sets a transparent background; without this
-- it's just see-through with no actual blur behind it.
hl.window_rule({ match = { class = "^(dev.zed.Zed)$" }, no_blur = false })

-- The base config sets ignore_alpha = 0.79 for every quickshell layer
-- (hyprland/rules.lua:134), which tells Hyprland to skip blur below that alpha.
-- With backgroundTransparency = 0.19 the panels sit at alpha 0.81 — only 0.02 of
-- margin, so a small transparency tweak would silently kill the blur on every
-- sidebar and popover. Widen the margin; this file loads after the base rules.
hl.layer_rule({ match = { namespace = "quickshell:.*" }, ignore_alpha = 0.6 })
