local Timer = require("reminder.timer")
local async = require("plenary.async")
local time = require("reminder.time")

describe("Timer", function()
  it("should create a new Timer instance", function()
    local function testCallback(timerSpec)
      assert.are.same("TestTimer", timerSpec.name)
      assert.are.same("SampleData", timerSpec.additionalData)
    end

    ---@type ReminderTimerSpec
    local testTimerSpec = {
      name = "TestTimer",
      message = "nil",
      additionalData = "SampleData",
      timer_length = 1 * time.second,
      callback = testCallback,
    }

    local testTimer = Timer:new(testTimerSpec)

    local co = coroutine.running()

    async.run(function()
      testTimer:run()
    end, function()
      coroutine.resume(co)
    end)

    coroutine.yield(co)
  end)

  it("triggers vim.notify after completion", function()
    ---@diagnostic disable-next-line
    vim.notify = function(message)
      assert.are.same("TestTimer\nTestMessage", message)
    end

    ---@type ReminderTimerSpec
    local testTimerSpec =
      { name = "TestTimer", message = "TestMessage", timer_length = 1 * time.second, callback = function() end }

    local testTimer = Timer:new(testTimerSpec)

    local co = coroutine.running()
    async.run(function()
      testTimer:run()
    end, function()
      coroutine.resume(co)
    end)

    coroutine.yield(co)
  end)
end)
