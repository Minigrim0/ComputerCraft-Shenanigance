local Screen = require "src/screen"

screen = Screen:create()

function drawTitle()
    screen.foreground('f')
    screen.background('b')

    --B
    screen.blit(" ", 2, 2)
    screen.blit(" ", 3, 2)
    screen.blit(" ", 4, 2)

    screen.blit(" ", 2, 3)
    screen.blit(" ", 5, 3)

    screen.blit(" ", 2, 3)
    screen.blit(" ", 3, 3)
    screen.blit(" ", 4, 3)

    screen.blit(" ", 2, 3)
    screen.blit(" ", 5, 3)

    screen.blit(" ", 2, 3)
    screen.blit(" ", 3, 3)
    screen.blit(" ", 4, 3)

    --A

end

function MainMenu()
    local running = true
    while running do
        screen.fill('b')
        screen.blit(" ", 2, 2)
    end
end
