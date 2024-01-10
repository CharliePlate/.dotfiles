local sleep = require("plenary.async.util").sleep

--- @class ReminderTimerSpec
--- @field name string
--- @field message string
--- @field timer_length  number
--- @field callback? function(ReminderTimerSpec)

--- @class ReminderTimer
--- @field timerSpec ReminderTimerSpec
local Timer = {}

---@param timerSpec ReminderTimerSpec
---@return ReminderTimer
function Timer:new(timerSpec)
  local reminder = setmetatable({
    timerSpec = timerSpec,
  }, self)

  self.__index = self

  return reminder
end

function Timer:run()
  sleep(self.timerSpec.timer_length)
  vim.notify(self.timerSpec.name .. "\n" .. self.timerSpec.message)
  self.timerSpec.callback(self.timerSpec)
end

return Timer
