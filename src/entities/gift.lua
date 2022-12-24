local Utils = require('src.utils')

local Shoot = require('src.entities.shoot')

local Animation = require('src.animations.animation')
local Assets = require('src.animations.assets')

local Gift = {
	x = Utils:randomize_coords_on_screen().random_x,
	y = Utils:randomize_coords_on_screen().random_y,
	width = 70,
	height = 70,
	max_number = 3,
	should_appear = true,
	gift_collected = false
}

local animation = Animation.gift
local img = Assets.gift

function Gift:draw()
	if self.should_appear and self.gift_collected == false then
		animation:draw(img,self.x,self.y)
	end
end

function Gift:update(dt)
	animation:update(dt)
end

function Gift:collect()
	self.should_appear = false
	self.gift_collected = true

	Shoot.is_power_up = true
end

function Gift:new()
	self.x = Utils:randomize_coords_on_screen().random_x
	self.y = Utils:randomize_coords_on_screen().random_y

	self.should_appear = true
	self.gift_collected = false

	Shoot.is_power_up = false
end

return Gift
