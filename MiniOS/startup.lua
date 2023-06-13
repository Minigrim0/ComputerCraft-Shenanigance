local installed_libs = {
    "widgets",
}

GITHUB_BASE_URL = "https://raw.githubusercontent.com/Minigrim0/ComputerCraft-Shenanigance/main/MiniOS/"

local function preinit()
    shell.run("wget", GITHUB_BASE_URL .. "miniOS.lua", "miniOS.lua")
    for counter=1,#installed_libs do
        if io.open(installed_libs[counter], "r") == nil then
            shell.run("wget", GITHUB_BASE_URL .. installed_libs[counter] .. "lib.lua", installed_libs[counter] .. "lib.lua")
       end
    end
end

preinit()
local miniOS = require 'miniOs'

local status = miniOS.main()
if status == false then
    io.write("Program ended with an error")
end
