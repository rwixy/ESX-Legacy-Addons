--- @module server.module.enum
--- Enum definitions for the scoreboard server module

local Enum = {}

--- Activity types
Enum.ActivityType = {
  ROBBERY = "robbery",
  HEIST = "heist",
  DRUG = "drug",
  RACE = "race",
  HOSTAGE = "hostage",
  SHOOTOUT = "shootout"
}

--- Player groups
Enum.PlayerGroup = {
  USER = "user",
  ADMIN = "admin",
  SUPERADMIN = "superadmin",
  OWNER = "owner",
}

return Enum