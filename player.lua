local Shoot = require('shoot')
local Utils = require('utils')

local Player = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	width = 20,
	height = 20,
	speed = 2,
	dash_interval = 2, -- seconds
	last_dash = 0,
	dash_distance = 15,
	last_direction = ''
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

	if love.keyboard.isDown('lctrl') then
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
		direction = Player.last_direction
	}

	table.insert(Shoot.all_shoots, shoot)
end

return Player
