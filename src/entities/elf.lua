local Utils = require('src.utils')
local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')

local Elf = {
	x = Utils:center(20,20).width,
	y = Utils:center(20,20).height,
	animation = Animation.elf.fixing
}

function Elf:draw()
	self.animation:draw(Assets.elf.fixing, self.x, self.y)
end

function Elf:update(dt)
	self.animation:update(dt)
end

return Elf
