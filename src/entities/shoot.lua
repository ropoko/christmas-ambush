local Shoot = {
	speed = 4,
	default_size = 5,
	all_shoots = {},
	damage = 7
}

function Shoot:draw()
	for _,shoot in pairs(Shoot.all_shoots) do
		love.graphics.rectangle('fill', shoot.x, shoot.y, shoot.size, shoot.size)
	end
end

function Shoot:move()
	for _,shoot in pairs(Shoot.all_shoots) do
		if shoot.direction == '-y' then
			shoot.y = shoot.y - self.speed
		end

		if shoot.direction == '+y' then
			shoot.y = shoot.y + self.speed
		end

		if shoot.direction == '-x' then
			shoot.x = shoot.x - self.speed
		end

		if shoot.direction == '+x' then
			shoot.x = shoot.x + self.speed
		end
	end
end

return Shoot
