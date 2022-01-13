local modpath  = minetest.get_modpath("cs_weapons")

minetest.log("action", "[cs_weapons] loading...")

cs_weapon = {}

dofile(modpath.."/api.lua")

minetest.register_on_joinplayer(function(player)
	minetest.log("error", "spawn todo")
	minetest.after(5, function()
		if not player then return end
		local obj = minetest.add_entity(player:get_pos(), "cs_weapon:sniper")
		if obj then
			obj:set_attach(player, "Arm_Right", vector.new(0, 0, 0), vector.new(0,0,0), true)
			minetest.log("error", "spawn")
		else
			minetest.log("error", "not spawn")
		end
	end)
end)

minetest.log("action", "[cs_weapons] loaded succesfully")