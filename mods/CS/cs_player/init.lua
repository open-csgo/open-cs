minetest.log("action", "[cs_player] loading...")

local minetest = minetest

local vector = vector

local modpath = minetest.get_modpath(minetest.get_current_modname())

cs_player = {
	hud = {},
	apparence = {},
}

--[[local players_channels = {
	center_message = {},
}

local player_states = {}]]

function cs_player.get_player_state()
end

dofile(modpath .. "/api/hud_cmsg.lua")
dofile(modpath .. "/api/hud_flash.lua")
dofile(modpath .. "/model.lua")

--[[
animations = {
	-- Standard animations.
	idle      = {x = 0,   y = 80}
	stand     = {x = 0,   y = 79},
	lay       = {x = 162, y = 166},
	walk      = {x = 168, y = 187},
	mine      = {x = 189, y = 198},
	walk_mine = {x = 200, y = 219},
	sit       = {x = 81,  y = 160},
},
]]

cs_player.apparence.register_model("character.b3d", {
	animation_speed = 30,
	textures = { "character.png" },
	animations = {
		-- Standard animations.
		stand     = { x = 0, y = 79 },
		lay       = { x = 162, y = 166 },
		walk      = { x = 168, y = 187 },
		mine      = { x = 189, y = 198 },
		walk_mine = { x = 200, y = 219 },
		sit       = { x = 81, y = 160 },
	},
	collisionbox = { -0.3, 0.0, -0.3, 0.3, 1.7, 0.3 },
	stepheight = 0.6,
	eye_height = 1.47,
})

minetest.register_on_joinplayer(function(player)
	player:set_pos(vector.new(0, 0, 0))
	player:set_properties({
		hp_max = 100,
		--breath_max = 0,
		damage_texture_modifier = "^[colorize:red:100",
	})
	player:set_hp(100)
	player:set_physics_override({ jump = 1.3, speed = 1.2 })
	player:hud_set_hotbar_itemcount(4)
	--player:set_minimap_modes({type = "texture", texture = "player.png", scale = 1}, 0)
	cs_player.apparence.player_attached[player:get_player_name()] = false
	cs_player.apparence.set_model(player, "character.b3d")
	--player_states[player] = "loading"
	--players_channels[player] = minetest.mod_channel_join("cs_player:state_"..player:get_player_name())
	--players_channels[player]:send_all("ttt")
end)

minetest.register_on_leaveplayer(function(player)
	player:set_pos(vector.new(0, 0, 0))
end)

function minetest.send_join_message(player_name)
end

function minetest.send_leave_message(player_name)
end

minetest.log("action", "[cs_player] loaded succesfully")
