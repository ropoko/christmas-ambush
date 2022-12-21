local Utils = require('src.utils')

local Sled = {
	x = Utils:center(70,70).width,
	y = Utils:center(70,70).height,
	width = 70,
	height = 70,
	max_life = 100,
	life = 100
}

function Sled:draw()
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	self:lifebar()
end

function Sled:lifebar()
	love.graphics.setColor(255/255,29/255,29/255)
	love.graphics.rectangle("line", self.x, self.y - 10, self.max_life, 5)
	love.graphics.rectangle("fill", self.x, self.y - 10, self.life, 5)
	love.graphics.setColor(255,255,255)
end

function Sled:handle_attack(damage)
	if self.life <= 0 then
		CONTEXT:change('game_over')
	end

	self.life = self.life - damage
end

return Sled
