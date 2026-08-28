--- @module client.module.util
--- Utility functions for the scoreboard client module

local Util = {}

--- Format a number with commas
--- @param num number
--- @return string
function Util.FormatNumber(num)
  return tostring(num):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

--- Clamp a value between min and max
--- @param value number
--- @param min number
--- @param max number
--- @return number
function Util.Clamp(value, min, max)
  return math.max(min, math.min(max, value))
end

--- Check if a table contains a value
--- @param tbl table
--- @param value any
--- @return boolean
function Util.Contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then return true end
  end
  return false
end

return Util