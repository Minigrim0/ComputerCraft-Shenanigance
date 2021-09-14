
local movement = require "utils/movement"

-- Checks that the turtle is in the right place
local function init()
    movement.MoveTo(START_POS)
    local success, bloc_down = turtle.inspectDown()
    if success and bloc_down.name == "minecraft:gravel" then
        local _success, bloc_front = turtle.inspect()
        local counter = 0

        while success or bloc_front.name ~= "minecraft:chest" do
            turtle.turnLeft()
            counter = counter + 1
            if counter == 4 then
                return false
            end
        end
        io.write("Sucessful initialization")
        return true
    end
    return false
end

function Main()
    if init() == false then
        return false
    end
end

return {Main=Main}
