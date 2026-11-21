-- Loaded on the VeryLazy event.
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- Insert mode: delete to end of word
map("i", "<C-b>", "<C-o>de", { desc = "Delete to end of word" })

-- Ctrl+C behaves like Esc (triggers InsertLeave, unlike the default)
map({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]], { desc = "Back to normal mode" })

-- Window navigation that continues into the multiplexer at the edges:
-- Zellij panes (zellij-nav.nvim) or Herdr panes (herdr-splits.nvim).
-- Outside a multiplexer it is plain window navigation.
local in_herdr = vim.env.HERDR_ENV == "1"

local function navigate(wincmd, zellij_cmd, direction)
  return function()
    if vim.env.ZELLIJ then
      vim.cmd(zellij_cmd)
    elseif in_herdr then
      require("herdr-splits")["move_cursor_" .. direction]()
    else
      vim.cmd("wincmd " .. wincmd)
    end
  end
end

map("n", "<C-h>", navigate("h", "ZellijNavigateLeftTab", "left"), { desc = "Go to left window / pane" })
map("n", "<C-j>", navigate("j", "ZellijNavigateDown", "down"), { desc = "Go to lower window / pane" })
map("n", "<C-k>", navigate("k", "ZellijNavigateUp", "up"), { desc = "Go to upper window / pane" })
map("n", "<C-l>", navigate("l", "ZellijNavigateRightTab", "right"), { desc = "Go to right window / pane" })

-- Herdr: resize Neovim splits, and the Herdr pane when Neovim fills it
if in_herdr then
  for key, direction in pairs({ H = "left", J = "down", K = "up", L = "right" }) do
    map("n", "<M-" .. key .. ">", function()
      require("herdr-splits")["resize_" .. direction]()
    end, { desc = "Resize " .. direction .. " (window / Herdr pane)" })
  end
end

-- Screenkey
map("n", "<leader>uk", "<cmd>Screenkey<CR>", { desc = "Toggle Screenkey" })

-- Buffers: close every buffer except the current one
map("n", "<leader>bq", '<Esc>:%bdelete|edit #|normal`"<CR>', { desc = "Delete other buffers" })

-- Marks
map("n", "<leader>md", function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z0-9")
  vim.notify("All marks deleted")
end, { desc = "Delete all marks" })

-- Obsidian
map("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<CR>", { desc = "Toggle checkbox" })
map("n", "<leader>ot", "<cmd>Obsidian template<CR>", { desc = "Insert template" })
map("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open in Obsidian app" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks" })
map("n", "<leader>ol", "<cmd>Obsidian links<CR>", { desc = "Links" })
map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "New note" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search notes" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick switch" })

-- Grep the visual selection
local function selected_text()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  if #lines == 0 then
    return nil
  end
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end
  return vim.fn.escape(table.concat(lines, "\n"), "\\.*[]^$()+?{}")
end

local function grep_selection(cwd)
  -- leave visual mode so the '< and '> marks are updated
  vim.cmd([[execute "normal! \<Esc>"]])
  local text = selected_text()
  if text then
    Snacks.picker.grep({ search = text, cwd = cwd })
  end
end

map("v", "<leader>sg", function()
  grep_selection(nil)
end, { desc = "Grep selected text" })

map("v", "<leader>sG", function()
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  local root = vim.v.shell_error == 0 and git_root ~= "" and git_root or vim.fn.getcwd()
  grep_selection(root)
end, { desc = "Grep selected text (git root)" })
