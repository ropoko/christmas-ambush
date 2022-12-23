local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')

local shoot_animation = Animation.santa.shoot
local power_shoot_animation = Animation.santa.power_shoot

local img_shoot_animation = Assets.santa.shoot
local img_power_shoot_animation = Assets.santa.power_shoot

local Shoot = {
	speed = 4,
	default_size = 5,
	all_shoots = {},
	damage = 7,
	is_power_up = false,
	power_damage = 14
}

function Shoot:draw()
	for _,shoot in pairs(Shoot.all_shoots) do
		if not shoot.is_power_up then
			shoot_animation:draw(img_shoot_animation, shoot.x, shoot.y)
		else
			power_shoot_animation:draw(img_power_shoot_animation, shoot.x, shoot.y)
		end
	end
end

function Shoot:update(dt)
	for _,shoot in pairs(Shoot.all_shoots) do
		if not shoot.is_power_up then
			shoot_animation:update(dt)
		else
			power_shoot_animation:update(dt)
		end
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
