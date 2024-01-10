local M = {}

M.filter = function(tbl, condition)
  local filtered = {}
  for i, v in ipairs(tbl) do
    if condition(v, i) then
      table.insert(filtered, v)
    end
  end
  return filtered
end

M.isTableOfTables = function(t)
  -- Check if the table is empty
  if next(t) == nil then
    return false
  end

  -- Check if all keys are integers (array-style indexing)
  for key, value in pairs(t) do
    if type(key) ~= "number" then
      return false -- Not an array-style table
    end
    if type(value) ~= "table" then
      return false -- Not containing only tables
    end
  end
  return true
end

M.lspOnAttach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

M.opts = function(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

return M
