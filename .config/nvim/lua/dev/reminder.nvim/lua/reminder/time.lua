local M = {}

M.second = 1000
M.minute = 60 * M.second
M.hour = 60 * M.minute
M.day = 24 * M.hour
M.week = 7 * M.day
M.month = 30 * M.day
M.year = 365 * M.day

return M
