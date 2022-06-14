local ipairs = ipairs

local data = {t=255}

local players_channels = {}

local queue = {}

minetest.register_on_joinplayer(function(player)
	players_channels[player] = minetest.mod_channel_join("cs_client:join_data:"..player:get_player_name())
	table.insert(queue, player)
end)

minetest.register_on_leaveplayer(function(player)
	players_channels[player] = nil
end)

minetest.register_globalstep(function(dtime)
	local r = {}
	for _,o in ipairs(queue) do
		if players_channels[o]:is_writeable() then
			minetest.after(5, function ()
				players_channels[o]:send_all(minetest.serialize(data))
			end)
			
		else
			table.insert(r, o)
		end
	end
	queue = r
end)

