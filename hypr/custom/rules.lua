-- The base config disables blur for every normal window (only the shell's own
-- panels get blur). Re-enable it specifically for the terminals so the
-- transparency set in kitty.conf/foot.ini actually shows the blur effect.
hl.window_rule({ match = { class = "^(kitty|foot)$" }, no_blur = false })

-- Zed's Kanagawa Wave Blur theme sets a transparent background; without this
-- it's just see-through with no actual blur behind it.
hl.window_rule({ match = { class = "^(dev.zed.Zed)$" }, no_blur = false })
