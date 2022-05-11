local dump = dump
local C = minetest.colorize

minetest.register_chatcommand("ldebug", {
	description = "List things registered in the engine",
	func = function(name, param)
		if param == "abm" then
			return true,
				C(string.format("There are %s abms\n=============\n", #minetest.registered_abms), "green")..
				dump(minetest.registered_abms)..
				C("=============", "green")
		elseif param == "nodes" then
			return true,
				C("green", string.format("There are %s nodes\n=============\n", #minetest.registered_nodes))..
				dump(minetest.registered_nodes)..
				C("green", "=============")
		else
			return false, "No such param"
		end
	end,
})