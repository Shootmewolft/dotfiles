-- Kanagawa Wave with a transparent background, so kitty's opacity (0.85) and
-- Hyprland's blur show through. Matches the "Kanagawa Wave Blur" look used in
-- kitty and Zed. Inspired by Gentleman-Programming/gentleman-kanagawa-blur.
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      theme = "wave",
      background = { dark = "wave", light = "lotus" },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
              bg_sidebar = "none",
              bg_float = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          LineNr = { bg = "none" },
          CursorLineNr = { bg = "none" },
          SignColumn = { bg = "none" },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          -- Completion menu keeps a solid background so it stays readable
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },

  -- Alternative themes to switch with :colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
    },
  },
  {
    "Alan-TheGentleman/oldworld.nvim",
    lazy = true,
    opts = {},
  },

  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "kanagawa" },
  },
}
