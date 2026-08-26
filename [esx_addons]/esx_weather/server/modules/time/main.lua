Modules = Modules or {}
Modules.Time = {}

---@param src integer?
<<<<<<< HEAD
function Modules.Time.broadcast(src)
    TriggerClientEvent("esx_weather:client:time:setTime", (src or -1), Modules.Time.get())
=======
---@param time Time?
function Modules.Time.broadcast(src, time)
    TriggerClientEvent("esx_weather:client:time:setTime", (src or -1), time or Modules.Time.get())
>>>>>>> d11cac7 (feat: Implement ESX Weather Admin Panel with modular architecture)
end

---@return SerializedTime
function Modules.Time.get()
    local t = os.date("*t")

    return {
        hours = tonumber(t.hour) or 0,
        minutes = tonumber(t.min) or 0,
        seconds = tonumber(t.sec) or 0
    } --[[@as SerializedTime]]
end
<<<<<<< HEAD
=======

---@param time Time
function Modules.Time.setTime(time)
    Modules.Time.broadcast(nil, time)
end
>>>>>>> d11cac7 (feat: Implement ESX Weather Admin Panel with modular architecture)
