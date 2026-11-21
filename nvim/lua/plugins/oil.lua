-- File explorer that edits the filesystem like a buffer
return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open Oil (parent dir)" },
    { "<leader>E", "<CMD>Oil --float<CR>", desc = "Open Oil (floating)" },
  },
  opts = {
    default_file_explorer = true,
    restore_win_options = true,
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
      ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      ["q"] = "actions.close",
    },
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name)
        return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name)
        return name == ".." or name == ".git"
      end,
      natural_order = true,
      case_insensitive = false,
      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },
    float = {
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
      win_options = { winblend = 0 },
      preview_split = "auto",
    },
    preview_win = {
      update_on_cursor_moved = true,
    },
    confirmation = {
      border = "rounded",
      win_options = { winblend = 0 },
    },
    progress = {
      border = "rounded",
      minimized_border = "none",
      win_options = { winblend = 0 },
    },
    ssh = { border = "rounded" },
  },
  config = function(_, opts)
    require("oil").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.colorcolumn = ""
        vim.opt_local.signcolumn = "no"
      end,
    })
  end,
}
