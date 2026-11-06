core.log("action", "[cs_weapons] loading...")

local modpath  = core.get_modpath(core.get_current_modname())

cs_weapons = {}

cs_weapons.GUN_KNOCKBACK = core.settings:get_bool("cs_weapons.gun_knockback", true)

dofile(modpath.."/api.lua")

core.register_on_joinplayer(function(player)
	core.after(5, function()
		local pos = player:get_pos()
		if not pos then return end
		local obj = core.add_entity(pos, "cs_weapons:sniper")
		if obj then
			obj:set_attach(player, "Arm_Right", vector.new(0, 0, 0), vector.new(180, 180, 0), true)
		end
	end)
end)


core.register_entity("cs_weapons:flash", {
	initial_properties = {
		physical = false,
		pointable = false,
		visual = "mesh",
		textures = {"cs_weapons_flash.png"},
		mesh = "cs_weapons_flash.obj",
		visual_size = vector.new(16, 16, 16),
	}
})

core.register_chatcommand("fs", {
	func = function(name)
		local pos = core.get_player_by_name(name):get_pos()

		core.add_entity(pos, "cs_weapons:flash")
	end
})

core.register_chatcommand("ft", {
	func = function(name)
		local player = core.get_player_by_name(name)
		if player then
			local entities = core.get_objects_inside_radius(player:get_pos(), 20)
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

core.log("action", "[cs_weapons] loaded succesfully")
