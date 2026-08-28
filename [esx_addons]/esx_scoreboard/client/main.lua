--- @module client.main
--- Main client entry point for the scoreboard resource

local ScoreboardModule = xLib.require "client.module.main"

local RESOURCE_NAME <const> = GetCurrentResourceName()

local nuiReady = false

--- Register NUI callback for theme request
RegisterNUICallback("getTheme", function(data, cb)
  cb({
    primaryColor = GetConvar("esx:ui:primaryColor", "#FB9B04"),
    secondaryColor = GetConvar("esx:ui:secondaryColor", "#252525"),
    backgroundColor = GetConvar("esx:ui:backgroundColor", "#161616"),
    accentColor = GetConvar("esx:ui:accentColor", "#383838"),
    logoUrl = GetConvar("esx:ui:logoUrl", "")
  })
end)

--- Register NUI ready callback
RegisterNUICallback("nuiReady", function(data, cb)
  nuiReady = true
  cb({})
end)

--- Register NUI callback to close scoreboard from UI
RegisterNUICallback("closeScoreboard", function(data, cb)
  ScoreboardModule.CloseScoreboard()
  TriggerServerEvent("esx_scoreboard:server:close")
  cb({})
end)

--- Send theme update to NUI
local function SendThemeUpdate()
  SendNUIMessage({
    type = "updateTheme",
    primaryColor = GetConvar("esx:ui:primaryColor", "#FB9B04"),
    secondaryColor = GetConvar("esx:ui:secondaryColor", "#252525"),
    backgroundColor = GetConvar("esx:ui:backgroundColor", "#161616"),
    accentColor = GetConvar("esx:ui:accentColor", "#383838"),
    logoUrl = GetConvar("esx:ui:logoUrl", "")
  })
end

--- Main thread for scoreboard
CreateThread(function()
  while true do
    Wait(0)

    if IsControlJustReleased(0, Config.OpenKey) then
      ScoreboardModule.ToggleScoreboard()
    end

    if ScoreboardModule.IsOpen() then
      DisableControlAction(0, 1, true)
      DisableControlAction(0, 2, true)
      DisableControlAction(0, 142, true)
      DisableControlAction(0, 18, true)
      DisableControlAction(0, 322, true)
      DisableControlAction(0, 106, true)

      if IsDisabledControlJustReleased(0, 322) then
        ScoreboardModule.CloseScoreboard()
      end
    end
  end
end)


--- Thread to periodically refresh scoreboard data
CreateThread(function()
  while true do
    Wait(Config.UpdateInterval)

    if ScoreboardModule.IsOpen() then
      ScoreboardModule.RefreshData()
    end
  end
end)

--- Listen for resource start
AddEventHandler("onResourceStart", function(resourceName)
  if resourceName ~= RESOURCE_NAME then return end
  Wait(1000)
  SendThemeUpdate()
end)

--- Handle resource stop
AddEventHandler("onResourceStop", function(resourceName)
  if resourceName ~= RESOURCE_NAME then return end
  ScoreboardModule.CloseScoreboard()
end)