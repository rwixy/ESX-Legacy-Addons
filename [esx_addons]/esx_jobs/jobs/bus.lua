-- SPDX-License-Identifier: GPL-3.0-only
-- Copyright (C) 2022-2026 ESX Framework

Config.Jobs.bus = {

	BlipInfos = {
		Sprite = 513,
		Color = 5
	},

	Vehicles = {

		Bus = {
			Spawner = 1,
			Hash = 'bus',
			Trailer = 'none',
			HasCaution = true
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 454.27, y = -600.62, z = 28.55},
			Size = {x = 0.8, y = 0.5, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 20,
			Blip = true,
			Name = TranslateCap('cloakroom'),
			Type = 'cloakroom',
			Hint = TranslateCap('cloak_change'),
			GPS = {x = 452.46, y = -607.11, z = 28.55}
		},

		VehicleSpawner = {
			Pos = {x = 452.46, y = -607.11, z = 28.55},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('spawn_veh'),
			Type = 'vehspawner',
			Spawner = 1,
			Hint = TranslateCap('spawn_veh_button'),
			Caution = 2000,
			GPS = {x = 185.79, y = -858.55, z = 30.18}
		},

		VehicleSpawnPoint = {
			Pos = {x = 462.15, y = -607.82, z = 28.50},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = TranslateCap('service_vh'),
			Type = 'vehspawnpt',
			Spawner = 1,
			Heading = 270.0,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 443.21, y = -583.90, z = 28.50},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('return_vh'),
			Type = 'vehdelete',
			Hint = TranslateCap('return_vh_button'),
			Spawner = 1,
			Caution = 2000,
			GPS = 0,
			Teleport = 0
		},

		LegionSquare = {
			Pos = {x = 185.79, y = -858.55, z = 30.18},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = 295.62, y = -928.39, z = 29.30},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		MissionRow = {
			Pos = {x = 295.62, y = -928.39, z = 29.30},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = -450.21, y = -853.82, z = 30.54},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		LittleSeoul = {
			Pos = {x = -450.21, y = -853.82, z = 30.54},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = -1104.79, y = -846.12, z = 19.32},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		VespucciCanals = {
			Pos = {x = -1104.79, y = -846.12, z = 19.32},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = -1266.14, y = -572.87, z = 30.57},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		DelPerro = {
			Pos = {x = -1266.14, y = -572.87, z = 30.57},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = -547.39, y = -217.73, z = 37.65},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		RockfordHills = {
			Pos = {x = -547.39, y = -217.73, z = 37.65},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = 311.34, y = -204.25, z = 54.09},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		},

		DowntownVinewood = {
			Pos = {x = 311.34, y = -204.25, z = 54.09},
			Size = {x = 8.0, y = 8.0, z = 1.0},
			Color = {r = 50, g = 200, b = 50},
			Marker = 1,
			Blip = false,
			Name = TranslateCap('bus_stop'),
			Type = 'delivery',
			Spawner = 1,
			Hint = TranslateCap('bus_stop_hint'),
			GPS = {x = 185.79, y = -858.55, z = 30.18},
			Item = {
				{
					name = TranslateCap('delivery'),
					time = 15,
					remove = 0,
					max = 100,
					price = 25,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			}
		}

	}
}