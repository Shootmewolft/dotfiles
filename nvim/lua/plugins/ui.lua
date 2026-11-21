-- Short mode names for the oil statusline
local short_mode = {
  "mode",
  fmt = function(s)
    local mode_map = {
      ["NORMAL"] = "N",
      ["O-PENDING"] = "N?",
      ["INSERT"] = "I",
      ["VISUAL"] = "V",
      ["V-BLOCK"] = "VB",
      ["V-LINE"] = "VL",
      ["V-REPLACE"] = "VR",
      ["REPLACE"] = "R",
      ["COMMAND"] = "!",
      ["SHELL"] = "SH",
      ["TERMINAL"] = "T",
      ["EX"] = "X",
      ["S-BLOCK"] = "SB",
      ["S-LINE"] = "SL",
      ["SELECT"] = "S",
      ["CONFIRM"] = "Y?",
      ["MORE"] = "M",
    }
    return mode_map[s] or s
  end,
}

return {
  { "folke/todo-comments.nvim", version = "*" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      preset = "classic",
      win = { border = "single" },
      spec = {
        { "<leader>o", group = "obsidian" },
        { "<leader>a", group = "ai" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer keymaps (which-key)",
      },
    },
  },

  -- Side panel with the docs of the symbol under the cursor
  {
    "amrbashir/nvim-docs-view",
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_a = { { "mode", icon = "" } }
      opts.extensions = opts.extensions or {}
      table.insert(opts.extensions, {
        filetypes = { "oil" },
        sections = {
          lualine_a = { short_mode },
          lualine_b = {
            function()
              local ok, oil = pcall(require, "oil")
              if not ok then
                return ""
              end
              return vim.fn.fnamemodify(oil.get_current_dir() or "", ":~") .. " %m"
            end,
          },
        },
      })
    end,
  },

  -- Floating file name in the corner of each window
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        kitty = { enabled = false, font = "+2" },
        twilight = { enabled = true },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find Buffers",
      },
    },
    opts = {
      notifier = {},
      image = {},
      -- Only draw the indent guide of the current scope, not every level
      indent = {
        indent = { enabled = false },
        scope = { enabled = true },
      },
      picker = {
        exclude = { ".git", "node_modules" },
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          filename_bonus = true,
        },
      },
      dashboard = {
        preset = {
          header = [[
███████╗ ██╗  ██╗  ██████╗   ██████╗  ████████╗
██╔════╝ ██║  ██║ ██╔═══██╗ ██╔═══██╗ ╚══██╔══╝
███████╗ ███████║ ██║   ██║ ██║   ██║    ██║   
╚════██║ ██╔══██║ ██║   ██║ ██║   ██║    ██║   
███████║ ██║  ██║ ╚██████╔╝ ╚██████╔╝    ██║   
╚══════╝ ╚═╝  ╚═╝  ╚═════╝   ╚═════╝     ╚═╝   
]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },

  { "folke/twilight.nvim" },

  -- Shows the pressed keys on screen (<leader>uk)
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*",
  },

  -- Cursor trail animation
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
}
