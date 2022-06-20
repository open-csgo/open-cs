local map_pos = vector.new(20000, 0, 20000)

cs_map.registered_maps = {}

---@param name string
---@param def table
function cs_map.register_map(name, def)
	cs_map.registered_maps[name] = def
end

---@param player ObjectRef
---@param graphics table
function cs_map.apply_graphics(player, graphics)
	player:override_day_night_ratio(graphics.night_ratio)
	player:set_sky(graphics.sky)
end

---@param type string
function cs_map.create_map(type)
	local mapdef = cs_map.registered_maps[type]
	if not mapdef then error("Map doesn't exist!") end
	cs_map.emerge_with_callbacks(map_pos, map_pos + mapdef.size, function(context)
		minetest.place_schematic(map_pos, mapdef.schem, 0, {["draconis:scorched_soil"] = "default:dirt"}, true, {})
		for _,player in pairs(minetest.get_connected_players()) do
			player:set_pos(map_pos + mapdef.start_positions.team1)
			cs_map.apply_graphics(player, mapdef.graphics)
		end
	end)
end

minetest.register_chatcommand("map", {
	func = function()
		print(dump(cs_map.registered_maps))
		cs_map.create_map("hill")
	end,
})