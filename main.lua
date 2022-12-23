local Suit = require('lib.suit')
local Context = require('src.context')
local Constants = require('src.constants')

-- KEYPRESSED = {}

function love.load()
	math.randomseed(os.clock())

	BASE_FONT = love.graphics.newFont('assets/fonts/Poppins-Regular.ttf', 20)

	CONTEXT = Context;
	love.window.setMode(Constants.WINDOW_SETTINGS.width, Constants.WINDOW_SETTINGS.height, { resizable = true })
	love.window.setTitle('Christmas Ambush')
end

function love.update(dt)
	CONTEXT:update(dt)
end

function love.draw()
	CONTEXT:draw()
	Suit.draw()
end

function love.resize(w,h)
	Constants.WINDOW_SETTINGS.width = w
	Constants.WINDOW_SETTINGS.height = h
end

-- function love.keypressed(key)
-- 	for _,fn in ipairs(KEYPRESSED) do
--     fn(key)
--   end
-- end
