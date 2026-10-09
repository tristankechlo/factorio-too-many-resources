require "util"

local function ensureStorage()
    storage.voidchests = storage.voidchests or {}
    storage.fluiddestroyers = storage.fluiddestroyers or {}
end

-- Setup saved state when the mod is first added to a save.
local function on_init()
    ensureStorage()
end

local function on_built(event)
    local entity = event.created_entity or event.entity or event.destination
    if not entity or not entity.valid then
        return
    end

    if entity.name == "tmr-void-chest" then
        -- game.print("new void-chest was placed", { skip = defines.print_skip.never, color = {r = 255/255, g = 0, b = 0}})
        table.insert(storage.voidchests, entity)
    end
    if entity.name == "tmr-fluid-destroyer" then
        -- game.print("new fluid-destroyer was placed", { skip = defines.print_skip.never, color = {r = 255/255, g = 0, b = 0}})
        table.insert(storage.fluiddestroyers, entity)
    end
end

local function removeItems(event)
    for i, voidchest in pairs(storage.voidchests) do
        -- remove entites that are removed by now
        if not voidchest.valid then
            table.remove(storage.voidchests, i)
            goto skip
        end
        -- clear the inventory
        if storage.voidchests[i].has_items_inside() then
            storage.voidchests[i].clear_items_inside()
        end
        ::skip::
    end
end

local function removeFluids(event)
    for i, fluidDestroyer in pairs(storage.fluiddestroyers) do
        -- remove entites that are removed by now
        if not fluidDestroyer.valid then
            table.remove(storage.fluiddestroyers, i)
            goto skip
        end
        -- delete all fluids
        if next(storage.fluiddestroyers[i].get_fluid_contents()) ~= nil then
            storage.fluiddestroyers[i].clear_fluid_inside()
        end
        ::skip::
    end
end

local function on_tick(event)
    -- TODO make time configurable
    -- at 60 fps => 60 ticks = 10 seconds
    if event.tick % 600 == 0 then
        removeItems(event)
        removeFluids(event)
    end
end

script.on_init(on_init)
script.on_configuration_changed(ensureStorage)
script.on_event(defines.events.on_tick, on_tick)

-- ignore build events for ghost entities
local filter = {
    {filter = "ghost", invert = true}
}
script.on_event(defines.events.on_built_entity, on_built, filter)
script.on_event(defines.events.on_entity_cloned, on_built, filter)
script.on_event(defines.events.on_robot_built_entity, on_built, filter)
script.on_event(defines.events.script_raised_built, on_built, filter)
script.on_event(defines.events.script_raised_revive, on_built, filter)
