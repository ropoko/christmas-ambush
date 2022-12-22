local Utils = require('src.utils')
local Constants = require('src.constants')
local Sled = require('src.entities.sled')
local Shoot = require('src.entities.shoot')

local Enemy = {
	x = 0,
	y = 0,
	width = 20,
	height = 20,
	speed = 4/10,
	max_life = 50,
	life = 50,
	all_enemies = {},
	damage = 1
}

-- number of enemies
function Enemy:spawn(qty)
	local new_qty = qty - #self.all_enemies

	for _ = 1, new_qty do
		local side = love.math.random(0,1)
		local vertical_side = love.math.random(0,1)

		local random_x = 0
		local random_y = 0

		-- enemy come from left
		if side == 0 then
			random_x = love.math.random(-10, 0)
		-- enemy come from right
		else
			random_x = love.math.random(Constants.WINDOW_SETTINGS.width, Constants.WINDOW_SETTINGS.width + 10)
		end

		-- enemy come from top
		if vertical_side == 0 then
			random_y = love.math.random(-10, 0)
		-- enemy come from bottom
		else
			random_y = love.math.random(Constants.WINDOW_SETTINGS.height, Constants.WINDOW_SETTINGS.height + 10)
		end

		local enemy = {
			x = random_x,
			y = random_y,
			life = self.life,
			damage = self.damage
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
		self:lifebar(enemy.x, enemy.y, enemy.life)
		love.graphics.rectangle('fill', enemy.x, enemy.y, self.width, self.height)
		enemy.x, enemy.y = self:move_to_sled(enemy.x, enemy.y)
	end
end

function Enemy:move_to_sled(x,y)
	local sled_pos = {
		x = Sled.x,
		y = Sled.y
	}

	if Utils:has_collision(x,y,self.width,self.height,sled_pos.x,sled_pos.y,Sled.width,Sled.height) then
		self:attack()
		return x,y
	end

	if (sled_pos.y > y) then
		y = y + self.speed
	end
	if (sled_pos.y < y) then
		y = y - self.speed
	end
	if (sled_pos.x > x) then
		x = x + self.speed
	end
	if (sled_pos.x < x) then
		x = x - self.speed
	end

	return x,y
end

function Enemy:lifebar(x,y, life)
	love.graphics.setColor(255/255,29/255,29/255)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', x, y - 10, self.max_life, 5)
	love.graphics.rectangle('fill', x, y - 10, life, 5)
	love.graphics.setColor(1,1,1)
end

function Enemy:attack()
	print('attack')
end

function Enemy:handle_attack(damage, index_enemy)
	if self.all_enemies[index_enemy].life <= 0 then
		table.remove(self.all_enemies, index_enemy)
	end

	if (self.all_enemies[index_enemy].life - damage) < 0 then
		self.all_enemies[index_enemy].life = 0
	else
		self.all_enemies[index_enemy].life = self.all_enemies[index_enemy].life - damage
	end
end

return Enemy
