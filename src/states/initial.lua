local Utils = require('src.utils')

local Initial = {}

function love.mousepressed(x,y,button)
	if button == 1 then
		CONTEXT:change('game')
	end
end

function Initial:update() end

function Initial:draw()
	local center = Utils:center(50,50)

	love.graphics.print('press any button to start...', center.width, center.height)
end

return Initial
