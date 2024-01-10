local M = {}

---@type LazyKeysSpec[]
M.Keys = {}

---@param key_spec LazyKeysSpec
M.addKey = function(key_spec)
  table.insert(M.Keys, key_spec)
end

---@param key_specs LazyKeysSpec[]
M.addKeys = function(key_specs)
  for _, key_spec in ipairs(key_specs) do
    M.addKey(key_spec)
  end
end

---@param key_specs LazyKeysSpec[]
M.addAndSet = function(key_specs)
  M.addKeys(key_specs)
  M.set()
end

---@param buf? number
M.set = function(buf)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = Keys.resolve(M.Keys)

  for _, k in pairs(keymaps) do
    local key = Keys.opts(k)
    ---@diagnostic disable
    key.has = nil
    key.silent = key.silent ~= false

    if buf then
      key.buffer = buf
    end

    vim.keymap.set(k.mode or "n", k.lhs, k.rhs, key)
  end
end

return M
