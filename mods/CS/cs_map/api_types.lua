---@class cs_map_definition
local cs_map_definition = {}

---Map description
---@type string
cs_map_definition.desc = nil

---Screenshot filename or nil if none availlable
---@type string?
cs_map_definition.screenshot = nil

---Path to map schematic
---@type string
cs_map_definition.schem = nil

---Map size
---@type Vector
cs_map_definition.size = nil

---Start position of teams
---@type {team1: Vector, team2: Vector}
cs_map_definition.start_positions = nil

---Minimum amount of real player to start the game
---@type integer
cs_map_definition.min_real_players = nil

---Graphics applied to players inside the map
---@type {night_ratio: integer, sky: sky_parameters}
cs_map_definition.graphics = nil

---@type table<string, boolean>
cs_map_definition.allowed_modes = nil



---@class cs_map_active
local cs_map_active = {}

---ID of the map
---@type string
cs_map_active.id = nil

---Gamemode
---@type '"competitive"'|'"---"'
cs_map_active.mode = nil

---Players
---@type {team1: ObjectRef[], team2: ObjectRef[]}
cs_map_active.players = nil

