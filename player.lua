
local Utils = require('utils')

local Player = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	width = 20,
	height = 20,
	speed = 2,
	dash_interval = 2, -- seconds
	last_dash = 0
}

function Player:move()
	local last_movement = {}

	if love.keyboard.isDown('w') then
		Player.y = Player.y - 1

		last_movement.direction = 'y'
		last_movement.signal = '-'
	end

	if love.keyboard.isDown('s') then
		Player.y = Player.y + 1

		last_movement.direction = 'y'
		last_movement.signal = '+'
	end

	if love.keyboard.isDown('a') then
		Player.x = Player.x - 1

		last_movement.direction = 'x'
		last_movement.signal = '-'
	end

	if love.keyboard.isDown('d') then
		Player.x = Player.x + 1

		last_movement.direction = 'x'
		last_movement.signal = '+'
	end

	self:dash(last_movement.direction, last_movement.signal)
end

function Player:dash(direction, signal)
	local execute = {
		['-'] = function (x,y) return x - y end,
		['+'] = function (x,y) return x + y end,
	}

	if love.keyboard.isDown('space') then
		if (os.time() - Player.last_dash) > Player.dash_interval then
			Player.last_dash = os.time()

			Player[direction] = execute[signal](Player[direction], 5)
		end
	end
end

return Player
