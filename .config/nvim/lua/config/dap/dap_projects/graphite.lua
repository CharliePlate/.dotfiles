local configurations = {}

local ports = {
  ["Answers"] = 9230,
  ["Public API"] = 9201,
  ["Web API"] = 9229,
  ["Worker"] = 9231,
}

for name, port in pairs(ports) do
  table.insert(configurations, {
    lang = "typescript",
    type = "pwa-node",
    request = "attach",
    port = port,
    name = "Attach to " .. name,
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**", "!**/node_modules/**" },
    webRoot = "${workspaceFolder}/src",
    remoteRoot = "${workspaceFolder}/src",
  })

  table.insert(configurations, {
    lang = "jest",
    type = "pwa-node",
    request = "attach",
    port = port,
    name = "Attach to " .. name,
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js" },
    webRoot = "${workspaceFolder}/src",
    remoteRoot = "${workspaceFolder}/src",
  })
end

return configurations
