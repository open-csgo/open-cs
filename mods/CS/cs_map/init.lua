minetest.log("action", "[cs_map] loading...")

local modpath = minetest.get_modpath("cs_map")

cs_map = {}

dofile(modpath.."/origin.lua")
dofile(modpath.."/emerge.lua")
dofile(modpath.."/map.lua")
dofile(modpath.."/register.lua")

minetest.log("action", "[cs_map] loaded succesfully")