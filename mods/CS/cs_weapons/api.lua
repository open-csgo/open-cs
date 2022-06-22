local minetest = minetest

local vector = vector

---@param m number
---@return number
local function metters_to_inches(m)
	return m*10000/254
end

---@param base_damage number
---@param range_modifier number
---@param inches_distance number
---@return number
local function distance_to_damage(base_damage, range_modifier, inches_distance)
	return base_damage * (range_modifier ^ (inches_distance/500))
end

cs_weapon.registered_weapons = {}

---@param name string
---@param def table
function cs_weapon.register_weapon(name, def)
	def.specs.damage = def.specs.damage or 10
	--[[local function use(_, user, _)
		cs_weapon.shot(user, {damage = def.specs.damage, range_modifier = def.specs.range_modifier or 0.40})
	end]]
	minetest.register_craftitem(name, {
		description = def.desc or "UKNOWN",
		inventory_image = def.icon or "default_stone.png",
		--on_use = use,
		--on_secondary_use = use,
		groups = {weapon = 1},
		_weapon = {
		},
	})
	minetest.register_entity(name, {
		initial_properties = {
			physical = false,
			pointable = false,
			visual = "mesh",
			textures = {def.texture},
			mesh = def.model,
			visual_size = vector.new(1, 1, 1),
		},
		on_step = function(self)
			if not self.object:get_attach() then
				self.object:remove()
			end
		end,
	})
end

controls.register_on_hold(function(player, cname, time)
	if cname ~= "dig" then return end
	local item = player:get_wielded_item()

	if item:get_definition().groups.weapon ~= 0 then
		cs_weapon.shot(player, {damage = 36, range_modifier = 0.4})
	end
end)

---@param player ObjectRef
---@param def any
function cs_weapon.shot(player, def)
	def.height = def.height or player:get_properties().eye_height
	local pos = player:get_pos()
	pos.y = pos.y + def.height

	minetest.debug(player:get_look_horizontal(), player:get_look_vertical())

	local ctrl = player:get_player_control()

	player:set_look_vertical(player:get_look_vertical() - math.random()/(ctrl.sneak and 64 or 32))
	player:set_look_horizontal(player:get_look_horizontal() + math.random(-100, 100)/(ctrl.sneak and 4000 or 2000))

	local look_dir = player:get_look_dir()
	look_dir = vector.multiply(look_dir, 20)
	local pos2 = vector.add(pos, look_dir)

	local ray = minetest.raycast(pos, pos2, true, false)
	if ray then
		for pointed_thing in ray do
			if pointed_thing then
				--minetest.chat_send_all(pointed_thing.type)
				if pointed_thing.type == "node" then
					local node = minetest.get_node(pointed_thing.under).name
					if minetest.get_item_group(node, "door_shoot") ~= 0 then
						--TODO: implement door breaking
						minetest.chat_send_all("door found!")
					elseif minetest.get_item_group(node, "leaves") ~= 0 then
						--TODO: add this to CSM/SSCSM
						minetest.chat_send_all("leaves found!")
						local velocity = vector.new(3, 3, 3)
						minetest.add_particlespawner({
							amount = 10,
							time = 0.1,
							minpos = pointed_thing.under + vector.new(1, 1, 1),
							maxpos = pointed_thing.under - vector.new(1, 1, 1),
							minvel = -velocity,
							maxvel = velocity,
							minacc = -velocity,
							maxacc = velocity,
							minexptime = 1,
							maxexptime = 1,
							minsize = 0,
							maxsize = 0,
							collisiondetection = true,
							collision_removal = false,
							object_collision = true,
							--playername = "singleplayer",
							node = {name = node, param2 = 0},
						})
					else
						minetest.chat_send_all("node found!")
						minetest.add_particle({
							pos = pointed_thing.intersection_point,
							expirationtime = 5,
							size = 2,
							texture = "cs_weapons_bullet_hole.png",
						})
						break
					end
				elseif pointed_thing.type == "object" and
					pointed_thing.ref:is_player() and
					pointed_thing.ref:get_player_name() ~= player:get_player_name() then
					local pos_target = pointed_thing.ref:get_pos()
					local distance = vector.distance(pos, pos_target)
					local damage = distance_to_damage(def.damage, def.range_modifier, metters_to_inches(distance))

					pointed_thing.ref:set_hp(pointed_thing.ref:get_hp() - damage, "punch")
					minetest.chat_send_all("obj found!")
					break
				end
			end
		end
	end
	return nil
end

cs_weapon.register_weapon("cs_weapons:sniper", {
	desc = "Smiper",
	model = "cs_weapons_sniper.obj",
	texture = "cs_weapons_sniper.png",
	specs = {
		price = 2700,
		kill_award = 300,
		damage = 36,
		range_modifier = 0.98,
		firerate = 600, --RPM
	},
})

