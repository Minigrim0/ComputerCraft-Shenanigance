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

local turnTo = function(current_orientation, wanted_orientation)
    local directions = {"N", "E", "S", "W"}
    local index = 1
    while directions[index] ~= current_orientation do
        index = index + 1
    end

    while current_orientation ~= wanted_orientation do
        turtle.turnLeft()
        index = index + 1
        if index > 4 then
            index = 1
        end
        current_orientation = directions[index]
    end
end

local moveTo = function(position)
    local turtle_orientation = orientation()
    local posx, posy, posz = gps.locate()
    -- +x -> E
    -- -x -> O
    -- +z -> S
    -- -z -> N

    local delta_x = posx - position[1]
    local delta_z = posz - position[3]

    if delta_x > 0 then -- Must go East

    end
end

return {
    MoveTo=moveTo,
    Orientation=orientation,
    move=move
}
