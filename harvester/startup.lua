local movement = require "utils/movement"

START_POS = {0, 0, 0}  -- SET This with the turtle's initial position

local function preinit()
    if io.open("utils/fuel.lua", "r") == nil then
        shell.run("wget", "")
    end
end

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

local function main()
    if ~init() then
        return false
    end
end

local status = main()
if ~status then
    io.write("Program ended with an error")
end
