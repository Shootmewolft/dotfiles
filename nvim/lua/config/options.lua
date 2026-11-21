-- Loaded before lazy.nvim startup.
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- (already sets: space leader, relative numbers, smartcase, undofile, splits, yank highlight)

local opt = vim.opt

opt.scrolloff = 8

-- LazyVim shows tabs as ">" (list = true). Draw tabs as blank space, keep the
-- trailing-space and non-breaking-space markers.
opt.listchars = { tab = "  ", trail = "-", nbsp = "+" }

-- Clipboard is NOT synced with the system on purpose (LazyVim defaults to "unnamedplus").
-- Use "+y / "+p for the system clipboard. Set to "unnamedplus" to sync it.
opt.clipboard = ""

-- Silence checkhealth warnings for providers that are not used
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
