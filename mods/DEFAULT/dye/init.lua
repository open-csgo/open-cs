-- dye/init.lua

dye = {}

-- Load support for MT game translation.
local S = minetest.get_translator("dye")

-- Make dye names and descriptions available globally

dye.dyes = {
	{ "white", "White" },
	{ "grey", "Grey" },
	{ "dark_grey", "Dark Grey" },
	{ "black", "Black" },
	{ "violet", "Violet" },
	{ "blue", "Blue" },
	{ "cyan", "Cyan" },
	{ "dark_green", "Dark Green" },
	{ "green", "Green" },
	{ "yellow", "Yellow" },
	{ "brown", "Brown" },
	{ "orange", "Orange" },
	{ "red", "Red" },
	{ "magenta", "Magenta" },
	{ "pink", "Pink" },
}

-- Define items

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local description = row[2]
	local groups = { dye = 1 }
	groups["color_" .. name] = 1

	minetest.register_craftitem("dye:" .. name, {
		inventory_image = "dye_" .. name .. ".png",
		description = S(description .. " Dye"),
		groups = groups
	})
end

-- Dummy calls to S() to allow translation scripts to detect the strings.
-- To update this run:
-- for _,e in ipairs(dye.dyes) do print(("S(%q)"):format(e[2].." Dye")) end

--[[
S("White Dye")
S("Grey Dye")
S("Dark Grey Dye")
S("Black Dye")
S("Violet Dye")
S("Blue Dye")
S("Cyan Dye")
S("Dark Green Dye")
S("Green Dye")
S("Yellow Dye")
S("Brown Dye")
S("Orange Dye")
S("Red Dye")
S("Magenta Dye")
S("Pink Dye")
--]]
