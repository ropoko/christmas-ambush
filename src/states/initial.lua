local Utils = require('src.utils')

local Initial = {}

local music = love.audio.newSource('assets/audio/xmas-jingle-intro.mp3', 'stream')
music:setVolume(0.1)

function love.mousepressed(x,y,button)
	if button == 1 then
		CONTEXT:change('game')
	end
end

function Initial:update()
	music:play()
end

function Initial:draw()
	local center = Utils:center(50,50)

	love.graphics.print('press any button to start...', center.width, center.height)
end

return Initial
