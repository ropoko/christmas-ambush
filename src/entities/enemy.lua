local Utils = require('src.utils')
local Constants = require('src.constants')

local Enemy = {
	x = 0,
	y = 0,
	width = 20,
	height = 20,
	speed = 2,
	all_enemies = {}
}

-- number of enemies
function Enemy:spawn(qty)
	for _ = 1, qty do
		local random_pos = {
			x = love.math.random(0,Constants.WINDOW_SETTINGS.width),
			y = love.math.random(0,Constants.WINDOW_SETTINGS.height)
		}

		local enemy = {
			x = random_pos.x,
			y = random_pos.y
		}

		table.insert(self.all_enemies, enemy)
	end
end

-- number of enemies
function Enemy:draw(qty)
	if #self.all_enemies ~= qty then
		self:spawn(qty)
	end

	for _, enemy in pairs(self.all_enemies) do
		love.graphics.rectangle('fill', enemy.x, enemy.y, self.width, self.height)
	end
end

return Enemy
