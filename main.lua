local Player = require('Player')

function love.load()
	love.window.setMode(650, 650)
end

function love.update(dt)
	if love.keyboard.isDown('w', 'a', 's', 'd') then
		Player:move()
	end
end

function love.draw()
	love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
end
