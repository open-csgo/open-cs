local ipairs = ipairs

---@type table<ObjectRef,ModChannel>
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

core.register_on_joinplayer(function(player)
	players_channels[player] = core.mod_channel_join("cs_client:join_data:" .. player:get_player_name())
	table.insert(queue, player)
end)

core.register_on_leaveplayer(function(player)
	players_channels[player] = nil
end)

core.register_globalstep(function(dtime)
	has_started = true
	local r = {}
	for _, o in ipairs(queue) do
		local channel = players_channels[o]
		if channel and channel:is_writeable() then
			core.after(5, function()
				if players_channels[o] == channel then
					channel:send_all(core.serialize(cs_data.registered_initial_data))
				end
			end)
		elseif channel then
			table.insert(r, o)
		end
	end
	queue = r
end)

cs_data.register_initial_data("cs_data:test", 5)
