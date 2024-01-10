local M = setmetatable({}, {
  __call = function(m) end,
})

local function getRelativePath()
  local path = vim.fn.expand("%:p")
  return vim.fn.fnamemodify(path, ":.")
end

local icons = require("util.icons")

return {
  lualine_a = { "mode" },
  lualine_b = { "branch" },
  lualine_c = {
    -- {
    --   function()
    --     return require("arrow.statusline").text_for_statusline_with_icons()
    --   end,
    --   cond = function()
    --     return require("arrow.statusline").is_on_arrow_file()
    --   end,
    -- },

    getRelativePath,
  },
  lualine_x = {
    -- stylua: ignore
    {
      function() return require("noice").api.status.command.get() end,
      cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
    },
    -- stylua: ignore
    {
      function() return require("noice").api.status.mode.get() end,
      cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
    },
    -- stylua: ignore
    {
      function() return "  " .. require("dap").status() end,
      cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
    },
    {
      "diff",
      symbols = {
        added = icons.git.added,
        modified = icons.git.modified,
        removed = icons.git.removed,
      },
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    },
  },
  lualine_y = {
    { "progress", separator = " ", padding = { left = 1, right = 0 } },
    { "location", padding = { left = 0, right = 1 } },
  },
  lualine_z = {
    function()
      return " " .. os.date("%R")
    end,
  },
}
