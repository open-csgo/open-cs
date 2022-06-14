minetest.log("action", "[cs_weapons] loading...")

local modpath  = minetest.get_modpath(minetest.get_current_modname())

cs_weapon = {}

dofile(modpath.."/api.lua")

minetest.register_on_joinplayer(function(player)
	minetest.after(5, function()
		if not player then return end
		local obj = minetest.add_entity(player:get_pos(), "cs_weapons:sniper")
		if obj then
			obj:set_attach(player, "Arm_Right", vector.new(0, 0, 0), vector.new(180, 180, 0), true)
		end
	end)
end)


minetest.register_entity("cs_weapons:flash", {
	initial_properties = {
		physical = false,
		pointable = false,
		visual = "mesh",
		textures = {"cs_weapons_flash.png"},
		mesh = "cs_weapons_flash.obj",
		visual_size = vector.new(16, 16, 16),
	}
})

minetest.register_chatcommand("f", {
	func = function(name)
		local pos = minetest.get_player_by_name(name):get_pos()

		minetest.add_entity(pos, "cs_weapons:flash")
	end
})

minetest.log("action", "[cs_weapons] loaded succesfully")