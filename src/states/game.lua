local Player = require('src.entities.player')
local Shoot = require('src.entities.shoot')
local Sled = require('src.entities.sled')
local Utils = require('src.utils')
local Keys = require('src.entities.keys')
local Enemy = require('src.entities.enemy')

local Game = {}

-- only one shoot per click
function love.keypressed(key)
	if key == Keys.shoot then
		Player:shoot()
	end
end

function Game:load()
	Sled.life = Sled.max_life
end

function Game:update(dt)
	if love.keyboard.isDown(unpack(Keys.move)) then
		Player:move()
	end

	Shoot:move()
end

function Game:draw()
	love.graphics.draw(Player.img, Player.x, Player.y)

	for i,shoot in pairs(Shoot.all_shoots) do
		love.graphics.rectangle('fill', shoot.x, shoot.y, shoot.size, shoot.size)

		if Utils:has_collision(Sled.x,Sled.y,Sled.width,Sled.height,
					shoot.x,shoot.y,shoot.size,shoot.size) then
			Sled:handle_attack(shoot.damage)
			table.remove(Shoot.all_shoots, i)
		end
	end

	Enemy:draw(5)

	Sled:draw()
end

return Game
