require "util"

local function ensureGlobals()
    if global.too_many_resources == nil then
        global.too_many_resources = {}
    end
    if global.too_many_resources.voidchests == nil then
        global.too_many_resources.voidchests = {}
    end
    if global.too_many_resources.fluiddestroyers == nil then
        global.too_many_resources.fluiddestroyers = {}
    end
end

-- setup globals, only run when the mod is started the first time on a specific savegame
local function on_init()
    global.too_many_resources = global.too_many_resources or {}
    global.too_many_resources.voidchests = global.too_many_resources.voidchests or {}
    global.too_many_resources.fluiddestroyers = global.too_many_resources.fluiddestroyers or {}
end

local function on_built(event)
    local entity = event.created_entity or event.entity or event.destination
    if not entity or not entity.valid then
        return
    end

    if entity.name == "tmr-void-chest" then
        -- game.print("new void-chest was placed", { skip = defines.print_skip.never, color = {r = 255/255, g = 0, b = 0}})
        table.insert(global.too_many_resources.voidchests, entity)
    end
    if entity.name == "tmr-fluid-destroyer" then
        -- game.print("new fluid-destroyer was placed", { skip = defines.print_skip.never, color = {r = 255/255, g = 0, b = 0}})
        table.insert(global.too_many_resources.fluiddestroyers, entity)
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

local function removeFluids(event)
    for i, fluidDestroyer in pairs(global.too_many_resources.fluiddestroyers) do
        -- remove entites that are removed by now
        if not fluidDestroyer.valid then
            table.remove(global.too_many_resources.fluiddestroyers, i)
            goto skip
        end
        -- delete all fluids
        if next(global.too_many_resources.fluiddestroyers[i].get_fluid_contents()) ~= nil then
            global.too_many_resources.fluiddestroyers[i].clear_fluid_inside()
        end
        ::skip::
    end
end

local function on_tick(event)
    -- ensure globals exists, needed because 'on_init' is not done after mod updates and the tables might remain nil
    ensureGlobals()

    -- TODO make time configurable
    -- at 60 fps => 60 ticks = 10 seconds
    if event.tick % 600 == 0 then
        removeItems(event)
        removeFluids(event)
    end
end

script.on_init(on_init)
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
