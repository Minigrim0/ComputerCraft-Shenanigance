-- Wrapper to move the turtle and keep it fueled
function MoveTo(direction, amount)
    for step=1,amount do
        refuel(50)
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

function Orientation()
    local pos_x, _pos_y, pos_z = gps.locate()
    Move("forward", 1)
end

function MoveTo(position)
    
end
