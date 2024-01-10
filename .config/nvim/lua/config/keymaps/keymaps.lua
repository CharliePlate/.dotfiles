local Keys = require("util.keys")

---@type LazyKeysSpec[]
local scroll_recenter = {
  { "<c-f>", "<c-f>zz", desc = "Full Page Scroll Down" },
  { "<c-d>", "<c-d>zz", desc = "Half Page Scroll Down" },
  { "<c-b>", "<c-b>zz", desc = "Full Page Scroll Up" },
  { "G", "Gzz", desc = "Scroll to Bottom" },
  { "<c-u>", "<c-u>zz", desc = "Half Page Scroll Up" },
}

---@type LazyKeysSpec[]
-- local window_nav = {
--   { "<c-h>", "<c-w>h", desc = "Window Left" },
--   { "<c-j>", "<c-w>j", desc = "Window Down" },
--   { "<c-k>", "<c-w>k", desc = "Window Up" },
--   { "<c-l>", "<c-w>l", desc = "Window Right" },
-- }

---@type LazyKeysSpec[]
local move_code = {
  { "<", "<gv", mode = "v", desc = "Indent Left" },
  { ">", ">gv", mode = "v", desc = "Indent Right" },
  { "J", ":m '>+1<CR>gv=gv", mode = "v", desc = "Move Line Down" },
  { "K", ":m '<-2<CR>gv=gv", mode = "v", desc = "Move Line Up" },
}

---@type LazyKeysSpec[]
local fix_terminal_modifiers = {
  { "<S-BS>", "<BS>", mode = "t", desc = "Terminal Backspace" },
  { "<C-BS>", "<BS>", mode = "t", desc = "Terminal Backspace" },
  { "<M-S-BS>", "<BS>", mode = "t", desc = "Terminal Backspace" },
  { "<M-C-BS>", "<BS>", mode = "t", desc = "Terminal Backspace" },
  { "<C-S-BS>", "<BS>", mode = "t", desc = "Terminal Backspace" },
  { "<S-space>", "<space>", mode = "t", desc = "Terminal Space" },
  { "<C-space>", "<space>", mode = "t", desc = "Terminal Space" },
  { "<M-S-space>", "<space>", mode = "t", desc = "Terminal Space" },
  { "<M-C-space>", "<space>", mode = "t", desc = "Terminal Space" },
  { "<C-S-space>", "<space>", mode = "t", desc = "Terminal Space" },
}

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local diagnostic = {
  { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
  { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
  { "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
  { "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
  { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
  { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
}

Keys.addKey({ "<esc>", ":noh<cr>", desc = "Clear Search Highlight" })
Keys.addKey({ "jk", "<c-o>a", mode = "i", desc = "Move one character right" })
Keys.addKey({ "<leader>lr", ":IncRename ", desc = "Incremental Rename" })
--Keys.addKeys(window_nav)
Keys.addKeys(scroll_recenter)
Keys.addKeys(move_code)
Keys.addKeys(diagnostic)
Keys.addKeys(fix_terminal_modifiers)
Keys.set()
