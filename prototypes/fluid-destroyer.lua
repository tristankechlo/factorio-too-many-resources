
local pictures = {
    layers = {
        {
            filename = "__too-many-resources__/graphics/entity/fluid-destroyer.png",
            priority = "extra-high",
            size = {42, 104},
            shift = {0 / 32, -30 / 32}
        }, {
            filename = "__too-many-resources__/graphics/entity/fluid-destroyer-shadow.png",
            priority = "extra-high",
            size = {81, 42},
            shift = {42 / 32, 0 / 32},
            draw_as_shadow = true
        }
    }
}

local blank = {
    filename = "__core__/graphics/empty.png",
    priority = "extra-high",
    size = {1, 1},
}

data:extend({
    {
        type = "item",
        name = "tmr-fluid-destroyer",
        icon = "__too-many-resources__/graphics/icon/fluid-destroyer.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "production-machine",
        order = "e-d1[fluid-destroyer]",
        place_result = "tmr-fluid-destroyer",
        stack_size = 50
    }
})

data:extend({
    {
        type = "recipe",
        name = "tmr-fluid-destroyer",
        ingredients = {{"pipe", 1}, {"steel-plate", 4}, {"electronic-circuit", 1}},
        energy_required = 1, -- crafting time
        results = {{ type = "item", name = "tmr-fluid-destroyer", amount = 1 }}
    }
})

data:extend({
    {
        type = "storage-tank",
        name = "tmr-fluid-destroyer",
        icon = "__too-many-resources__/graphics/icon/fluid-destroyer.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 0.2, result = "tmr-fluid-destroyer"},
        max_health = 350,
        corpse = "small-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
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
        pictures = {
            picture = {
                north = pictures,
                east = pictures,
                south = pictures,
                west = pictures,
            },
            window_background = blank,
            fluid_background = blank,
            flow_sprite =  blank,
            gas_flow = { -- same as blank, but with 'frame_count'
                filename = "__core__/graphics/empty.png",
                priority = "extra-high",
                size = {1, 1},
                frame_count = 1,
            },
        },
        window_bounding_box = {{0, 0}, {0, 0}},
        flow_length_in_ticks = 1,
        fluid_box = {
            base_area = 5000, -- gets multiplied by 100 (result => 500k)
            height = 1,
            base_level = -1,
            production_type = "input",
            pipe_covers = pipecoverspictures(),
            pipe_connections = {
                {type = "input", position = { 0, 1 }}, -- default connection at the bottom of the entity
            },
        },
        resistances = {
            {type = "fire", percent = 90}, {type = "impact", percent = 60}
        },
        show_fluid_icon = false,
        circuit_wire_connection_point = nil,
        circuit_connector_sprites = nil,
        circuit_wire_max_distance = nil,
        se_allow_in_space = true
    }
})

