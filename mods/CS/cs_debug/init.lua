local dump = dump

minetest.register_chatcommand("ldebug", {
	description = "List things registered in the engine",
	func = function(name, param)
		if param == "abm" then
			return true, string.format("There are %s abms\n", #minetest.registered_abms)..dump(minetest.registered_abms)
		else
			return false, "No such param"
		end
	end,
})