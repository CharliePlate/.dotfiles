local a = require("plenary.async")
local M = {}
---@class ReminderConfig
---@field include_deleted? boolean
---@field while_away_notifications? boolean
---@field persist_file? string
---@field reminders? ReminderTimerSpec[]

---@type ReminderConfig
local default_config = {
  include_deleted = false,
  while_away_notifications = true,
  persist_file = vim.fn.stdpath("cache") .. "/reminder.json",
  reminders = {},
}

---@class ReminderSpec
---@field active_reminders table<string, ReminderTimerSpec>
local Reminder = {}

---@param config? ReminderConfig
M.setup = function(config)
  M.config = vim.tbl_deep_extend("force", default_config, config or {})

  ---@type ReminderSpec
  Reminder = {
    active_reminders = {},
  }

  for _, timerSpec in pairs(M.config.reminders) do
    Reminder.active_reminders[timerSpec.name] = timerSpec
  end

  RemindMe = Reminder

  M.persist = require("reminder.persist"):new(M.config)

  a.run(function()
    M.persist:get_file("your_file_path_here")
  end, function()
    print(M.persist.parsed)
  end)
end

return M
