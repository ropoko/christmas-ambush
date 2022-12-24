local Constants = require('src.constants')
local Utils = require('src.utils')
local Suit = require('lib.suit')

local Finish = {
	background_img = love.graphics.newImage('assets/img/initial/background-menu.png'),
	button_exit = love.graphics.newImage('assets/img/pause/button-exit.png')
}

function Finish:load() end

function Finish:update(dt)
end

function Finish:draw()
	local background_scale_x = love.graphics.getWidth() / self.background_img:getWidth()
	local background_scale_y = love.graphics.getHeight() / self.background_img:getHeight()

	-- draw background
	for i = 0, Constants.WINDOW_SETTINGS.width / self.background_img:getWidth() do
		for j = 0, Constants.WINDOW_SETTINGS.height / self.background_img:getHeight() do
			love.graphics.draw(self.background_img, i * self.background_img:getWidth(), j * self.background_img:getHeight(), 0, background_scale_x, background_scale_y)
		end
	end

	local center_label = Utils:center(200,200)
	Suit.Label('Congratulations!', { font=BIGGER_BASE_FONT, color= {normal = {fg = {1,0,0}}} }, center_label.width - 95, center_label.height - 50)

	local button_center = Utils:center(self.button_exit:getWidth(), self.button_exit:getHeight())
	local exit = Suit.ImageButton(self.button_exit, button_center.width, button_center.height + 100)

	if exit.hit then
		CONTEXT:change('initial')
	end
end

return Finish
