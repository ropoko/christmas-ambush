local Suit = require('lib.suit')
local Camera = require('lib.camera')
local Context = require('src.context')
local Constants = require('src.constants')

function love.load()
	CONTEXT = Context;
	love.window.setMode(Constants.WINDOW_SETTINGS.width, Constants.WINDOW_SETTINGS.height, { resizable = true })
	-- Camera:setLockedResolution(Constants.WINDOW_SETTINGS.width, Constants.WINDOW_SETTINGS.height)
end

function love.update(dt)
	CONTEXT:update(dt)
end

function love.draw()
	-- Camera:set()
	CONTEXT:draw()

	-- TEST: resolution
	-- love.graphics.setColor(1,0,0)
	-- love.graphics.rectangle('fill', 0, 0, Camera.width, 4)
	-- love.graphics.rectangle('fill', 0, 0, 4, Camera.height)
	-- love.graphics.rectangle('fill', Camera.width-4, 0, 4, Camera.height)
	-- love.graphics.rectangle('fill', 0, Camera.height-4, Camera.width, 4)
	-- love.graphics.setColor(1,1,1)
	-- END TEST ------------------

	Suit.draw()

	-- Camera:unset()
end

function love.resize(w,h)
	Constants.WINDOW_SETTINGS.width = w
	Constants.WINDOW_SETTINGS.height = h
end
