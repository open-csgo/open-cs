local players_channels = {}


minetest.register_on_joinplayer(function(player)
	players_channels[player] = minetest.mod_channel_join("cs_client:flash:"..player:get_player_name())
end)

minetest.register_on_leaveplayer(function(player)
	players_channels[player] = nil
end)

---@param player ObjectRef
---@param pos Vector
---@return boolean
function cs_player.hud.flash(player, pos)
	if players_channels[player] and players_channels[player]:is_writeable() then
		players_channels[player]:send_all(vector.to_string(pos))
		return true
	else
		return false
	end
end