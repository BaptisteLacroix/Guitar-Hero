local config = require("config")
local geometry = require("geometry")

local interfaceGameMenu = {}

function interfaceGameMenu.draw()
    print("menu draw")
    geometry.drawButton()
end

function interfaceGameMenu.load()

    table.insert(geometry.getButtons(), geometry.newButton(
            "Start Game",
            function()
                config.setSpeed(3)
                config.setScoreDown(100)
                config.setCurrentInterface(interfaceGameIn)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Settings",
            function()
                config.setCurrentInterface(interfaceGameSettings)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Exit",
            function()
                love.event.quit(0)
            end))
end


return interfaceGameMenu