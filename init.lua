-- =========================================================
-- Noctalis Mod
-- Modular mob pack structure
-- Each mob lives in its own folder
-- =========================================================

local path = minetest.get_modpath("noctalis")

-- mod table
noctalis = {}

-- =========================
-- Shared Resources
-- =========================
dofile(path .. "/noctalis_starting_items.lua")
dofile(path .. "/noctalis_decoration.lua")
dofile(path .. "/noctalis_utils.lua")  -- utility functions (AI, movement, etc.)

-- =========================
-- MOB SECTIONS
-- =========================
-- Vespera – Twilight Guardian
dofile(path .. "/mobs/vespera/vespera.lua")

-- future mobs: just create a folder under /mobs/ and dofile it here
-- dofile(path .. "/mobs/nextmob/nextmob.lua")

-- =========================
-- Optional Integrations
-- =========================
-- Boss HUD bar for Vespera or other mobs
if minetest.get_modpath("boss_s_hudbar") then
    dofile(path .. "/mobs/vespera/vespera_bar.lua")
end

-- =========================
-- Recipes, Sigils, Items
-- =========================
dofile(path .. "/noctalis_items.lua")
dofile(path .. "/noctalis_recipes.lua")

-- =========================
-- Optional Armor Integrations
-- =========================
if minetest.get_modpath("3d_armor") then
    dofile(path .. "/armors/noctalis_armors.lua")
end
if minetest.get_modpath("mcl_armor") then
    dofile(path .. "/armors/noctalis_armors_mcl.lua")
end
