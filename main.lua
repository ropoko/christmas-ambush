local Context = require('src.context')

function love.load()
	CONTEXT = Context;
	love.window.setMode(800, 600)
end

function love.update(dt)
	CONTEXT:update(dt)
end

function love.draw()
	CONTEXT:draw()
end
