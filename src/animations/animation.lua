-- get the grid and transform in animations

local anim8 = require('lib.anim8')
local Grid = require('src.animations.grid')

local Animation = {
	santa = {
		idle = {
			up = anim8.newAnimation(Grid.santa.idle.up('1-4', 1), 0.2),
			down = anim8.newAnimation(Grid.santa.idle.down('1-4', 1), 0.2),
			left = anim8.newAnimation(Grid.santa.idle.left('1-4', 1), 0.2),
			right = anim8.newAnimation(Grid.santa.idle.right('1-4', 1), 0.2)
		},
		walk = {
			up = anim8.newAnimation(Grid.santa.walk.up('1-4', 1), 0.2),
			down = anim8.newAnimation(Grid.santa.walk.down('1-4', 1), 0.2),
			left = anim8.newAnimation(Grid.santa.walk.left('1-8', 1), 0.2),
			right = anim8.newAnimation(Grid.santa.walk.right('1-8', 1), 0.2)
		}
	}
}

return Animation
