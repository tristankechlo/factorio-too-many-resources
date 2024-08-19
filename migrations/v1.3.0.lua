
for index, force in pairs(game.forces) do
    local technologies = force.technologies
    local recipes = force.recipes
    
    if technologies["tmr-void-technology"].researched then
        -- unlock added recipes for already researched technologies
        log("[Too Many Resources] 'Migrations v1.3.0' enabling the recipe 'tmr-fluid-destroyer' because 'tmr-void-technology' was already researched")
        recipes["tmr-fluid-destroyer"].enabled = true
    end
end
