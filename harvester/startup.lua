local installed_libs = {"utils/fuel.lua", "utils/movement.lua", "harvester.lua"}

START_POS = {0, 0, 0}  -- SET This with the turtle's initial position
GITHUB_BASE_URL = "https://raw.githubusercontent.com/Minigrim0/ComputerCraft-Shenanigance/main/harvester/"

local function preinit()
    for counter=1,#installed_libs do
        if io.open(installed_libs[counter], "r") == nil then
            shell.run("wget", GITHUB_BASE_URL .. installed_libs[counter], installed_libs[counter])
        end
    end
end

preinit()
local harvester = require 'harvester'

local status = harvester.main()
if status == false then
    io.write("Program ended with an error")
end
