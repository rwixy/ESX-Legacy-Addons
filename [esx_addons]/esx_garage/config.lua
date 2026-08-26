Config = {}

Config.Locale = GetConvar("esx:locale", "en")

---@type GarageSettings
Config.Settings = {
	interactionDistance = 3.0,
	restrictToGarage = false,
	defaultImpoundFee = 400,
	vehicleKeys = false,
<<<<<<< HEAD
=======
	storeMarkerOnlyInVehicle = true,
	showMarker = true,
	vehiclesPerPage = 30,
	maxVehiclesPerMenu = 100,
>>>>>>> upstream-1142/1.14.2
}

---@type Garage[]
Config.Garages = {
	{
		id = "vespucci_boulevard",
		label = "Vespucci Boulevard",
		type = "public",
		entryPoint = vec3(-285.2, -886.5, 31.0),
<<<<<<< HEAD
=======
		storePoint = vec3(-298.8, -889.7, 31.0),
>>>>>>> upstream-1142/1.14.2
		spawns = {
			vec4(-309.3, -897.0, 31.0, 351.8),
		},
		blip = { sprite = 357, scale = 0.8, color = 3 },
<<<<<<< HEAD
		ped = { model = `s_m_m_gentransport`, coords = vec4(-282.8655, -888.8463, 31.0806, 72.7597) },
=======
		ped = { model = `s_m_m_gentransport`, z = 30.73, heading = 72.7597 },
>>>>>>> upstream-1142/1.14.2
		pound = "los_santos",
	},
	{
		id = "san_andreas_avenue",
		label = "San Andreas Avenue",
		type = "public",
<<<<<<< HEAD
		entryPoint = vec3(213.9, -809.8, 31.0),
=======
		entryPoint = vec3(216.29, -808.96, 30.73),
		storePoint = vec3(220.1, -805.2, 30.8),
>>>>>>> upstream-1142/1.14.2
		spawns = {
			vec4(225.7, -801.9, 30.5, 250.0),
		},
		blip = { sprite = 357, scale = 0.8, color = 3 },
<<<<<<< HEAD
		ped = { model = `s_m_m_gentransport`, coords = vec4(216.5, -808.0, 30.8, 250.0) },
=======
		ped = { model = `s_m_m_gentransport`, z = 30.73, heading = 250.0 },
>>>>>>> upstream-1142/1.14.2
		pound = "los_santos",
	},
}

---@type Impound[]
<<<<<<< HEAD
=======
-- `cost` is optional. When omitted, Config.Settings.defaultImpoundFee is used.
>>>>>>> upstream-1142/1.14.2
Config.Impounds = {
	{
		id = "los_santos",
		label = "Los Santos Impound",
		getOutPoint = vec3(400.7, -1630.5, 29.3),
		spawns = {
			vec4(401.9, -1647.4, 29.2, 323.3),
		},
		blip = { sprite = 524, scale = 0.8, color = 1 },
		cost = 3000,
	},
	{
		id = "paleto_bay",
		label = "Paleto Bay Impound",
		getOutPoint = vec3(-211.4, 6206.5, 31.4),
		spawns = {
			vec4(-204.6, 6221.6, 30.5, 227.2),
		},
		blip = { sprite = 524, scale = 0.8, color = 1 },
		cost = 3000,
	},
	{
		id = "sandy_shores",
		label = "Sandy Shores Impound",
		getOutPoint = vec3(1728.2, 3709.3, 33.2),
		spawns = {
			vec4(1722.7, 3713.6, 33.2, 19.9),
		},
		blip = { sprite = 524, scale = 0.8, color = 1 },
		cost = 3000,
	},
}
