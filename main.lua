local Player = require('Player')

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

	-- if love.keyboard.isDown('space') then
	-- 	Player:shoot()
	-- end

	for _,shoot in pairs(Player.shoots) do
		if shoot.direction == '-y' then
			shoot.y = shoot.y - Player.shoot_speed
		end

		if shoot.direction == '+y' then
			shoot.y = shoot.y + Player.shoot_speed
		end

		if shoot.direction == '-x' then
			shoot.x = shoot.x - Player.shoot_speed
		end

		if shoot.direction == '+x' then
			shoot.x = shoot.x + Player.shoot_speed
		end
	end
end

function love.draw()
	love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)

	for _,shoot in pairs(Player.shoots) do
		love.graphics.circle('fill', shoot.x, shoot.y, shoot.size, shoot.size)
	end
end
