local SAPLING_TYPE = "minecraft:spruce_sapling"
local FUEL_TYPE = "minecraft:coal"

local CUTTER_BLOCK = "minecraft:sand"
local TURN_BLOCK = "minecraft:cobblestone"
local HOME_BLOCK = "minecraft:smooth_stone"

local FUEL_SLOT = 16
local SAPLING_SLOT = 15


-- Do not start if not on starting block
local function setup()
    local _sucess, data = turtle.inspectDown()
    if data.name == HOME_BLOCK then
        return true
    end
    return false
end


-- Refuels the turtle if needed, taking logs in case the fuel slot is empty
local function refuel(limit)
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


-- Moves the turtle the given amount of block in the given direction, checking fuel
local function move(direction, amount)
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


-- Checks if the sapling at turtle's right as grown or not
local function checkGrowth()
    local sucess, data = turtle.inspect()
    if not sucess then --Missing sapling
        turtle.select(SAPLING_SLOT)
        turtle.place()
        turtle.select(1)
        return false
    end

    if data.name == SAPLING_TYPE then
        return false
    end
    return true
end


-- Cuts a tree in front of the turtle
local function cutTree()
    turtle.turnLeft()

    if not checkGrowth() then
        turtle.turnRight()
        return false
    end
    
    for height=0,10 do
        turtle.digUp()
        turtle.dig()
        move("up", 1)
    end
    for height=0,10 do
        turtle.digDown()
        move("down", 1)
    end

    -- Place a sapling after the tree is cut
    turtle.select(SAPLING_SLOT)
    turtle.place()
    turtle.select(1)

    turtle.turnRight()
end


-- Checks if the type of the item is the given type
local function isSlotItemType(slot, itemType)
    turtle.select(slot)
    local itemData = turtle.getItemDetail()
    if itemData then
        return itemData.name == itemType
    end
    return false
end


-- Unloads the wood and saves a stack of saplings
local function unload()
    turtle.select(SAPLING_SLOT)
    local saplings_amout = turtle.getItemCount()
    for slot=1,14 do
        if isSlotItemType(slot, SAPLING_TYPE) then
            turtle.transferTo(SAPLING_SLOT, 64-saplings_amout)
            turtle.select(SAPLING_SLOT)
            saplings_amout = turtle.getItemCount()
            turtle.select(slot)
        end
        turtle.drop()
    end
end


-- Loads fuel in the 16th slot, throwing what's in it if not fuel type
local function loadFuel()
    if not isSlotItemType(FUEL_SLOT, FUEL_TYPE) then
        turtle.drop()
    end
    turtle.turnRight()
    local fuel_count = turtle.getItemCount()
    turtle.suck(64 - fuel_count)
    turtle.turnLeft()
    turtle.turnLeft()
end


-- Sorts the turtle inventory, emptying the cutted blocks and gathering coal if needed
local function sortInventory()
    turtle.turnLeft()
    local sucked = turtle.suck()
    while sucked do
        sucked = turtle.suck()
    end
    turtle.turnRight()
    unload()
    loadFuel()
    os.sleep(30) -- Avoid wasting fuel
end


-- Checks the block under the turtle and acts depending on the result
local function checkBlock()
    local sucess, data = turtle.inspectDown()
    if data.name == CUTTER_BLOCK then
        cutTree()
    elseif data.name == TURN_BLOCK then
        turtle.turnLeft()
    elseif data.name == HOME_BLOCK then
        sortInventory()
    end
end

function Main()
    if not setup() then
        return -1
    end

    while true do
        move("forward", 2)
        checkBlock()
    end
end

Main()
