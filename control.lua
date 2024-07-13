require "util"

-- setup globals
local function on_init()
    global.too_many_resources = global.too_many_resources or {}
    global.too_many_resources.voidchests = global.too_many_resources.voidchests or {}
end

local function on_built(event)
    local entity = event.created_entity or event.entity or event.destination
    if not entity or not entity.valid then
        return 
    end

    if entity.name == "tmr:void-chest" then
        table.insert(global.too_many_resources.voidchests, entity)
    end
end

local function removeItems(event)
    for i, voidchest in pairs(global.too_many_resources.voidchests) do
        -- remove entites that are removed by now
        if not voidchest.valid then
            table.remove(global.too_many_resources.voidchests, i)
            goto skip
        end
        -- clear the inventory
        if global.too_many_resources.voidchests[i].has_items_inside() then
            global.too_many_resources.voidchests[i].clear_items_inside()
        end
        ::skip::
    end
end

local function on_tick(event)
    -- TODO make time configurable
    -- at 60 fps => 60 ticks = 10 seconds
    if event.tick % 600 == 0 then
        removeItems(event)
    end
end

script.on_init(on_init)
script.on_event(defines.events.on_tick, on_tick)

-- ignore build events for ghost entities
local filter = {{filter = "ghost", invert = true}, {filter = "name", name = "tmr:void-chest", mode = "and"}}
script.on_event(defines.events.on_built_entity, on_built, filter)
script.on_event(defines.events.on_entity_cloned, on_built, filter)
script.on_event(defines.events.on_robot_built_entity, on_built, filter)
script.on_event(defines.events.script_raised_built, on_built, filter)
script.on_event(defines.events.script_raised_revive, on_built, filter)
