local config = require("./config")
local core = config.getCore()
local key = config.getKey()
local buf = config.getBuf()
local buttons = config.getButtons()

local interfaceGameInDifficulty = {}

local buttons = {}
local font = nil

BUTTON_HEIGHT = 64

function interfaceGameInDifficulty.newButton()
    return{
        text = text,
        fn = fn,

        now = false,
        last = false
    }
end

function interfaceGameInDifficulty.draw()
    local button_width = 1920 * (1/3)
    local margin = 16

    local total_height = (BUTTON_HEIGHT + margin) * #buttons
    local cursor_y = 0

    for i, button in ipairs(buttons) do
        button.last = button.now

        local bx = (1920 * 0.5) - (button_width * 0.5)
        local by = (1080 * 0.7) - (BUTTON_HEIGHT * 0.7) - (total_height * 0.5) + cursor_y

        local color = {0.4, 0.4, 0.5, 1.0}

        local mx, my = love.mouse.getPosition()

        local hot = mx > bx and mx < bx + button_width and
                my > by and my < by + BUTTON_HEIGHT

        if hot then
            color = {0.8, 0.8, 0.9, 1.0}
        end

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end

        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
                "fill",
                bx,
                by,
                button_width,
                BUTTON_HEIGHT
        )
        love.graphics.setColor(0, 0, 0, 1)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.print(
                button.text,
                font,
                (1920 * 0.5) - textW * 0.5,
                by + textH * 0.5
        )

        cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
    end
end

function interfaceGameInDifficulty.load()
    font = love.graphics.newFont(32)

    table.insert(buttons, interfaceGameInDifficulty.newButton(
            "Easy",
            function()
                CURRENT_SCREEN = "interfaceGameInEasy"
            end))

    table.insert(buttons, interfaceGameInDifficulty.newButton(
            "Normal",
            function()
                CURRENT_SCREEN = "interfaceGameIn"
            end))

    table.insert(buttons, interfaceGameInDifficulty.newButton(
            "Hard",
            function()
                CURRENT_SCREEN = "interfaceGameInHard"
            end))
end

function interfaceGameInDifficulty.update(dt)

end

return interfaceGameInDifficulty