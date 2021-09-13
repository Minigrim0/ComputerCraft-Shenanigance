local Screen = {}

function Screen:create()
    local screen = {}

    screen.term = peripheral.wrap("right")

    function screen:fill(color)
        local size_x, size_y = self.term.getSize()
        for x=1,size_x do
            for y=1,size_y do
                screen.term.setCursorPos(x, y)
                screen.term.blit(" ", "f", color)
            end
        end
    end

    return screen
end

return Screen
