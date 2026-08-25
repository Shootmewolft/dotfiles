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
