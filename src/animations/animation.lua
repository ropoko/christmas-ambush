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
		},
		dash = {
			up = anim8.newAnimation(Grid.santa.dash.up('1-6', 1), 0.2),
			down = anim8.newAnimation(Grid.santa.dash.down('1-6', 1), 0.2),
			left = anim8.newAnimation(Grid.santa.dash.left('1-6', 1), 0.2),
			right = anim8.newAnimation(Grid.santa.dash.right('1-6', 1), 0.2)
		},
		death = anim8.newAnimation(Grid.santa.death('1-9', 1), 0.2),
		shoot = anim8.newAnimation(Grid.santa.shoot('1-4', 1), 0.2),
		power_shoot = anim8.newAnimation(Grid.santa.power_shoot('1-4', 1), 0.2)
	},
	elf = {
		fixing = anim8.newAnimation(Grid.elf.fixing('2-4', 1), 0.2)
	},
	enemy_cookie = {
		walk = {
			up = anim8.newAnimation(Grid.enemy_cookie.walk.up('1-14', 1), 0.2),
			down = anim8.newAnimation(Grid.enemy_cookie.walk.down('1-14', 1), 0.2),
			left = anim8.newAnimation(Grid.enemy_cookie.walk.left('1-8', 1), 0.2),
			right = anim8.newAnimation(Grid.enemy_cookie.walk.right('1-8', 1), 0.2)
		},
		attack = {
			up = anim8.newAnimation(Grid.enemy_cookie.attack.up('1-9', 1), 0.2),
			down = anim8.newAnimation(Grid.enemy_cookie.attack.down('1-9', 1), 0.2),
			left = anim8.newAnimation(Grid.enemy_cookie.attack.left('1-9', 1), 0.2),
			right = anim8.newAnimation(Grid.enemy_cookie.attack.right('1-9', 1), 0.2)
		},
		death = {
			up = anim8.newAnimation(Grid.enemy_cookie.death.up('1-11', 1), 0.2),
			down = anim8.newAnimation(Grid.enemy_cookie.death.down('1-11', 1), 0.2),
			left = anim8.newAnimation(Grid.enemy_cookie.death.left('1-11', 1), 0.2),
			right = anim8.newAnimation(Grid.enemy_cookie.death.right('1-11', 1), 0.2)
		}
	},
	sled = anim8.newAnimation(Grid.sled('1-6', 1), 0.3)
}

return Animation
