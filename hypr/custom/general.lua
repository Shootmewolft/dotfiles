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

-- Hyprland 0.57 caps shadow render_power at 4 (base config used 10).
hl.config({
    decoration = {
        shadow = {
            render_power = 4,
        },
    },
})

-- Hyprland 0.57 hands a maximized window's state to any newly opened tiled
-- window on the same workspace, regardless of misc.on_focus_under_fullscreen.
-- Undo a maximize that lands on a window within ~1s of it opening, so new
-- windows always tile. Manual maximize (SUPER+D) later is unaffected.
local fresh_windows = {}
hl.on("window.open", function(w)
    fresh_windows[w.address] = os.time()
end)
hl.on("window.fullscreen", function(w)
    local opened_at = fresh_windows[w.address]
    if not opened_at then return end
    fresh_windows[w.address] = nil
    if os.time() - opened_at <= 1 and w.fullscreen == 1 and not w.floating then
        hl.dispatch(hl.dsp.window.fullscreen({
            mode = "maximized", action = "unset", window = "address:" .. w.address,
        }))
    end
end)
hl.on("window.close", function(w)
    fresh_windows[w.address] = nil
end)
