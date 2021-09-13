local cases = {}

local function setup()
    while turtle.detect() do
        turtle.turnLeft()
    end
end

local function getWater(case)
    turtle.select(cases["water"])
    local data = turtle.getItemDetail()
    if data.name == "pamh2cfoodcore:freshwateritem" then
        -- Use the already present water
        turtle.transferTo(case)
    else
        turtle.select(cases["bucket"])
        data = turtle.getItemDetail()
    end
end

-- Salt, flour, mixin bowl + water
function craftDough()
    getWater(5)
end

setup()
