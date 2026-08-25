hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Shell: Edit user keybinds"} )

-- Keyboard window resize (SUPER+ALT+arrows)
hl.bind("SUPER + ALT + Left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
    { repeating = true, description = "Window: Resize narrower" })
hl.bind("SUPER + ALT + Right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }),
    { repeating = true, description = "Window: Resize wider" })
hl.bind("SUPER + ALT + Up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
    { repeating = true, description = "Window: Resize shorter" })
hl.bind("SUPER + ALT + Down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }),
    { repeating = true, description = "Window: Resize taller" })

-- Toggle split orientation between vertical/horizontal (dwindle layout)
hl.bind("SUPER + ALT + T", hl.dsp.layout("togglesplit"),
    { description = "Window: Toggle split orientation" })
