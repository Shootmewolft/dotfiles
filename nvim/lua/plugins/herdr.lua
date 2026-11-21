-- herdr-splits.nvim: Neovim side of seamless navigation/resizing with Herdr panes.
-- Herdr side: the herdr-splits plugin + Ctrl+h/j/k/l and Alt+Shift+h/j/k/l
-- bindings in ~/.config/herdr/config.toml.
-- Keymaps live in lua/config/keymaps.lua (loaded after LazyVim's own keymaps).
-- Only loaded inside a Herdr pane.
return {
  "lmilojevicc/herdr-splits.nvim",
  cond = vim.env.HERDR_ENV == "1",
  event = "VeryLazy",
  opts = {
    -- Written to herdr-splits.conf so the Herdr-side scripts forward the same keys.
    nav_keys = { left = "<C-h>", down = "<C-j>", up = "<C-k>", right = "<C-l>" },
    -- Alt+Shift so LazyVim keeps Alt+j/k for moving lines.
    -- Explicit <M-S-x>: herdr-splits lowercases <M-H> into "alt+h" and drops Shift.
    resize_keys = { left = "<M-S-h>", down = "<M-S-j>", up = "<M-S-k>", right = "<M-S-l>" },
  },
}
