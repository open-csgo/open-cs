local modpath = minetest.get_modpath(minetest.get_current_modname())

local vector = vector

cs_map.register_map("hill", {
	desc = "Hill Map",
	screenshot = nil,
	schem = modpath.."/maps/map1.mts",
	size = vector.new(50, 50, 50),
	start_positions = {
		team1 = vector.new(10, 10, 10),
		team2 = vector.new(20, 10, 20),
	},
	min_real_players = 2,
	graphics = {
		--night_ratio = 6000,
		night_ratio = 1,
		sky = {
			--base_color = "#AAAABB",
			--type = "plain",
			--textures = nil,
			--clouds = false,
			sky_color = {
				--day_sky = "#61b5f6",
				--day_horizon = "#90d3f6",
				--dawn_sky = "#b4bafa",
				--dawn_horizon = "#bac1f0",
				--night_sky = "#006bff",
				--night_horizon = "#4090ff",
				--indoors = "#646464",
				--fog_sun_tint = nil,
				--fog_moon_tint = nil,
				--fog_tint_type = "default",
			},
		},
	},
	allowed_modes = {
		competitive = true
	}
})