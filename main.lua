local Suit = require('lib.suit')
local Context = require('src.context')
local Constants = require('src.constants')

function love.load()
	math.randomseed(os.clock())

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
