local Camera = require('lib.camera')
local Context = require('src.context')

function love.load()
	CONTEXT = Context;
	love.window.setMode(1280, 657, { resizable = true })
	Camera:setLockedResolution(1280, 657)
end

function love.update(dt)
	CONTEXT:update(dt)
end

function love.draw()
	Camera:set()
	CONTEXT:draw()

	-- TEST: resolution
	-- love.graphics.setColor(1,0,0)
	-- love.graphics.rectangle('fill', 0, 0, Camera.width, 4)
	-- love.graphics.rectangle('fill', 0, 0, 4, Camera.height)
	-- love.graphics.rectangle('fill', Camera.width-4, 0, 4, Camera.height)
	-- love.graphics.rectangle('fill', 0, Camera.height-4, Camera.width, 4)
	-- love.graphics.setColor(1,1,1)
	-- END TEST ------------------

	Camera:unset()
end
