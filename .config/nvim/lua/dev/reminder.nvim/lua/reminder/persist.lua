local a = require("plenary.async")

---@param completed_at number
---@return number
local function get_time_offset(completed_at)
  local now = os.time()

  return completed_at - now
end

local function is_expired(completed_at)
  local now = os.time()

  if now > completed_at then
    return true
  end

  return false
end

local function is_deleted(timer_name)
  if not vim.g.active_reminders[timer_name] then
    return true
  end

  return false
end

---@class ReminderPersist
---@field parsed table<string, number>
---@field expired_timers string[]
---@field timer_specs ReminderTimerSpec[]
---@field config ReminderConfig
local Persist = {}

---@param config ReminderConfig
---@return ReminderPersist
function Persist:new(config)
  local persist = setmetatable({
    config = config,
    parsed = {},
    expired = {},
  }, self)

  self.__index = self

  return persist
end

function Persist:get_file(path)
  a.void(function()
    local fd = self:open_or_create(path)
    local fd = path

    local err, stat = a.uv.fs_fstat(fd)
    assert(not err, err)

    ---@diagnostic disable-next-line: redefined-local
    local err, data = a.uv.fs_read(fd, stat.size, 0)
    assert(not err, err)

    ---@diagnostic disable-next-line: redefined-local
    local err = a.uv.fs_close(fd)
    assert(not err, err)

    ---@diagnostic disable-next-line: assign-type-mismatch
    self.parsed = vim.fn.json_decode(data)
  end)()
end

---@param path string
---@return number
function Persist:open_or_create(path)
  local err, fd = a.uv.fs_open(path, "r", 438)
  if err then
    print("here")
    err, fd = a.uv.fs_open(path, "w", 438)
    assert(not err, err)
    return fd
  end
  return fd
end

---@param reminder_name string
function Persist:is_deleted(reminder_name)
  if not self.parsed[reminder_name] then
    return true
  end

  return false
end

---@return ReminderTimerSpec[]
function Persist:make_active_timer_specs()
  ---@type ReminderTimerSpec[]
  local specs = {}
  for key, val in pairs(self.parsed) do
    if is_deleted(key) and not self.config.include_deleted then
      goto continue
    end
    if is_expired(val) then
      self.expired_timers[#self.expired_timers + 1] = key
    else
      specs[#specs + 1] = {
        name = key,
        timer_length = get_time_offset(val),
        message = vim.g.active_reminders[key].message,
        callback = vim.g.active_reminders[key].callback,
      }
    end

    ::continue::
  end

  return specs
end

return Persist
