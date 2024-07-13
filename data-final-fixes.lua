
-- remove "basic-tech-card" from research ingredients
-- added by "Krastorio2" during "data-updates.lua"
-- added when the technology only contains "automation-science-pack" and "logistic-science-pack"
if mods["Krastorio2"] then
    local technology = data.raw.technology["tmr:void-technology"] or false

    local ingredients = false
    if technology and technology.unit and technology.unit.ingredients then
      ingredients = technology.unit.ingredients
    end

    -- loop through all ingredients and remove the target one
    if ingredients and #ingredients > 0 then
        for i = 1, #ingredients do
            local ingredient_name = ingredients[i].name or ingredients[i][1]
            if ingredient_name == "basic-tech-card" then
                table.remove(ingredients, i)
                log("[Too Many Resources] Removed 'basic-tech-card' as ingredient from 'tmr:void-technology'")
            end
        end
    end
end
