---@param zone Zone
---@param weatherType WeatherType
RegisterNetEvent("esx_weather:server:setZoneWeather", function(zone, weatherType)
    local src = source --[[@as integer]]
    local xPlayer = ESX.Player(src)
    if (not xPlayer) then return end

    if (not Config.AdminGroups[xPlayer.getGroup()]) then
        return
    end

    if (not Modules.Weather.ByZone[zone]) then
        return
    end

    local isValidWeather = false
    for _, validType in ipairs(Config.Weather.ValidTypes) do
        if validType == weatherType then
            isValidWeather = true
            break
        end
    end

    if not isValidWeather then
        Shared.Modules.Debug.print(("Invalid weather type rejected from player %s: %s"):format(tostring(src), tostring(weatherType)))
        return
    end

    Modules.Weather.setZone(zone, weatherType)
end)

---@param zone Zone
RegisterNetEvent("esx_weather:server:setZoneTime", function(zone)
    local src = source --[[@as integer]]
    local xPlayer = ESX.Player(src)
    if (not xPlayer) then return end

    if (not Config.AdminGroups[xPlayer.getGroup()]) then
        return
    end

    Shared.Modules.Debug.print(("Time set requested for zone %s by player %s (not implemented)"):format(tostring(zone), tostring(src)))
end)

---@param src integer
AddEventHandler("esx:playerLoaded", function(src)
    Modules.Weather.broadcastZones(src)
    Modules.Time.broadcast(src)
end)

Citizen.SetTimeout(1000, function()
    Modules.Weather.broadcastZones()
    Modules.Time.broadcast()
end)
