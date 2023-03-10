local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')
local Utils = require('src.utils')

local sled_animation = Animation.sled
local img_sled_animation = Assets.sled

local sled_smoke_animation = Animation.sled_smoke
local img_sled_smoke_animation = Assets.sled_smoke

local Sled = {
	x = Utils:center(70,70).width,
	y = Utils:center(70,70).height,
	width = 70,
	height = 70,
	max_life = 100,
	life = 100
}

function Sled:draw()
	love.graphics.push()
	love.graphics.scale(2,2)
	sled_smoke_animation:draw(img_sled_smoke_animation, (self.x + 10) /2, (self.y - 15)/2)
	love.graphics.scale(1,1)
	love.graphics.pop()

	sled_animation:draw(img_sled_animation, self.x, self.y)
	self:lifebar()
end

function Sled:update(dt)
	sled_smoke_animation:update(dt)
	sled_animation:update(dt)
end

function Sled:lifebar()
	love.graphics.setColor(255/255,29/255,29/255)
	love.graphics.rectangle("line", self.x, self.y + 75, self.max_life, 5)
	love.graphics.rectangle("fill", self.x, self.y + 75, self.life, 5)
	love.graphics.setColor(255,255,255)
end

function Sled:handle_attack(damage)
	if self.life <= 0 then
		CONTEXT:change('game_over')
	end

	self.life = self.life - damage
end

return Sled
