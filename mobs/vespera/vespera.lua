-- =========================================================
-- Vespera – Twilight Guardian
-- Noctalis Mod
-- =========================================================

local path = minetest.get_modpath("noctalis")
local add_velocity_towards = function(obj, target_pos, speed)
    local dir = vector.direction(obj:get_pos(), target_pos)
    obj:set_velocity(vector.multiply(dir, speed))
end

minetest.register_entity("noctalis:vespera", {
    initial_properties = {
        visual = "mesh",
        mesh = "vespera.b3d",
        textures = {"vespera.png"},
        visual_size = {x=1, y=1},
        collisionbox = {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
        physical = true,
        hp_max = 40,
    },

    owner = nil,
    cooldown = 0,

    on_activate = function(self, staticdata)
        self.object:set_armor_groups({fleshy = 80})
    end,

    on_step = function(self, dtime)
        if not self.owner then return end
        local player = minetest.get_player_by_name(self.owner)
        if not player then return end

        local pos = self.object:get_pos()
        local ppos = player:get_pos()
        local dist = vector.distance(pos, ppos)

        -- follow the player if too far
        if dist > 3 then
            add_velocity_towards(self.object, ppos, 2)
        else
            self.object:set_velocity({x=0, y=0, z=0})
        end

        -- cooldown for abilities
        self.cooldown = math.max(0, self.cooldown - dtime)
    end,
})

-- =========================================================
-- Sigil to summon Vespera
-- =========================================================
minetest.register_craftitem("noctalis:sigil_vespera", {
    description = "Sigil of Vespera",
    inventory_image = "sigil.png",
    on_use = function(itemstack, user)
        local pos = user:get_pos()
        pos.y = pos.y + 1

        local ent = minetest.add_entity(pos, "noctalis:vespera")
        local luaent = ent:get_luaentity()
        luaent.owner = user:get_player_name()

        itemstack:take_item()
        return itemstack
    end
})

-- =========================================================
-- Signature Ability: Event Horizon
-- Pulls enemies towards player and launches them
-- =========================================================
minetest.register_on_player_hpchange(function(player, hp_change)
    if hp_change >= 0 then return hp_change end

    local name = player:get_player_name()
    for _, obj in ipairs(minetest.get_objects_inside_radius(player:get_pos(), 6)) do
        local ent = obj:get_luaentity()
        if ent and ent.name == "noctalis:vespera" and ent.owner == name then
            if ent.cooldown <= 0 then
                ent.cooldown = 10
                for _, mob in ipairs(minetest.get_objects_inside_radius(player:get_pos(), 5)) do
                    if mob ~= player and not mob:is_player() then
                        add_velocity_towards(mob, player:get_pos(), 6)
                    end
                end
            end
        end
    end
    return hp_change
                      end)
