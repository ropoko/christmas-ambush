local Suit = require('lib.suit')
local Utils = require('src.utils')
local Constants = require('src.constants')

local Pause = {}

-- local default_save = '/home/ropoko/.local/share/love/gamejam/'
-- local default_save = love.filesystem.getAppdataDirectory()..love.filesystem.getIdentity()..'/'

function Pause:load()
	Pause.button_resume = love.graphics.newImage('assets/img/pause/button-resume.png')
	Pause.button_exit = love.graphics.newImage('assets/img/pause/button-exit.png')
end

function Pause:update(dt)
	if SCREENSHOT ~= nil then
		Pause.screenshot = love.graphics.newImage(SCREENSHOT)
	end
end

function Pause:draw()
	if SCREENSHOT ~= nil then
		self:draw_background()
	end

	local center_label = Utils:center(100,100)
	Suit.Label('Pause', { font=BIGGER_BASE_FONT }, center_label.width - 20, center_label.height - 50)

	local button_center = Utils:center(self.button_resume:getWidth(), self.button_resume:getHeight())

	local resume = Suit.ImageButton(self.button_resume, button_center.width, button_center.height + 100)
	local exit = Suit.ImageButton(self.button_exit, button_center.width, button_center.height + 200)

	if resume.hit then
		CONTEXT:change('game')
	end

	if exit.hit then
		CONTEXT:change('initial')
	end
end

function Pause:draw_background()
	love.graphics.setColor(1,1,1,0.5)
	local sx = love.graphics.getWidth() / Pause.screenshot:getWidth()
	local sy = love.graphics.getHeight() / Pause.screenshot:getHeight()

	for i = 0, Constants.WINDOW_SETTINGS.width / Pause.screenshot:getWidth() do
		for j = 0, Constants.WINDOW_SETTINGS.height / Pause.screenshot:getHeight() do
			love.graphics.draw(Pause.screenshot, i * Pause.screenshot:getWidth(), j * Pause.screenshot:getHeight(), 0, sx, sy)
		end
	end

	love.graphics.setColor(1,1,1,1)
end

return Pause
