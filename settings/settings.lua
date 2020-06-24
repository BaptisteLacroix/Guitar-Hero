local config = require(".config")
local geometry = require(".geometry")
interfaceGameInDifficulty = require("./settings/settingsDifficulty")
interfaceGameMenu = require("menu")

local interfaceGameSettings = {}

function interfaceGameSettings.draw()
    print("interfaceGameSettings draw")
    geometry.drawButton()
end

function interfaceGameSettings.load()

    table.insert(geometry.getButtons(), geometry.newButton(
            "Difficulty",
            function()
                interfaceGameInDifficulty.load()
                config.setCurrentInterface(interfaceGameInDifficulty)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Song",
            function()
                -- interfaceGameSong.load()
                -- config.setCurrentInterface(interfaceGameSong)
            end))

    table.insert(geometry.getButtons(), geometry.newButton(
            "Back",
            function()
                config.setCurrentInterface(interfaceGameMenu)
            end))
end

return interfaceGameSettings