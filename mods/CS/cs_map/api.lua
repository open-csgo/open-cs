
cs_map.INITIAL_MAP_POS = vector.new(-30000, 0, -30000)

---@type integer
cs_map.MAX_CONCURENT_MAPS = tonumber(minetest.settings:get("cs_map.max_concurent_maps")) or 4


---@type table<integer, cs_map_active>
cs_map.active_maps = {}


---@type fun(index: integer, new: cs_map_active|nil)[]
cs_map.registered_on_active_maps_update = {}


---@param func fun(index: integer, new: cs_map_active|nil)
function cs_map.register_on_active_maps_update(func)
	table.insert(cs_map.registered_on_active_maps_update, func)
end


---@param index integer
---@param new cs_map_active?
function cs_map.update_active_maps(index, new)
	cs_map.active_maps[index] = new
	for _,f in ipairs(cs_map.registered_on_active_maps_update) do
		f(index, new)
	end
end


---@type table<string, cs_map_definition>
cs_map.registered_maps = {}


---@param name string
---@param def cs_map_definition
function cs_map.register_map(name, def)
	cs_map.registered_maps[name] = def
end


---@param player ObjectRef
---@param graphics table
function cs_map.apply_graphics(player, graphics)
	player:override_day_night_ratio(graphics.night_ratio)
	player:set_sky(graphics.sky)
end

---@param index integer
---@return Vector
function cs_map.map_index_to_pos(index)
	return vector.offset(cs_map.INITIAL_MAP_POS, 2000 * (index - 1), 0, 0)
end


---@return integer?
function cs_map.get_free_index()
	for i = 1, cs_map.MAX_CONCURENT_MAPS do
		if not cs_map.active_maps[i] then
			return i
		end
	end
	return nil
end


---@param type string
---@param mode any
---@param initial_players {}
function cs_map.create_map(type, mode, initial_players)
	local mapdef = cs_map.registered_maps[type]

	if not mapdef then error("Map doesn't exist!") end

	local index = cs_map.get_free_index()

	if not index then return false end

	cs_map.update_active_maps(index, {
		id = "hill",
		mode = "competitive",
		players = {team1 = {}, team2={}},
	})

	cs_map.emerge_map(index)
end

---@param index integer
function cs_map.emerge_map(index)
	local p = cs_map.active_maps[index]
	local mapdef = cs_map.registered_maps[p.id]

	--TODO: forceload block to prevent unloading (=map destroyed with dummy mapgen)

	if not p then return false end
	if not mapdef then return false end

	local pos = cs_map.map_index_to_pos(index)

	cs_map.emerge_with_callbacks(pos, pos + mapdef.size, function(context)
		minetest.place_schematic(pos, mapdef.schem, 0, {["draconis:scorched_soil"] = "default:dirt"}, true, {})
		for _,player in pairs(minetest.get_connected_players()) do
			player:set_pos(pos + mapdef.start_positions.team1)
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

minetest.register_chatcommand("map_list", {
	func = function()
		return true, dump(cs_map.active_maps)
	end,
})