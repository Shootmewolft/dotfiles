-- Restores AltGr+vowel accent input (matches localectl's X11 Variant: altgr-intl)
-- Lower mouse sensitivity (range -1.0 to 1.0, 0 = no modification). Adjust to taste.
hl.config({
    input = {
        kb_variant = "altgr-intl",
        sensitivity = 0
    },
    binds = {
        workspace_back_and_forth = false
    }
})

-- Blur strength is global in Hyprland 0.56: there is no per-window rule for it,
-- only noblur on/off. Lowering it here softens the terminals and Zed, and the
-- bar and sidebars along with them. Base config sets size 10 / passes 3.
hl.config({
    decoration = {
        blur = {
            size = 7,
        },
    },
})
