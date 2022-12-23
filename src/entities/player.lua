local Shoot = require('src.entities.shoot')
local Utils = require('src.utils')
local Keys = require('src.entities.keys')
local anim8 = require('lib.anim8')

local idle_up = love.graphics.newImage('assets/img/game/santa/idle-up.png')
local grid_idle_up = anim8.newGrid(64, 64, idle_up:getWidth(), idle_up:getHeight())
local idle_up_animation = anim8.newAnimation(grid_idle_up('1-4', 1), 0.2)

local idle_down = love.graphics.newImage('assets/img/game/santa/idle-down.png')
local grid_idle_down = anim8.newGrid(64, 64, idle_down:getWidth(), idle_down:getHeight())
local idle_down_animation = anim8.newAnimation(grid_idle_down('1-4', 1), 0.2)

local idle_left = love.graphics.newImage('assets/img/game/santa/idle-left.png')
local grid_idle_left = anim8.newGrid(64, 64, idle_left:getWidth(), idle_left:getHeight())
local idle_left_animation = anim8.newAnimation(grid_idle_left('1-4', 1), 0.2)

local idle_right = love.graphics.newImage('assets/img/game/santa/idle-right.png')
local grid_idle_right = anim8.newGrid(64, 64, idle_right:getWidth(), idle_right:getHeight())
local idle_right_animation = anim8.newAnimation(grid_idle_right('1-4', 1), 0.2)

local Player = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	speed = 2,
	dash_interval = 2, -- seconds
	last_dash = 0,
	dash_distance = 15,
	last_direction = '',
	life = 150,
	max_life = 150,
	current_animation = idle_down_animation,
	current_img = idle_down
}

function Player:move()
	local last_movement = {}

	if love.keyboard.isDown('w') then
		Player.y = Player.y - 1

		last_movement.direction = 'y'
		last_movement.signal = '-'

		Player.last_direction = '-y'
	end

	if love.keyboard.isDown('s') then
		Player.y = Player.y + 1

		last_movement.direction = 'y'
		last_movement.signal = '+'

		Player.last_direction = '+y'
	end

	if love.keyboard.isDown('a') then
		Player.x = Player.x - 1

		last_movement.direction = 'x'
		last_movement.signal = '-'

		Player.last_direction = '-x'
	end

	if love.keyboard.isDown('d') then
		Player.x = Player.x + 1

		last_movement.direction = 'x'
		last_movement.signal = '+'

		Player.last_direction = '+x'
	end

	self:dash(last_movement.direction, last_movement.signal)
end

function Player:dash(direction, signal)
	local execute = {
		['-'] = function (x,y) return x - y end,
		['+'] = function (x,y) return x + y end,
	}

	if love.keyboard.isDown(Keys.dash) then
		if (os.time() - Player.last_dash) > Player.dash_interval then
			Player.last_dash = os.time()

			Player[direction] = execute[signal](Player[direction], Player.dash_distance)
		end
	end
end

function Player:shoot()
	local shoot = {
		x = Player.x,
		y = Player.y,
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
	love.graphics.rectangle("line", self.x, self.y - 10, self.max_life, 5)
	love.graphics.rectangle("fill", self.x, self.y - 10, self.life, 5)
	love.graphics.setColor(255,255,255)
end

function Player:draw()
	self:lifebar()
	self.current_animation:draw(self.current_img, self.x, self.y)
	-- love.graphics.draw(self.img, self.x, self.y)
end

function Player:update(dt)
	self.current_animation:update(dt)
end

return Player
