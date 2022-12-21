local Utils = require('src.utils')
local Camera = require('lib.camera')

local Initial = {}

local music = love.audio.newSource('assets/audio/xmas-jingle-intro.mp3', 'stream')
music:setVolume(0.1)

local background_img = love.graphics.newImage('assets/img/initial/background-menu.png')

function love.mousepressed(x,y,button)
	if button == 1 then
		music:stop()
		CONTEXT:change('game')
	end
end

function Initial:update()
	music:play()
end

function Initial:draw()
	local sx = love.graphics.getWidth() / background_img:getWidth()
	local sy = love.graphics.getHeight() / background_img:getHeight()

	for i = 0, Camera.width / background_img:getWidth() do
		for j = 0, Camera.height / background_img:getHeight() do
			love.graphics.draw(background_img, i * background_img:getWidth(), j * background_img:getHeight(), 0, sx,sy)
		end
	end

	local center = Utils:center(50,50)
	love.graphics.print('press any button to start...', center.width, center.height)
end

return Initial
