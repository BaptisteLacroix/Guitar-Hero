local config = require(".config")
local geometry = require(".geometry")

local interfaceGameInDifficulty = {}

function interfaceGameInDifficulty.draw()
    print("interfaceGameInDifficulty draw")
    geometry.drawButton()
end

function interfaceGameInDifficulty.load()

    table.insert(geometry.getButtons(), geometry.newButton(
            "Easy",
            function()
                config.setSpeed(1)
                config.getScoreDown(10)
                config.setCurrentInterface(interfaceGameIn)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Normal",
            function()
                config.setSpeed(3)
                config.getScoreDown(100)
                config.setCurrentInterface(interfaceGameIn)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Hard",
            function()
                config.setSpeed(5)
                config.getScoreDown(200)
                config.setCurrentInterface(interfaceGameIn)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Back",
            function()
                config.setCurrentInterface(interfaceGameSettings)
            end))
end

return interfaceGameInDifficulty