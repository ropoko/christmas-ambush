local Shoot = require('src.entities.shoot')
local Utils = require('src.utils')
local Keys = require('src.entities.keys')
local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')
local EnemyCookie = require('src.entities.enemy-cookie')

local Player = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	speed = 5/10,
	width = 64,
	height = 64,
	dash_interval = 1, -- seconds
	last_dash = 0,
	dash_distance = 15,
	last_direction = '',
	life = 100,
	max_life = 100,
	current_animation = Animation.santa.idle.down,
	current_img = Assets.santa.idle.down,
	status = 'idle',
	last_movement = {}
}

function Player:move()
	if love.keyboard.isDown('w') then
		Player.y = Player.y - self.speed

		Player.last_movement.direction = 'y'
		Player.last_movement.signal = '-'

		Player.last_direction = '-y'

		self.current_animation = Animation.santa.walk.up
		self.current_img = Assets.santa.walk.up
	end

	if love.keyboard.isDown('s') then
		Player.y = Player.y + self.speed

		Player.last_movement.direction = 'y'
		Player.last_movement.signal = '+'

		Player.last_direction = '+y'

		self.current_animation = Animation.santa.walk.down
		self.current_img = Assets.santa.walk.down
	end

	if love.keyboard.isDown('a') then
		Player.x = Player.x - self.speed

		Player.last_movement.direction = 'x'
		Player.last_movement.signal = '-'

		Player.last_direction = '-x'

		self.current_animation = Animation.santa.walk.left
		self.current_img = Assets.santa.walk.left
	end

	if love.keyboard.isDown('d') then
		Player.x = Player.x + self.speed

		Player.last_movement.direction = 'x'
		Player.last_movement.signal = '+'

		Player.last_direction = '+x'

		self.current_animation = Animation.santa.walk.right
		self.current_img = Assets.santa.walk.right
	end

	if love.keyboard.isDown('space') then
		self:dash(Player.last_movement.direction, Player.last_movement.signal)
	end

	-- self:dash(last_movement.direction, last_movement.signal)
end

function Player:idle()
	if self.last_direction == '-y' then
		self.current_animation = Animation.santa.idle.up
		self.current_img = Assets.santa.idle.up
	end

	if self.last_direction == '+y' then
		self.current_animation = Animation.santa.idle.down
		self.current_img = Assets.santa.idle.down
	end

	if self.last_direction == '-x' then
		self.current_animation = Animation.santa.idle.left
		self.current_img = Assets.santa.idle.left
	end

	if self.last_direction == '+x' then
		self.current_animation = Animation.santa.idle.right
		self.current_img = Assets.santa.idle.right
	end
end

function Player:dash(direction, signal)
	local execute = {
		['-'] = function (x,y) return x - y end,
		['+'] = function (x,y) return x + y end,
	}

	if (os.time() - Player.last_dash) > Player.dash_interval then
		Player.last_dash = os.time()

		Player[direction] = execute[signal](Player[direction], Player.dash_distance)

		if self.last_direction == '-y' then
			self.current_animation = Animation.santa.dash.up
			self.current_img = Assets.santa.dash.up
		end

		if self.last_direction == '+y' then
			self.current_animation = Animation.santa.dash.down
			self.current_img = Assets.santa.dash.down
		end

		if self.last_direction == '-x' then
			self.current_animation = Animation.santa.dash.left
			self.current_img = Assets.santa.dash.left
		end

		if self.last_direction == '+x' then
			self.current_animation = Animation.santa.dash.right
			self.current_img = Assets.santa.dash.right
		end
	end
end

function Player:shoot()
	local shoot = {
		x = Player.x + (Player.width / 2),
		y = Player.y + (Player.height / 2) - 10,
		size = Shoot.default_size,
		direction = Player.last_direction,
		damage = Shoot.damage
	}

	table.insert(Shoot.all_shoots, shoot)
end

function Player:handle_attack(damage)
	if self.life <= 0 then
		CONTEXT:change('game_over')
	end

	self.life = self.life - damage
end

function Player:lifebar()
	love.graphics.setColor(255/255,29/255,29/255)
	love.graphics.rectangle("line", self.x - 10, self.y - 10, self.max_life, 5)
	love.graphics.rectangle("fill", self.x - 10, self.y - 10, self.life, 5)
	love.graphics.setColor(255,255,255)
end

function Player:draw()
	self:lifebar()

	if self.status == 'dash' then
		Player:dash()
	end

	if self.status == 'walk' then
		Player:move()
	end

	if self.status == 'idle' then
		Player:idle()
	end

	self.current_animation:draw(self.current_img, self.x, self.y)
end

function Player:update(dt)
	self.current_animation:update(dt)
end

function Player:collision_enemies()
	for _,enemy in pairs(EnemyCookie.all_enemies) do
		if enemy.life > 0 then
			if Utils:has_collision(enemy.x,enemy.y,EnemyCookie.width,EnemyCookie.height,
				Player.x,Player.y,Player.width,Player.height) then
				enemy.status = 'attack'
				Player:handle_attack(enemy.damage)
			else
				enemy.status = 'walk'
			end
		end
	end
end

return Player
