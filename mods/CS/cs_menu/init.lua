minetest.log("action", "[cs_menu] loading...")

local table = table

cs_menu = {}

cs_menu.formspec_prepend = table.concat({
	"listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]",
	"background9[5,5;1,1;gui_formbg.png;true;10]",
})

minetest.register_on_joinplayer(function(player)
	--disable inventory formspec
	--player:set_inventory_formspec("no_prepend[]")
	--apply formspec styling
	player:set_formspec_prepend(cs_menu.formspec_prepend)
	--hide unused HUD elements
	player:hud_set_flags({
		hotbar = true,
		healthbar = false,
		crosshair = true, --tmp
		wielditem = true,
		breathbar = false,
		--minimap = false,
		--minimap_radar = false,
	})
end)

minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if reason == "drown" then
		return 0
	else
		return hp_change
	end
end, true)

minetest.log("action", "[cs_menu] loaded succesfully")