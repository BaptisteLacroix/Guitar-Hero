local config = require(".config")
local geometry = require(".geometry")

local interfaceGameInDifficulty = {}

function interfaceGameInDifficulty.draw()
    geometry.drawButton()
end

function interfaceGameInDifficulty.load()

    table.insert(geometry.getButtons(), geometry.newButton(
            "Easy",
            function()
                config.setSpeed(1)
                CURRENT_SCREEN = "interfaceGameIn"
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Normal",
            function()
                config.setSpeed(3)
                CURRENT_SCREEN = "interfaceGameIn"
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Hard",
            function()
                config.setSpeed(5)
                CURRENT_SCREEN = "interfaceGameIn"
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Back",
            function()
                CURRENT_SCREEN = "interfaceGameSettings"
            end))
end

return interfaceGameInDifficulty