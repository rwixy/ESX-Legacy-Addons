--- @module client.module.main
--- Client-side scoreboard module

local Enum = xLib.require "client.module.enum"
local ScoreboardClass = xLib.require "client.module.class"
local Util = xLib.require "client.module.util"

--- Module exports table
local ScoreboardModule = {}

--- Current scoreboard instance
local currentScoreboard = nil

--- Cached player data
local cachedPlayers = {}

--- Cached job counts
local cachedJobs = {}

--- Cached activities
local cachedActivities = {}

--- Server info cache
local serverInfo = {
  serverName = "ESX Server",
  maxPlayers = 128,
  uptime = 0,
  logoUrl = ""
}

--- Check if scoreboard is currently open
--- @return boolean
function ScoreboardModule.IsOpen()
  return currentScoreboard ~= nil and currentScoreboard:IsOpen()
end

--- Open the scoreboard
function ScoreboardModule.OpenScoreboard()
  if ScoreboardModule.IsOpen() then return end

  currentScoreboard = ScoreboardClass:new()
  currentScoreboard:Open()

  ScoreboardModule.RefreshData()

  SendNUIMessage({ type = "show" })
  SetNuiFocus(true, true)
end

--- Close the scoreboard
function ScoreboardModule.CloseScoreboard()
  if not ScoreboardModule.IsOpen() then return end

  SendNUIMessage({ type = "hide" })
  SetNuiFocus(false, false)

  if currentScoreboard then
    currentScoreboard:Close()
    currentScoreboard = nil
  end
end

--- Toggle scoreboard visibility
function ScoreboardModule.ToggleScoreboard()
  if ScoreboardModule.IsOpen() then
    ScoreboardModule.CloseScoreboard()
  else
    ScoreboardModule.OpenScoreboard()
  end
end

--- Refresh scoreboard data from server
function ScoreboardModule.RefreshData()
  if not ScoreboardModule.IsOpen() then return end

  TriggerServerEvent("esx_scoreboard:server:requestData")
end

--- Update cached players
--- @param players table
function ScoreboardModule.UpdatePlayers(players)
  cachedPlayers = players

  SendNUIMessage({
    type = "updatePlayers",
    players = cachedPlayers
  })
end

--- Update cached jobs
--- @param jobs table
function ScoreboardModule.UpdateJobs(jobs)
  cachedJobs = jobs
  SendNUIMessage({
    type = "updateJobs",
    jobs = cachedJobs
  })
end

--- Update cached activities
--- @param activities table
function ScoreboardModule.UpdateActivities(activities)
  cachedActivities = activities
  SendNUIMessage({
    type = "updateActivities",
    activities = cachedActivities
  })
end

--- Update server info
--- @param info table
function ScoreboardModule.UpdateServerInfo(info)
  for key, value in pairs(info) do
    serverInfo[key] = value
  end
  SendNUIMessage({
    type = "updateServerInfo",
    info = serverInfo
  })
end

--- Register net event for full data update
RegisterNetEvent("esx_scoreboard:client:receiveData", function(players, jobs, activities, info)
  SendNUIMessage({
    type = "updateAll",
    players = players,
    jobs = jobs,
    activities = activities,
    info = info
  })
end)

return ScoreboardModule