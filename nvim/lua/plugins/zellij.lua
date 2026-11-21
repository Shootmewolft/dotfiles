-- Seamless Ctrl+h/j/k/l navigation between Neovim windows and Zellij panes.
-- Zellij side: vim-zellij-navigator in ~/.config/zellij/config.kdl.
-- Keymaps live in lua/config/keymaps.lua so they override LazyVim's window keymaps.
-- Outside Zellij it behaves like plain window navigation.
return {
  "swaits/zellij-nav.nvim",
  lazy = false,
  opts = {},
}
