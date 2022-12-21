local Shoot = require('src.entities.shoot')
local Player = require('src.entities.player')
local Sled = require('src.entities.sled')
local Utils = require('src.utils')

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

	for i,shoot in pairs(Shoot.all_shoots) do
		love.graphics.rectangle('fill', shoot.x, shoot.y, shoot.size, shoot.size)

		if Utils:has_collision(Sled.x,Sled.y,Sled.width,Sled.height,
					shoot.x,shoot.y,shoot.size,shoot.size) then
			Sled:handle_attack(shoot.damage)
			table.remove(Shoot.all_shoots, i)
		end
	end

	Sled:draw()
end
