local modpath = minetest.get_modpath(minetest.get_current_modname())

cs_map = {}

dofile(modpath.."/origin.lua")
dofile(modpath.."/emerge.lua")
dofile(modpath.."/map.lua")
dofile(modpath.."/register.lua")