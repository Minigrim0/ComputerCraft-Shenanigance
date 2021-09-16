local fuel = require 'utils/fuel'

-- Wrapper to move the turtle and keep it fueled
local move = function(direction, amount)
    if direction == "backward" then
        turtle.turnLeft()
        turtle.turnLeft()
        for _step=1,amount do
            fuel.Refuel(50)
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.turnLeft()
    else
        for step=1,amount do
            fuel.refuel(50)
            if direction == "up" then
                turtle.up()
            elseif direction == "down" then
                turtle.down()
            elseif direction == "forward" then
                turtle.forward()
            else
                print("No such direction ", direction)
            end
        end
    end
end

local orientation = function()
    local pos_x, _pos_y, pos_z = gps.locate()
    move("forward", 1)
    local npos_x, _npos_y, npos_z = gps.locate()
    move("backward", 1)

    if pos_x < npos_x then
        return "E"
    elseif npos_x < pos_x then
        return "W"
    elseif pos_z < npos_z then
        return "S"
    elseif npos_z < pos_z then
        return "N"
    end
end

local moveTo = function(position)
    local turtle_orientation = orientation()
end

return {
    MoveTo=moveTo,
    Orientation=orientation,
    move=move
}
