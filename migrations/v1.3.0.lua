
for index, force in pairs(game.forces) do
    local technologies = force.technologies
    local recipes = force.recipes
    
    if technologies["tmr-void-technology"].researched then
        -- unlock added recipes for already researched technologies
        recipes["tmr-fluid-destroyer"].enabled = true
    end
end
