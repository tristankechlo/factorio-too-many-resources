
data:extend({
    {
        type = "item",
        name = "tmr:void-chest",
        icon = "__too-many-resources__/graphics/icon/void-chest.png",
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
        icon = "__too-many-resources__/graphics/technology/void-technology.png",
        icon_size = 64,
        icon_mipmaps = 4,
        prerequisites = {"steel-processing"},
        effects = {{type = 'unlock-recipe', recipe = 'tmr:void-chest'}},
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1}, {"logistic-science-pack", 1}
            },
            time = 30 -- time it takes for one unit to be consumed
        }
    }
})

data:extend({
    {
        type = "container",
        name = "tmr:void-chest",
        icon = "__too-many-resources__/graphics/icon/void-chest.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.2, result = "tmr:void-chest"},
        max_health = 350,
        corpse = "iron-chest-remnants",
        dying_explosion = "iron-chest-explosion",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        fast_replaceable_group = "container",
        inventory_size = 100,
        open_sound = {
            filename = "__base__/sound/metallic-chest-open.ogg",
            volume = 0.6
        },
        close_sound = {
            filename = "__base__/sound/metallic-chest-close.ogg",
            volume = 0.6
        },
        vehicle_impact_sound = {
            filename = "__base__/sound/car-metal-impact.ogg",
            volume = 0.65
        },
        picture = {
            layers = {
                {
                    filename = "__too-many-resources__/graphics/entity/void-chest.png",
                    priority = "extra-high",
                    size = {34, 42},
                    shift = {0 / 32, -3 / 32},
                    hr_version = {
                        filename = "__too-many-resources__/graphics/entity/hr-void-chest.png",
                        priority = "extra-high",
                        size = {68, 84},
                        shift = {0 / 32, -3 / 32},
                        scale = 0.5
                    }
                }, {
                    filename = "__base__/graphics/entity/infinity-chest/infinity-chest-shadow.png",
                    priority = "extra-high",
                    size = {58, 24},
                    shift = {12 / 32, 6 / 32},
                    draw_as_shadow = true,
                    hr_version = {
                        filename = "__base__/graphics/entity/infinity-chest/hr-infinity-chest-shadow.png",
                        priority = "extra-high",
                        size = {116, 48},
                        shift = {12 / 32, 6 / 32},
                        draw_as_shadow = true,
                        scale = 0.5
                    }
                }
            }
        },
        resistances = {
            {type = "fire", percent = 90}, {type = "impact", percent = 60}
        },
        circuit_wire_connection_point = nil,
        circuit_connector_sprites = nil,
        circuit_wire_max_distance = nil,
        se_allow_in_space = true
    }
})

