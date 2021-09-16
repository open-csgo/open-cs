cs_player = {}

local players_channels = {}

local player_states = {}

function cs_player.get_player_state()
end

minetest.register_on_joinplayer(function(player)
	player_states[player] = "loading"
	players_channels[player] = minetest.mod_channel_join("cs_player:state_"..player:get_player_name())
	players_channels[player]:send_all("ttt")
end)