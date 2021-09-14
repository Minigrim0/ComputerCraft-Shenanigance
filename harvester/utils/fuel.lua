-- Refuels the turtle if needed, taking logs in case the fuel slot is empty
function Refuel(limit)
    local fuelAmount = turtle.getFuelLevel()
    if fuelAmount < limit then
        turtle.select(FUEL_SLOT)
        if turtle.getItemCount == 0 then
            -- Get some wood and move it to the fuel case
            turtle.select(1)
            turtle.transferTo(FUEL_SLOT, 2)
            turtle.select(FUEL_SLOT)
        end
        turtle.refuel()
    end
    turtle.select(1)
end
