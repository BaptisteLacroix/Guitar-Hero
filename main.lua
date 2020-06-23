--lien couleurs http://doc.instantreality.org/tools/color_calculator/

local config = require("config")
interfaceGameMenu = require("menu")
interfaceGameSettings = require("./settings/settings")
interfaceGameInDifficulty = require("./settings/settingsDifficulty")
interfaceGameIn = require("game")
interfaceGameInEasy = require("./difficulty/gameEasy")
interfaceGameInHard = require("./difficulty/gameHard")


local core = config.getCore()
local key = config.getKey()


-- Color multipler
local COLOR_MUL = love._version >= "11.0" and 1 or 255

function key.setting()
	-- Setup keys config
	key[0], key[1], key[2], key[3] = {}, {}, {}, {}
	key[0].x = 800
	key[0].y = -50
	key[0].width = 50
	key[0].height = 50
	key[0].mode = 0
	key[1].x = 880
	key[1].y = -50
	key[1].width = 50
	key[1].height = 50
	key[1].mode = 0
	key[2].x = 960
	key[2].y = -50
	key[2].width = 50
	key[2].height = 50
	key[2].mode = 0
	key[3].x = 1041
	key[3].y = -50
	key[3].width = 50
	key[3].height = 50
	key[3].mode = 0
end

function memoryCleaner()
	-- Clean memory
	core.mem = core.mem + 1
	if (core.mem == 500) then
		collectgarbage()
	end
end

function love.load()
	-- params
	success = love.window.setMode(1920,1080)
	--constantes
	config.setCurrentInterface(interfaceGameMenu)
	--import states.load
	config.load()
	config.getCurrentInterface().load()
end

function love.update(dt)
	interface = config.getCurrentInterface()
	if interface == interfaceGameIn then
		interface.update(dt)
	end
end

function love.draw()
	config.getCurrentInterface().draw()
end

function love.keypressed(key)
	interface = config.getCurrentInterface()
	if interface == interfaceGameIn then
		interface.keypressed(key)
	end
end

function love.keyreleased(key)
	interface = config.getCurrentInterface()
	if interface == interfaceGameIn then
		interface.keyreleased(key)
	end
end