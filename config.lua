local config = {}

local core = {}
local key = {}
local buf = {}
local buttons = {}
local speed = 0
local currentInterface = nil

-- width, height = love.window.getDimensions()

function config.getCore()
    return core
end

function config.load()
    -- core
    -- love.graphics.setBackgroundColor(0.443, 0.254, 0.117, 1)  -- Couleur de fond
    core["scene"] = 0 -- Scene : menu /game /other
    --core[""]
    core["touch"] = -1 -- Nbr of items generated by the game
    core["mem"]= 0 -- Garbage collector cycles
    key.setting()
    core["score"] = 0
    core["combo"] = 0
    core["startTime"] = 0
    core["imgGameBackground"] = love.graphics.newImage("/img/gameBackground.jpg")
    core["endTime"] = 215
    love.keyboard.setKeyRepeat(false)
    core["q"] = 0
    core["s"] = 0
    core["d"] = 0
    core["f"] = 0
    core["logo"] = love.graphics.newImage("/img/2.jpg") -- affichage image
end

function config.setSpeed(newSpeed)
    speed = newSpeed
end

function config.getSpeed()
    return speed
end

function config.getKey()
    return key
end

function config.getBuf()
    return buf
end

function config.getButtons()
    return buttons
end

function config.getCurrentInterface()
    return currentInterface
end

function config.setCurrentInterface(newInterface)
    currentInterface = newInterface
end

return config