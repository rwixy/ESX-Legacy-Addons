--- @module server.module.main
--- Server-side scoreboard module

local Enum = xLib.require "server.module.enum"
local ScoreboardClass = xLib.require "server.module.class"
local Util = xLib.require "server.module.util"

--- Module exports table
local ScoreboardModule = {}

--- Cached player data
local cachedPlayers = {}

--- Cached job counts
local cachedJobs = {}

--- Cached activities
local cachedActivities = {}

--- Server start time for uptime tracking
local serverStartTime = os.time()

--- Resource name
local RESOURCE_NAME <const> = GetCurrentResourceName()

--- Get current server uptime in seconds
--- @return number
function ScoreboardModule.GetUptime()
  return os.time() - serverStartTime
end

--- Get configured max players
--- Uses Config.MaxPlayers if set, otherwise falls back to sv_maxclients convar
--- @return number
function ScoreboardModule.GetMaxPlayers()
  if Config.MaxPlayers and Config.MaxPlayers > 0 then
    return Config.MaxPlayers
  end
  return GetConvarInt("sv_maxclients", 128)
end

--- Get configured server name
--- @return string
function ScoreboardModule.GetServerName()
  return Config.ServerName or "ESX Server"
end

--- Get configured logo URL
--- @return string
function ScoreboardModule.GetLogoUrl()
  return Config.LogoUrl or ""
end

--- Build server info object for NUI
--- @return table
function ScoreboardModule.GetServerInfo()
  return {
    serverName = ScoreboardModule.GetServerName(),
    maxPlayers = ScoreboardModule.GetMaxPlayers(),
    logoUrl = ScoreboardModule.GetLogoUrl(),
    uptime = ScoreboardModule.GetUptime()
  }
end

--- Get all connected players data
--- Uses ESX character name instead of FiveM steam name
--- @return table
function ScoreboardModule.GetAllPlayers()
  local players = {}
  local allPlayers = GetPlayers()

  for _, playerId in ipairs(allPlayers) do
    local sourceNum = tonumber(playerId)
    local xPlayer = ESX.GetPlayerFromId(sourceNum)

    if xPlayer then
      local charName = xPlayer.getName() or GetPlayerName(sourceNum) or "Unknown"

      table.insert(players, {
        serverId = sourceNum,
        name = charName,
        job = xPlayer.job.name,
        jobGrade = xPlayer.job.grade_label or xPlayer.job.grade_name,
        group = xPlayer.getGroup(),
        ping = GetPlayerPing(sourceNum) or 0,
        activity = ScoreboardModule.GetPlayerActivity(sourceNum)
      })
    end
  end

  return players
end

--- Get job counts
--- @return table
function ScoreboardModule.GetJobCounts()
  local jobs = {}
  local allPlayers = GetPlayers()

  for _, playerId in ipairs(allPlayers) do
    local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
    if xPlayer then
      local jobName = xPlayer.job.name
      if not jobs[jobName] then
        local configJob = Config.Jobs[jobName]
        jobs[jobName] = {
          name = jobName,
          label = configJob and configJob.label or xPlayer.job.label or jobName,
          count = 0,
          color = ScoreboardModule.GetJobColor(jobName)
        }
      end
      jobs[jobName].count = jobs[jobName].count + 1
    end
  end

  local jobArray = {}
  for _, jobData in pairs(jobs) do
    table.insert(jobArray, jobData)
  end

  table.sort(jobArray, function(a, b) return a.count > b.count end)

  return jobArray
end

--- Get color for a job
--- @param jobName string
--- @return string
function ScoreboardModule.GetJobColor(jobName)
  if Config.Jobs[jobName] and Config.Jobs[jobName].color then
    return Config.Jobs[jobName].color
  end
  local colors = {
    police = "#3B82F6",
    ambulance = "#EF4444",
    mechanic = "#F59E0B",
    taxi = "#FBBF24",
    realtor = "#10B981",
    cardealer = "#8B5CF6",
    banker = "#06B6D4",
    unemployed = "#6B7280"
  }
  return colors[jobName] or "#FB9B04"
end

--- Get player activity
--- @param source number
--- @return string|nil
function ScoreboardModule.GetPlayerActivity(source)
  return nil
end

--- Get active activities
--- @return table
function ScoreboardModule.GetActiveActivities()
  return cachedActivities
end

--- Add an activity
--- @param activityType string
--- @param label string
--- @param location string
--- @param players table|nil
function ScoreboardModule.AddActivity(activityType, label, location, players)
  local configType = Config.ActivityTypes[activityType]
  local activity = {
    id = #cachedActivities + 1,
    type = activityType,
    label = label or (configType and configType.label) or activityType,
    location = location,
    startTime = os.time(),
    players = players or {}
  }

  table.insert(cachedActivities, activity)
  ScoreboardModule.BroadcastUpdate()

  return activity.id
end

--- Remove an activity
--- @param activityId number
function ScoreboardModule.RemoveActivity(activityId)
  for i, activity in ipairs(cachedActivities) do
    if activity.id == activityId then
      table.remove(cachedActivities, i)
      ScoreboardModule.BroadcastUpdate()
      return true
    end
  end
  return false
end

--- Update an activity
--- @param activityId number
--- @param data table
function ScoreboardModule.UpdateActivity(activityId, data)
  for _, activity in ipairs(cachedActivities) do
    if activity.id == activityId then
      for key, value in pairs(data) do
        activity[key] = value
      end
      ScoreboardModule.BroadcastUpdate()
      return true
    end
  end
  return false
end

--- Broadcast full update to all clients
function ScoreboardModule.BroadcastUpdate()
  cachedPlayers = ScoreboardModule.GetAllPlayers()
  cachedJobs = ScoreboardModule.GetJobCounts()

  local info = ScoreboardModule.GetServerInfo()

  TriggerClientEvent("esx_scoreboard:client:receiveData", -1,
    cachedPlayers,
    cachedJobs,
    cachedActivities,
    info
  )
end

--- Send data to specific client
--- @param source number
function ScoreboardModule.SendToClient(source)
  cachedPlayers = ScoreboardModule.GetAllPlayers()
  cachedJobs = ScoreboardModule.GetJobCounts()
  local info = ScoreboardModule.GetServerInfo()

  TriggerClientEvent("esx_scoreboard:client:receiveData", source,
    cachedPlayers,
    cachedJobs,
    cachedActivities,
    info
  )
end

--- Register server event for data request
RegisterServerEvent("esx_scoreboard:server:requestData")
AddEventHandler("esx_scoreboard:server:requestData", function()
  local source = source
  ScoreboardModule.SendToClient(source)
end)

--- Register server event for activity registration from other resources
RegisterServerEvent("esx_scoreboard:server:addActivity")
AddEventHandler("esx_scoreboard:server:addActivity", function(activityType, label, location, players)
  ScoreboardModule.AddActivity(activityType, label, location, players)
end)

--- Register server event for activity removal
RegisterServerEvent("esx_scoreboard:server:removeActivity")
AddEventHandler("esx_scoreboard:server:removeActivity", function(activityId)
  ScoreboardModule.RemoveActivity(activityId)
end)

--- Thread to periodically broadcast updates
CreateThread(function()
  while true do
    Wait(Config.UpdateInterval)
    ScoreboardModule.BroadcastUpdate()
  end
end)

--- Handle player dropped
AddEventHandler("playerDropped", function(reason)
  Wait(500)
  ScoreboardModule.BroadcastUpdate()
end)

--- Export for other resources to add activities
exports("AddActivity", ScoreboardModule.AddActivity)
exports("RemoveActivity", ScoreboardModule.RemoveActivity)
exports("UpdateActivity", ScoreboardModule.UpdateActivity)
exports("GetActiveActivities", ScoreboardModule.GetActiveActivities)

return ScoreboardModule