-- Convert an HSL color (h: 0-360, s/l: 0-100) to "#rrggbb".
-- Adapted from Gentleman-Programming/Gentleman.Dots (Apache-2.0).
local function hsl_to_hex(h, s, l)
  h, s, l = h / 360, s / 100, l / 100
  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local function hue_to_rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb(p, q, h + 1 / 3)
    g = hue_to_rgb(p, q, h)
    b = hue_to_rgb(p, q, h - 1 / 3)
  end
  return string.format("#%02x%02x%02x", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

return {
  -- Preview definitions/references in floating windows
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true,
    keys = {
      { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition" },
      { "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "Preview declaration" },
      { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview implementation" },
      { "gpy", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type definition" },
      { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview references" },
      { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close preview windows" },
    },
  },

  -- Also highlight hsl(...) colors (hex colors come from the LazyVim extra)
  {
    "nvim-mini/mini.hipatterns",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local h, s, l = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            return MiniHipatterns.compute_hex_color_group(hsl_to_hex(tonumber(h), tonumber(s), tonumber(l)), "bg")
          end,
        },
      },
    },
  },

  -- Interactive search & replace with live preview
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = "Rip substitute",
      },
    },
  },

  -- Multiple cursors (Ctrl+N to select next match)
  { "terryma/vim-multiple-cursors" },

  { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },

  -- Hide secret values in .env and config files
  {
    "Gentleman-Programming/veil.nvim",
    config = function()
      require("veil").setup()
    end,
  },

  -- Vim motion training games (:VimBeGood)
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
