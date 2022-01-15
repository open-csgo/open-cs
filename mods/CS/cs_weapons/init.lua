minetest.log("action", "[cs_weapons] loading...")

local modpath  = minetest.get_modpath(minetest.get_current_modname())

cs_weapon = {}

dofile(modpath.."/api.lua")

minetest.register_on_joinplayer(function(player)
	minetest.after(5, function()
		if not player then return end
		local obj = minetest.add_entity(player:get_pos(), "cs_weapon:sniper")
		if obj then
			obj:set_attach(player, "Arm_Right", vector.new(0, 0, 0), vector.new(180, 180, 0), true)
		end
	end)
end)

minetest.log("action", "[cs_weapons] loaded succesfully")