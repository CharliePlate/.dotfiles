local Root = require("util.root")

local M = {}

M.lazygit_cmd = function()
  if not Root.tracked_by_yadm() then
    return "lazygit"
  else
    return "lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git"
  end
end

M.lazy_git_toggle = function()
  local height = math.ceil(vim.o.lines * 0.9) - 1
  local width = math.ceil(vim.o.columns * 0.9)

  local row = math.ceil(vim.o.lines - height) / 2
  local col = math.ceil(vim.o.columns - width) / 2
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = M.lazygit_cmd(),
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
      height = height,
      width = width,
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function()
      vim.cmd("startinsert!")
    end,
  })

  lazygit:toggle()
end

return M
