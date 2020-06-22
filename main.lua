--lien couleurs http://doc.instantreality.org/tools/color_calculator/

local config = require("config")
interfaceGameMenu = require("menu")
interfaceGameIn = require("game")

local core = config.getCore()
local key = config.getKey()
local buf = config.getBuf()
local buttons = config.getButtons()


-- Color multipler
local COLOR_MUL = love._version >= "11.0" and 1 or 255

function key.setting()
	-- Setup keys config
	key[0], key[1], key[2], key[3] = {}, {}, {}, {}
	key[0].x = 551
	key[0].y = -50
	key[0].width = 50
	key[0].height = 50
	key[0].mode = 0
	key[1].x = 631
	key[1].y = -50
	key[1].width = 50
	key[1].height = 50
	key[1].mode = 0
	key[2].x = 711
	key[2].y = -50
	key[2].width = 50
	key[2].height = 50
	key[2].mode = 0
	key[3].x = 792
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
	CURRENT_SCREEN = "interfaceGameMenu"

	--import states.load
	config.load()
	interfaceGameMenu.load()
	--interfaceGameIn.load()
end

function love.update(dt)
	if CURRENT_SCREEN == "interfaceGameMenu" then
		interfaceGameMenu.update(dt)
	elseif CURRENT_SCREEN == "interfaceGameIn" then
		interfaceGameIn.update(dt)
	end
end

function love.draw()
	if CURRENT_SCREEN == "interfaceGameMenu" then
		interfaceGameMenu.draw()
	elseif CURRENT_SCREEN == "interfaceGameIn" then
		interfaceGameIn.draw()
	end
end

function love.keypressed(key)
	if CURRENT_SCREEN == "interfaceGameMenu" then
		interfaceGameMenu.keypressed(key)
	elseif CURRENT_SCREEN == "interfaceGameIn" then
		interfaceGameIn.keypressed(key)
	elseif key == "escape" then
		CURRENT_SCREEN = "interfaceGameMenu"
	end
end