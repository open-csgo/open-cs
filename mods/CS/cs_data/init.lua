local ipairs = ipairs

---@type table<string,ModChannel>
local players_channels = {}

local queue = {}

cs_data = {}

local has_started = false

---@type table<string,any>
cs_data.registered_initial_data = {}

---@param name string
---@param data any
function cs_data.register_initial_data(name, data)
	assert(has_started == false, "Cannot register initial data at runtime!")
	cs_data.registered_initial_data[name] = data
end

-- JOIN MOD CHANNELS

minetest.register_on_joinplayer(function(player)
	players_channels[player] = minetest.mod_channel_join("cs_client:join_data:" .. player:get_player_name())
	table.insert(queue, player)
end)

minetest.register_on_leaveplayer(function(player)
	players_channels[player] = nil
end)

minetest.register_globalstep(function(dtime)
	has_started = true
	local r = {}
	for _, o in ipairs(queue) do
		if players_channels[o]:is_writeable() then
			minetest.after(5, function()
				players_channels[o]:send_all(minetest.serialize(cs_data.registered_initial_data))
			end)
		else
			table.insert(r, o)
		end
	end
	queue = r
end)

cs_data.register_initial_data("cs_data:test", 5)
