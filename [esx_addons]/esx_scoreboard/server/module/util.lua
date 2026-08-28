--- @module server.module.util
--- Utility functions for the scoreboard server module

local Util = {}

--- Format a number with commas
--- @param num number
--- @return string
function Util.FormatNumber(num)
  return tostring(num):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

--- Format seconds to HH:MM:SS
--- @param seconds number
--- @return string
function Util.FormatTime(seconds)
  local h = math.floor(seconds / 3600)
  local m = math.floor((seconds % 3600) / 60)
  local s = seconds % 60
  return string.format("%02d:%02d:%02d", h, m, s)
end

--- Deep copy a table
--- @param tbl table
--- @return table
function Util.DeepCopy(tbl)
  local copy = {}
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      copy[k] = Util.DeepCopy(v)
    else
      copy[k] = v
    end
  end
  return copy
end

return Util