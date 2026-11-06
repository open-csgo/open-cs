local dump = dump
local C = core.colorize

---@param t table
---@return integer
local function count(t)
	local c = 0
	for _, _ in pairs(t) do
		c = c + 1
	end
	return c
end

core.register_chatcommand("ldebug", {
	description = "List things registered in the engine",
	func = function(name, param)
		if param == "abm" then
			return true,
				C("green", string.format("There are %s abms\n=============\n", #core.registered_abms)) ..
				dump(core.registered_abms) ..
				C("green", "\n=============")
		elseif param == "nodes" then
			return true,
				C("green", string.format("There are %s nodes\n=============\n", #core.registered_nodes)) ..
				dump(core.registered_nodes) ..
				C("green", "\n=============")
		elseif param == "lbm" then
			return true,
				C("green", string.format("There are %s lbms\n=============\n", #core.registered_lbms)) ..
				dump(core.registered_lbms) ..
				C("green", "\n=============")
		elseif param == "ent" then
			return true,
				C("green", string.format("There are %s entities\n=============\n", #core.registered_entities)) ..
				dump(core.registered_entities) ..
				C("green", "\n=============")
		elseif param == "command" then
			return true,
				--FIXME: wrong count
				C("green", string.format("There are %s chatcommands\n=============\n", count(core.registered_chatcommands))) ..
				dump(core.registered_chatcommands) ..
				C("green", "\n=============")
		elseif param == "biome" then
			return true,
				C("green", string.format("There are %s biomes\n=============\n", #core.registered_biomes)) ..
				dump(core.registered_biomes) ..
				C("green", "\n=============")
		elseif param == "privs" then
			return true,
				C("green", string.format("There are %s privs\n=============\n", #core.registered_privileges)) ..
				dump(core.registered_privileges) ..
				C("green", "\n=============")
		else
			return false, "No such param"
		end
	end,
})
