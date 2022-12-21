local Utils = require('src.utils')

local GameOver = {}

function GameOver:load() end

function GameOver:update(dt) end

function GameOver:draw()
	local center = Utils:center(50,50)
	love.graphics.print('try again', center.width, center.height)
end

return GameOver
