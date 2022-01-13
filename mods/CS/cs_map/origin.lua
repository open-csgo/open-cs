local vector = vector

cs_map.origin_pos = vector.new(0, -1, 0)

minetest.register_node("cs_map:origin",{
	description = "Map Origin",
	drawtype = "airlike",
	groups = { not_in_creative_inventory = 1, immortal = 1 },
	diggable = false,
	is_ground_content = false,
	drop = "",
})

minetest.register_on_generated(function(minp, maxp, seed)
	local blockpos = cs_map.origin_pos
	if(minp.x <= blockpos.x and maxp.x >= blockpos.x and minp.y <= blockpos.y and maxp.y >= blockpos.y and minp.z <= blockpos.z and maxp.z >= blockpos.z) then
		minetest.set_node(blockpos, {name = "cs_map:origin"})
		minetest.log("action", "[cs_map] origin has been set at "..minetest.pos_to_string(blockpos)..".")
	end
end)