local Suit = require('lib.suit')
local Utils = require('src.utils')
local Constants = require('src.constants')

local GameOver = {
	button_try_again = love.graphics.newImage('assets/img/button-try-again.png'),
	button_exit = love.graphics.newImage('assets/img/pause/button-exit.png')
}

function GameOver:load()
	if SCREENSHOT ~= nil then
		GameOver.screenshot = love.graphics.newImage(SCREENSHOT)
	end
end

function GameOver:update(dt) end

function GameOver:draw()
	if SCREENSHOT ~= nil then
		self:draw_background()
	end

	local center_label = Utils:center(100,100)
	Suit.Label('Game Over', { font=BIGGER_BASE_FONT }, center_label.width - 40, center_label.height - 50)

	local button_center = Utils:center(self.button_try_again:getWidth(), self.button_try_again:getHeight())

	local try_again = Suit.ImageButton(self.button_try_again, button_center.width - 225, button_center.height + 100)
	local exit = Suit.ImageButton(self.button_exit, button_center.width + 225, button_center.height + 100)

	if try_again.hit then
		TRY_AGAIN = true
		CONTEXT:change('game')
	end

	if exit.hit then
		CONTEXT:change('initial')
	end
end

function GameOver:draw_background()
	love.graphics.setColor(1,1,1,0.5)
	local sx = love.graphics.getWidth() / GameOver.screenshot:getWidth()
	local sy = love.graphics.getHeight() / GameOver.screenshot:getHeight()

	for i = 0, Constants.WINDOW_SETTINGS.width / GameOver.screenshot:getWidth() do
		for j = 0, Constants.WINDOW_SETTINGS.height / GameOver.screenshot:getHeight() do
			love.graphics.draw(GameOver.screenshot, i * GameOver.screenshot:getWidth(), j * GameOver.screenshot:getHeight(), 0, sx, sy)
		end
	end

	love.graphics.setColor(1,1,1,1)
end

return GameOver
