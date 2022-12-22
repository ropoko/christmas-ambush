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

	if key == Keys.pause then
		if CONTEXT.current == 'pause' then
			CONTEXT:change('game')
		else
			CONTEXT:change('pause')
		end
	end
end

-- table.insert(KEYPRESSED, function(key)
-- 	if key == Keys.shoot then
-- 		Player:shoot()
-- 	end
-- end)

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
	Player:draw()

	Shoot:draw()
	Enemy:draw(5)
	Sled:draw()

	-- collision shoot x enemies
	for i,shoot in pairs(Shoot.all_shoots) do
		for j,enemy in pairs(Enemy.all_enemies) do
			if Utils:has_collision(enemy.x,enemy.y,Enemy.width,Enemy.height,
					shoot.x,shoot.y,shoot.size,shoot.size) then
			Enemy:handle_attack(shoot.damage, j)
			table.remove(Shoot.all_shoots, i)
			end
		end
	end

	-- collision enemies x sled
	for _,enemy in pairs(Enemy.all_enemies) do
		if Utils:has_collision(enemy.x,enemy.y,Enemy.width,Enemy.height,
				Sled.x,Sled.y,Sled.width,Sled.height) then
			Sled:handle_attack(enemy.damage)
		end
	end

	-- collision player x enemies
	for _,enemy in pairs(Enemy.all_enemies) do
		if Utils:has_collision(enemy.x,enemy.y,Enemy.width,Enemy.height,
				Player.x,Player.y,Player.img:getWidth(),Player.img:getHeight()) then
			Player:handle_attack(enemy.damage)
		end
	end
end

return Game
