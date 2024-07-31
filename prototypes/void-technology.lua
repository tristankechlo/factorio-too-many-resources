
data:extend({
    {
        type = "technology",
        name = "tmr:void-technology",
        icon = "__too-many-resources__/graphics/technology/void-technology.png",
        icon_size = 64,
        icon_mipmaps = 4,
        prerequisites = {"steel-processing"},
        effects = {
            {type = 'unlock-recipe', recipe = 'tmr:void-chest'},
            {type = 'unlock-recipe', recipe = 'tmr:void-pipe'}
        },
        unit = {
            count = 100,
            ingredients = {
                {"automation-science-pack", 1}, {"logistic-science-pack", 1}
            },
            time = 30 -- time it takes for one unit to be consumed
        }
    }
})
