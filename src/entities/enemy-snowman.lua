---@diagnostic disable: duplicate-set-field
local Utils = require('src.utils')
local Sled = require('src.entities.sled')

local Shoot = require('src.entities.shoot')

local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')

ENEMIES_KILLED = 0

local EnemySnowman = {
	x = 0,
	y = 0,
	width = 64,
	height = 64,
	speed = 2/10,
	max_life = 50,
	life = 50,
	-- so I know if the enemy was shot
	last_life = 0,
	all_enemies = {},
	damage = 0.1,
	status = 'walk',
	current_animation = Animation.enemy_snowman.walk.left,
	current_img = Assets.enemy_snowman.walk.left,
	last_direction = ''
}

-- called here
function EnemySnowman:attack(enemy)
	if enemy.last_direction == 'up' then
		enemy.current_animation = Animation.enemy_snowman.attack.up
		enemy.current_img = Assets.enemy_snowman.attack.up
	end

	if enemy.last_direction == 'down' then
		enemy.current_animation = Animation.enemy_snowman.attack.down
		enemy.current_img = Assets.enemy_snowman.attack.down
	end

	if enemy.last_direction == 'left' then
		enemy.current_animation = Animation.enemy_snowman.attack.left
		enemy.current_img = Assets.enemy_snowman.attack.left
	end

	if enemy.last_direction == 'right' then
		enemy.current_animation = Animation.enemy_snowman.attack.right
		enemy.current_img = Assets.enemy_snowman.attack.right
	end

	return enemy
end

function EnemySnowman:death(enemy)
	if enemy.last_direction == 'up' then
		enemy.current_animation = Animation.enemy_snowman.death.up
		enemy.current_img = Assets.enemy_snowman.death.up
	end

	if enemy.last_direction == 'down' then
		enemy.current_animation = Animation.enemy_snowman.death.down
		enemy.current_img = Assets.enemy_snowman.death.down
	end

	if enemy.last_direction == 'left' then
		enemy.current_animation = Animation.enemy_snowman.death.left
		enemy.current_img = Assets.enemy_snowman.death.left
	end

	if enemy.last_direction == 'right' then
		enemy.current_animation = Animation.enemy_snowman.death.right
		enemy.current_img = Assets.enemy_snowman.death.right
	end

	return enemy
end

-- called here
function EnemySnowman:move_to_sled(enemy,x,y)
	x = x or 0
	y = y or 0

	local sled_pos = {
		x = Sled.x,
		y = Sled.y
	}

	if (math.ceil(sled_pos.y) > math.ceil(y)) then
		y = y + self.speed

		enemy.current_animation = Animation.enemy_snowman.walk.down
		enemy.current_img = Assets.enemy_snowman.walk.down

		enemy.last_direction = 'down'
	end
	if (math.ceil(sled_pos.y) < math.ceil(y)) then
		y = y - self.speed

		enemy.current_animation = Animation.enemy_snowman.walk.up
		enemy.current_img = Assets.enemy_snowman.walk.up

		enemy.last_direction = 'up'
	end
	if (math.ceil(sled_pos.x) > math.ceil(x)) then
		x = x + self.speed

		enemy.current_animation = Animation.enemy_snowman.walk.right
		enemy.current_img = Assets.enemy_snowman.walk.right

		enemy.last_direction = 'right'
	end
	if (math.ceil(sled_pos.x) < math.ceil(x)) then
		x = x - self.speed

		enemy.current_animation = Animation.enemy_snowman.walk.left
		enemy.current_img = Assets.enemy_snowman.walk.left

		enemy.last_direction = 'left'
	end

	return enemy,x,y
end

-- called here
function EnemySnowman:spawn(qty)
	local new_qty = qty - #self.all_enemies

	for _ = 1, new_qty do
		local enemy = {
			x = Utils:randomize_coords().random_x,
			y = Utils:randomize_coords().random_y,
			life = self.life,
			last_life = self.life,
			damage = self.damage,
			status = self.status,
			current_animation = Animation.enemy_snowman.walk.left,
			current_img = Assets.enemy_snowman.walk.left
		}

		enemy.attack = self:attack(enemy)
		enemy.walk = self:move_to_sled(enemy,enemy.x,enemy.y)

		table.insert(self.all_enemies, enemy)
	end
end

-- called here
function EnemySnowman:lifebar(x,y, life)
	love.graphics.setColor(255/255,29/255,29/255)
	love.graphics.setLineWidth(1)
	love.graphics.rectangle('line', x, y - 10, self.max_life, 5)
	love.graphics.rectangle('fill', x, y - 10, life, 5)
	love.graphics.setColor(1,1,1)
end

-- called in game state
function EnemySnowman:draw(qty)
	if #self.all_enemies ~= qty then
		self:spawn(qty)
	end

	for i, enemy in pairs(self.all_enemies) do
		-- self:lifebar(enemy.x, enemy.y, enemy.life)

		-- used to remove after death
		enemy.id = i

		if enemy.status == 'walk' then
			enemy, enemy.x, enemy.y = self:move_to_sled(enemy, enemy.x, enemy.y)
		end

		if enemy.status == 'attack' then
			enemy = self:attack(enemy)
		end

		if enemy.status == 'death' then
			enemy = self:death(enemy)

			enemy.current_animation.onLoop = function()
				table.remove(self.all_enemies, enemy.id)
				ENEMIES_KILLED = ENEMIES_KILLED + 1
			end
		end

		if enemy.last_life ~= enemy.life then
			love.graphics.setColor(1,0,0)
			enemy.last_life = enemy.life
		end

		enemy.current_animation:draw(enemy.current_img, enemy.x, enemy.y)
		love.graphics.setColor(1,1,1)
	end
end

-- called in game state
function EnemySnowman:update(dt)
	for _,enemy in pairs(self.all_enemies) do
		enemy.current_animation:update(dt)
	end
end

-- called in game state
function EnemySnowman:handle_attack(damage, index_enemy)
	if self.all_enemies[index_enemy].life <= 0 then
		self.all_enemies[index_enemy].status = 'death'
		return
	end

	if (self.all_enemies[index_enemy].life - damage) < 0 then
		self.all_enemies[index_enemy].life = 0
	else
		self.all_enemies[index_enemy].life = self.all_enemies[index_enemy].life - damage
	end

end

function EnemySnowman:collision_shoots()
	for i,shoot in pairs(Shoot.all_shoots) do
		for j,enemy in pairs(EnemySnowman.all_enemies) do
			if Utils:has_collision(enemy.x,enemy.y,self.width,self.height,
					shoot.x,shoot.y,shoot.size,shoot.size) then

			enemy = EnemySnowman:handle_attack(shoot.damage, j)

			table.remove(Shoot.all_shoots, i)
			end
		end
	end
end

function EnemySnowman:collision_sled()
	for _,enemy in pairs(EnemySnowman.all_enemies) do
		if enemy.life > 0  then
			if Utils:has_collision(enemy.x,enemy.y,EnemySnowman.width,EnemySnowman.height,
				Sled.x,Sled.y,Sled.width,Sled.height) then
				enemy.status = 'attack'
				Sled:handle_attack(self.damage)
			end
		end
	end
end

function EnemySnowman:clear_enemies()
	self.all_enemies = {}
end

return EnemySnowman
