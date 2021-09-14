local installed_libs = {"utils/fuel.lua", "utils/movement.lua", "harvester.lua"}

START_POS = {0, 0, 0}  -- SET This with the turtle's initial position

local function preinit()
    for counter=1,#installed_libs do
        if io.open(installed_libs[counter], "r") == nil then
            shell.run("wget", "https://raw.githubusercontent.com/Minigrim0/ComputerCraft-Shenanigance/main/harvester/" .. installed_libs, installed_libs)
        end
    end
end

preinit()
local harvester = require 'harvester'

local status = harvester.main()
if ~status then
    io.write("Program ended with an error")
end
