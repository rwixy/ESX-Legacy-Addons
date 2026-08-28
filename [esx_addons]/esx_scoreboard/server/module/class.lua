--- @module server.module.class
--- Class definitions for the scoreboard server module

--- @class Activity
--- @field id number
--- @field type string
--- @field label string
--- @field location string
--- @field startTime number
--- @field players table
local Activity = {}
Activity.__index = Activity

--- Create a new Activity
--- @param activityType string
--- @param label string
--- @param location string
--- @param players table|nil
--- @return Activity
function Activity:new(activityType, label, location, players)
  local newActivity = {
    id = 0,
    type = activityType,
    label = label,
    location = location,
    startTime = os.time(),
    players = players or {}
  }
  setmetatable(newActivity, Activity)
  return newActivity
end

--- Get elapsed time in seconds
--- @return number
function Activity:GetElapsedTime()
  return os.time() - self.startTime
end

--- Add a player to the activity
--- @param playerId number
function Activity:AddPlayer(playerId)
  if not self:HasPlayer(playerId) then
    table.insert(self.players, playerId)
  end
end

--- Remove a player from the activity
--- @param playerId number
function Activity:RemovePlayer(playerId)
  for i, id in ipairs(self.players) do
    if id == playerId then
      table.remove(self.players, i)
      return
    end
  end
end

--- Check if player is in activity
--- @param playerId number
--- @return boolean
function Activity:HasPlayer(playerId)
  for _, id in ipairs(self.players) do
    if id == playerId then return true end
  end
  return false
end

return Activity