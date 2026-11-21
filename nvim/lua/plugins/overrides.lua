return {
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Disable inlay hints (inline type annotations)
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
}
