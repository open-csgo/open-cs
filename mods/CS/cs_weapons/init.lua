minetest.log("action", "[cs_weapons] loading...")

local modpath  = minetest.get_modpath(minetest.get_current_modname())

cs_weapons = {}

cs_weapons.GUN_KNOCKBACK = minetest.settings:get_bool("cs_weapons.gun_knockback", true)

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

minetest.register_chatcommand("fs", {
	func = function(name)
		local pos = minetest.get_player_by_name(name):get_pos()

		minetest.add_entity(pos, "cs_weapons:flash")
	end
})

minetest.register_chatcommand("ft", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if player then
			local entities = minetest.get_objects_inside_radius(player:get_pos(), 20)
			for _,e in ipairs(entities) do
				if e:get_luaentity() and e:get_luaentity().name == "cs_weapons:flash" then
					cs_player.hud.flash(player, e:get_pos())
					break
				end
			end
			return true, "Done"
		else
			return false, "Not online"
		end
	end
})

minetest.log("action", "[cs_weapons] loaded succesfully")