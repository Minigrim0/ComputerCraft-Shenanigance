-- local movement = require "utils/movement"

-- Checks that the turtle is in the right place
local function init()
    return true
end

function Main()
    if init() == false then
        return false
    end
end

return {Main=Main}
