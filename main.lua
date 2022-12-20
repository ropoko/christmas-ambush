local Shoot = require('shoot')
local Player = require('player')

-- only one shoot per click
function love.keypressed(key)
	if key == 'space' then
		Player:shoot()
	end
end

function love.load()
	love.window.setMode(800, 600)
end

function love.update(dt)
	if love.keyboard.isDown('w', 'a', 's', 'd') then
		Player:move()
	end

	Shoot:move()
end

function love.draw()
	love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)

	for _,shoot in pairs(Shoot.all_shoots) do
		love.graphics.circle('fill', shoot.x, shoot.y, shoot.size, shoot.size)
	end
end
