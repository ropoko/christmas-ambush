local Suit = require('lib.suit')
local Utils = require('src.utils')
local Constants = require('src.constants')

local Pause = {}

function Pause:load()
	Pause.button_resume = love.graphics.newImage('assets/img/pause/button-resume.png')
	Pause.button_exit = love.graphics.newImage('assets/img/pause/button-exit.png')
end

function Pause:update(dt) end

function Pause:draw()
	local center_label = Utils:center(100,100)
	Suit.Label('Pause', center_label.width, center_label.height, 100, 100)

	local button_center = Utils:center(self.button_resume:getWidth(), self.button_resume:getHeight())

	love.graphics.scale(0.8,0.8)

	love.graphics.translate((Constants.WINDOW_SETTINGS.width * 0.8)/7,10)

	local resume = Suit.ImageButton(self.button_resume, button_center.width, button_center.height + 100)
	local exit = Suit.ImageButton(self.button_exit, button_center.width, button_center.height + 200)

	love.graphics.scale(1,1)

	if resume.hit then
		CONTEXT:change('game')
	end

	if exit.hit then
		love.event.quit()
	end
end

return Pause
