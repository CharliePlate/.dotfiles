local DapProjects = require("config.dap.configured_projects")

local M = {}

M.load_dap_config = function(configurations)
  local dap = require("dap")
  for _, config in ipairs(configurations) do
    local filetypes = { config.lang }
    config.lang = nil
    for _, filetype in pairs(filetypes) do
      local dap_configurations = dap.configurations[filetype] or {}
      for i, dap_config in pairs(dap_configurations) do
        if dap_config.name == config.name then
          table.remove(dap_configurations, i)
        end
      end
      table.insert(dap_configurations, config)
      dap.configurations[filetype] = dap_configurations
    end
  end
end

M.root_is_configured = function()
  return DapProjects[vim.fn.getcwd()] ~= nil
end

M.load_if_configured = function()
  if M.root_is_configured() then
    M.load_dap_config(DapProjects[vim.fn.getcwd()])
  end
end

return M
