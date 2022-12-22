local Suit = require('lib.suit')
local Utils = require('src.utils')

local Pause = {}

function Pause:load() end

function Pause:update(dt) end

function Pause:draw()
	local center_label = Utils:center(100,100)
	Suit.Label('Pause', center_label.width, center_label.height, 100, 100)

	local resume = Suit.Button('Resume', center_label.width, center_label.height + 100, 100, 80)
	local exit = Suit.Button('Exit', center_label.width, center_label.height + 200, 100, 80)

	if resume.hit then
		CONTEXT:change('game')
	end

	if exit.hit then
		love.event.quit()
	end
end

return Pause
