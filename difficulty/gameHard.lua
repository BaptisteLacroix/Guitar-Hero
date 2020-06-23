local config = require("./config")
local core = config.getCore()
local key = config.getKey()
local buf = config.getBuf()
local buttons = config.getButtons()

local interfaceGameInHard = {}

function key.appendBuffer()
    if (math.random(1500) < 25) then
        -- Append number of items.
        core.touch = core.touch + 1
        --Create object depending on key config.
        buf [core.touch]={}
        buf [core.touch].x = key[math.random(4) - 1].x
        buf [core.touch].y = -50
    end
end

function key.scrolling()
    for i =0,core.touch do
        -- Scrolling objects
        if (buf[i] ~= nil) then
            buf[i].y = buf[i].y + 5 --speed
        end
        -- Reset objects
        if (buf[i] ~= nil and buf[i].y == 600) then
            buf[i].y = nil
            buf[i].x = nil
            buf[i] = nil
        end
    end
end

function core.ui()
    love.graphics.setColor(255, 255, 255, 0.5) -- couleurs corde de la guitare
    love.graphics.rectangle("fill", 800, 0, 60, 1080)
    love.graphics.rectangle("fill", 880, 0, 60, 1080)
    love.graphics.rectangle("fill", 960, 0, 60, 1080)
    love.graphics.rectangle("fill", 1041, 0, 60, 1080)
end

function animation()
    core['animation'] = {}
    core['animation'].q, core['animation'].s, core['animation'].d,
    core['animation'].f = 0, 0.2, 1, 1
    -- love.graphics.setColor(0, 0.2, 1, 1)
end

function interfaceGameInHard.keypressed(myKey)
    if myKey == "q" then
        if key.checkClicked(800) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "s" then
        if key.checkClicked(880) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "d" then
        if key.checkClicked(960) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "f" then
        if key.checkClicked(1041) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end

    if myKey == "q" then
        core.q = 1
    end
    if myKey == "s" then
        core.s = 1
    end
    if myKey == "d" then
        core.d = 1
    end
    if myKey == "f" then
        core.f = 1
    end
    animation()
    if key == "escape" then
        CURRENT_SCREEN = "interfaceGameMenu"
    end
end

function interfaceGameInHard.keyreleased(key)
    if key == "q" then
        core.q = 0
    end
    if key == "s" then
        core.s = 0
    end
    if key == "d" then
        core.d = 0
    end
    if key == "f" then
        core.f = 0
    end
end

function key.checkClicked(x)
    for i = 0, core.touch do
        if (buf[i] ~= nil and buf[i].x == x and buf[i].y > 780 and buf[i].y < 830) then
            buf[i].y = nil
            buf[i].x = nil
            buf[i] = nil
            return (1)
        end
    end
    return(0)
end

function key.fadeOut()
    for i = 0, core.touch do
        if (buf[i] ~= nil and buf[i].anim < 1) then
            buf[i].anim = buf[i].anim - 0.1
        end
        if (buf[i] ~= nil and buf[i].anim == 0) then
            buf[i].y = nil
            buf[i].x = nil
            buf[i] = nil
        end
    end
end

function interfaceGameInHard.draw()

    local mouseX, mouseY = love.mouse.getPosition()
    print(mouseX,mouseY)

    --love.graphics.draw(core.imgGameBackground, 0, 0)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 100)
    core.ui()


    for i = 0, core.touch do
        -- If object exists, print it wish his right color.
        if (buf[i] ~= nil) then
            love.graphics.setColor(255, 0,0, 1)
            love.graphics.rectangle("fill", buf[i].x, buf[i].y, 60, 30)
            if buf[i].y == 850 and core.score > 0 then
                core.score = core.score - 10
            end
        end
    end


    love.graphics.setColor(255, 255, 255 ,1)	-- couleur corde horizontal
    love.graphics.rectangle("fill", 800, 800, 301, 38) -- corde horizontal

    -- Score Part
    love.graphics.print("SCORE:", 1600, 318, 0, 6, 6)
    love.graphics.print(core.score, 1600, 380, 0, 6, 6)
    love.graphics.setColor(255, 0, 0, 1)

    -- Combo part
    love.graphics.print("Combo x "..tostring(core.combo,986,310))
    love.graphics.print(core.combo, 300, 310, 0, 8, 8)

    if core.q == 1 then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle("fill", 800, 800, 60, 40)
    end

    if core.s == 1 then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.rectangle("fill", 880, 800, 60, 40)
    end

    if core.d == 1 then
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle("fill", 960, 800, 60, 40)
    end

    if core.f == 1 then
        love.graphics.setColor(0, 0, 1, 1)
        love.graphics.rectangle("fill", 1041, 800, 60, 40)
    end
end

function interfaceGameInHard.update(dt)
    dt = math.min(dt, 1/60)
    if core.scene == 1 then
        if love.timer.getTime() - core.startTime >= core.endTime then
            buf = {}
            love.audio.stop()
            core.scene = 0
        end

        key.appendBuffer()
        key.scrolling()
        memoryCleaner()

        --core["music"] = love.audio.newSource("/sound/AlanWalkerGuitar.mp3", 'stream')
        --love.audio.play(core.music)
    end
    if core.scene == 0 then
        if love.mouse.isDown(1) then
            core.startTime = love.timer.getTime()
            core.scene = 1
        end
    end
end

return interfaceGameInHard