local reactor = peripheral.wrap("back")
local screen = peripheral.wrap("top")

-- Buttons
screenOnOffButton = {x=29,y=12,w=1,h=1}
reactorOnOffButton = {x=2,y=3,w=3,h=1}

-- Whether to show information on the screen or not
local screenOn = true
local running = true

local function collide(position, button)
    if position.x >= button.x and position.x < button.x + button.w then
        if position.y >= button.y and position.y < button.y + button.h then
            return true
        end
    end
    return false
end

local function getReactorData()

    local reactorOn = reactor.active()

    local battery = reactor.battery()
    local maxBattery = battery.capacity()
    local storedBattery = battery.stored()
    local percentStored = (storedBattery / maxBattery) * 100

    return {
        reactorOn=reactorOn,
        storedBattery=storedBattery,
        maxBattery=maxBattery,
        percentStored=percentStored
    }
end

local function reactorData(data)
    local width, height = screen.getSize()

    local title = "REACTOR"
    local title_position = (width - #title) / 2

    screen.setCursorPos(title_position, 1)
    screen.setBackgroundColor(colours.black)
    screen.setTextColor(colours.yellow)
    screen.write(title)

    screen.setCursorPos(2, 3)
    if data["reactorOn"] then
        screen.setBackgroundColor(colours.green)
        screen.write("On ")
    else
        screen.setBackgroundColor(colours.red)
        screen.write("Off")
    end
end

local function showScreen(data)
    -- Show on/off button
    local width, height = screen.getSize()
    screen.setCursorPos(width, height)


    if screenOn then
        screen.blit(" ", "0", "d")
        reactorData()
    else
        screen.blit(" ", "0", "e")
    end
end

local function broadcastReactorData(data)

end

local function handleEvents()
    local event, peripheral_name, x, y = os.pullEvent("monitor_touch")
    local position = {x=x, y=y}
    if collide(position, screenOnOffButton) then
        screenOn = not screenOn
    end

    if collide(position, reactorOnOffButton) then
        reactor.setActive(not reactor.active())
    end
end

function Main()
    while running do
        local data = getReactorData()
        showScreen(data)
        broadcastReactorData(data)
        handleEvents()
    end
end

Main()
