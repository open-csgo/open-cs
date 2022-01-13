local players_channels = {}

minetest.register_on_joinplayer(function(player)
	players_channels[player] = minetest.mod_channel_join("cs_client:center_message:"..player:get_player_name())
end)

minetest.register_on_leaveplayer(function(player)
	players_channels[player] = nil
end)

function cs_player.hud.add_center_msg(player, text)
	if players_channels[player] and players_channels[player]:is_writeable() then
		players_channels[player]:send_all(text)
		return true
	else
		return false
	end
end

minetest.register_chatcommand("cmsg", {
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if player then
			local result = cs_player.hud.add_center_msg(player, param)
			if result == true then
				return true, "Done"
			else
				return false, "Modchannel isn't availlable!"
			end
		else
			return false, "Player isn't online!"
		end
	end,
})