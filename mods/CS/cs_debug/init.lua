local dump = dump
local C = minetest.colorize

---@param t table
---@return integer
local function count(t)
	local c = 0
	for _, _ in pairs(t) do
		c = c + 1
	end
	return c
end

minetest.register_chatcommand("ldebug", {
	description = "List things registered in the engine",
	func = function(name, param)
		if param == "abm" then
			return true,
				C("green", string.format("There are %s abms\n=============\n", #minetest.registered_abms)) ..
				dump(minetest.registered_abms) ..
				C("green", "\n=============")
		elseif param == "nodes" then
			return true,
				C("green", string.format("There are %s nodes\n=============\n", #minetest.registered_nodes)) ..
				dump(minetest.registered_nodes) ..
				C("green", "\n=============")
		elseif param == "lbm" then
			return true,
				C("green", string.format("There are %s lbms\n=============\n", #minetest.registered_lbms)) ..
				dump(minetest.registered_lbms) ..
				C("green", "\n=============")
		elseif param == "ent" then
			return true,
				C("green", string.format("There are %s entities\n=============\n", #minetest.registered_entities)) ..
				dump(minetest.registered_entities) ..
				C("green", "\n=============")
		elseif param == "command" then
			return true,
				--FIXME: wrong count
				C("green", string.format("There are %s chatcommands\n=============\n", count(minetest.registered_chatcommands))) ..
				dump(minetest.registered_chatcommands) ..
				C("green", "\n=============")
		elseif param == "biome" then
			return true,
				C("green", string.format("There are %s biomes\n=============\n", #minetest.registered_biomes)) ..
				dump(minetest.registered_biomes) ..
				C("green", "\n=============")
		elseif param == "privs" then
			return true,
				C("green", string.format("There are %s privs\n=============\n", #minetest.registered_privileges)) ..
				dump(minetest.registered_privileges) ..
				C("green", "\n=============")
		else
			return false, "No such param"
		end
	end,
})
