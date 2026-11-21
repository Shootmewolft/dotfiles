return {
  -- Render markdown (headings, tables, checkboxes) inside the buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        enabled = true,
        sign = true,
        style = "full",
        icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
        left_pad = 1,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
        checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
    },
  },

  -- Work with the Obsidian vault from Neovim
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cmd = "Obsidian",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      legacy_commands = false,
      workspaces = {
        { name = "notes", path = "~/Documents/notes" },
      },
      picker = { name = "snacks.picker" },
      templates = {
        folder = "templates",
        date_format = "YYYY-MM-DD",
        time_format = "HH:mm",
      },
      -- The vault manages its own frontmatter (Templater), don't rewrite it
      frontmatter = { enabled = false },
    },
  },
}
