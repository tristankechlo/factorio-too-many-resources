data:extend({
    {
        type = "item",
        name = "tmr:void-chest",
        icon = "__too-many-resources__/graphics/void-chest.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "storage",
        order = "a[items]-d[void-chest]",
        place_result = "tmr:void-chest",
        stack_size = 50
    }
})

data:extend({
    {
        type = "recipe",
        name = "tmr:void-chest",
        ingredients = {{"steel-plate", 8}, {"electronic-circuit", 1}},
        energy_required = 1, -- crafting time
        result = "tmr:void-chest"
    }
})

data:extend({
    {
        type = "technology",
        name = "tmr:void-technology",
        icon = "__too-many-resources__/graphics/void-chest-single.png",
        icon_size = 64,
        prerequisites = {"steel-processing"},
        effects = {
            {
                type   = 'unlock-recipe',
                recipe = 'tmr:void-chest'
            }
        },
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            },
            time = 30 -- time it takes for one unit to be consumed
        }
    }
})

data:extend({
    {
        type = "container",
        name = "tmr:void-chest",
        icon = "__too-many-resources__/graphics/void-chest.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.1, result = "tmr:void-chest"},
        max_health = 1,
        corpse = "iron-chest-remnants",
        dying_explosion = "iron-chest-explosion",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        inventory_size = 100,
        open_sound = {
            filename = "__base__/sound/metallic-chest-open.ogg",
            volume = 0.6
        },
        close_sound = {
            filename = "__base__/sound/metallic-chest-close.ogg",
            volume = 0.6
        },
        vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        picture = {
            filename = "__too-many-resources__/graphics/void-chest.png",
            priority = "extra-high",
            x = 64,
            width = 32,
            height = 32
        },
        circuit_wire_connection_point = nil,
        circuit_connector_sprites = nil,
        circuit_wire_max_distance = nil
    }
})

