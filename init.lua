local path = minetest.get_modpath("noctalis")

-- mod table
noctalis = {}

-- shared resources
dofile(path .. "/noctalis_starting_items.lua")
dofile(path .. "/noctalis_decoration.lua")
dofile(path .. "/noctalis_utils.lua")  -- utility functions like movement, AI helpers

-- MOB SECTIONS =========================================
dofile(path .. "/mobs/vespera.lua")
-- dofile(path .. "/mobs/nextmob.lua")  -- future mobs go here

-- optional integrations
if minetest.get_modpath("boss_s_hudbar") then
    dofile(path .. "/vespera_bar.lua")  -- if Vespera has a boss bar
end

-- recipes, sigils, items
dofile(path .. "/noctalis_items.lua")
dofile(path .. "/noctalis_recipes.lua")

-- optional armor integration
if minetest.get_modpath("3d_armor") then
    dofile(path .. "/armors/noctalis_armors.lua")
end
if minetest.get_modpath("mcl_armor") then
    dofile(path .. "/armors/noctalis_armors_mcl.lua")
end
