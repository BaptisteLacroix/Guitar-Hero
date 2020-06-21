local config = require("config")
local core = config.getCore()
local key = config.getKey()
local buf = config.getBuf()
local buttons = config.getButtons()

local interfaceGameIn = {}

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
if (math.random(1500) < 25 ) then
    buf[core.touch].anim = 1
end


function key.scrolling()
    for i =0,core.touch do
        -- Scrolling objects
        if (buf[i] ~= nil) then
            buf[i].y = buf[i].y + 3
        end
        -- Reset objects
        if (buf[i] ~= nil and buf[i].y == 600) then
            buf[i].y = nil
            buf[i].x = nil
            buf[i] = nil
        end
    end
end

function interfaceGameIn.keypressed(myKey)
    if myKey == "q" then
        if key.checkClicked(551) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "s" then
        if key.checkClicked(631) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "d" then
        if key.checkClicked(711) == 1 then
            core.score = core.score + 100
            core.combo = core.combo + 1
        else
            core.combo = 0
        end
    end
    if myKey == "f" then
        if key.checkClicked(792) == 1 then
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
end

function core.ui()
    love.graphics.setColor(255, 255, 255, 0.5) -- couleurs corde de la guitare
    love.graphics.rectangle("fill", 551, 0, 60, 800)
    love.graphics.rectangle("fill", 631, 0, 60, 800)
    love.graphics.rectangle("fill", 711, 0, 60, 800)
    love.graphics.rectangle("fill", 792, 0, 60, 800)
end

function animation()
    core['animation'] = {}
    core['animation'].q, core['animation'].s , core['animation'].d,
    core['animation'].f = 0, 0.2, 1, 1
    -- love.graphics.setColor(0, 0.2, 1, 1)
end

function interfaceGameIn.keyreleased(key)
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

function interfaceGameIn.draw()
    --love.graphics.draw(core.logo2, 0, 0)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 100, 100)
    core.ui()


    for i = 0, core.touch do
        -- If object exists, print it wish his right color.
        if (buf[i] ~= nil) then
            love.graphics.setColor(255, 0,0, 1)
            love.graphics.rectangle("fill", buf[i].x, buf[i].y, 50, 30)
            if buf[i].y == 580 and core.score>0 then
                core.score = core.score - 10
            end
        end
    end


    love.graphics.setColor(255, 255, 255 ,1)	-- couleur corde horizontal
    love.graphics.rectangle("fill", 551, 512, 301, 38) -- corde horizontal

    -- Score Part
    love.graphics.print("SCORE:", 986, 318, 0, 6, 6)
    love.graphics.print(core.score, 986,368, 0, 6, 6)
    love.graphics.setColor(255, 0, 0, 1)

    -- Combo part
    love.graphics.print("Combo x "..tostring(core.combo,986,310))
    love.graphics.print(core.combo, 300, 310, 0, 8, 8)

    if core.q == 1 then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle("fill", 551, 510, 60, 40)
    end
    if core.s == 1 then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.rectangle("fill", 631, 510, 60, 40)
    end
    if core.d == 1 then
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle("fill", 711, 510, 60, 40)
    end
    if core.f == 1 then
        love.graphics.setColor(0, 0, 1, 1)
        love.graphics.rectangle("fill", 792, 510, 60, 40)
    end
end

function interfaceGameIn.update(dt)
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

return interfaceGameIn