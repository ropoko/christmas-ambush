
local Utils = require('utils')

local player = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	width = 20,
	height = 20,
	speed = 2
}

function love.load()
	love.window.setMode(650, 650)
end

function love.update(dt)
	if love.keyboard.isDown('w') then
		player.y = player.y - player.speed
	end

	if love.keyboard.isDown('a') then
		player.x = player.x - player.speed
	end

	if love.keyboard.isDown('s') then
		player.y = player.y + player.speed
	end

	if love.keyboard.isDown('d') then
		player.x = player.x + player.speed
	end
end

function love.draw()
	love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end
