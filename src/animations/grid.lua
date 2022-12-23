-- get the assets and split each frame (preparation for animation)

local anim8 = require('lib.anim8')
local Assets = require('src.animations.assets')

local Grid = {
	santa = {
		idle = {
			up = anim8.newGrid(64, 64, Assets.santa.idle.up:getWidth(), Assets.santa.idle.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.santa.idle.down:getWidth(), Assets.santa.idle.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.santa.idle.left:getWidth(), Assets.santa.idle.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.santa.idle.right:getWidth(), Assets.santa.idle.right:getHeight())
		},
		walk = {
			up = anim8.newGrid(64, 64, Assets.santa.walk.up:getWidth(), Assets.santa.walk.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.santa.walk.down:getWidth(), Assets.santa.walk.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.santa.walk.left:getWidth(), Assets.santa.walk.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.santa.walk.right:getWidth(), Assets.santa.walk.right:getHeight())
		}
	}
}

return Grid
