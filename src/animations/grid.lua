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
		},
		dash = {
			up = anim8.newGrid(64, 64, Assets.santa.dash.up:getWidth(), Assets.santa.dash.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.santa.dash.down:getWidth(), Assets.santa.dash.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.santa.dash.left:getWidth(), Assets.santa.dash.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.santa.dash.right:getWidth(), Assets.santa.dash.right:getHeight())
		},
		death = anim8.newGrid(64, 64, Assets.santa.death:getWidth(), Assets.santa.death:getHeight()),
		shoot = anim8.newGrid(10,10, Assets.santa.shoot:getWidth(), Assets.santa.shoot:getHeight()),
		power_shoot = anim8.newGrid(10,10, Assets.santa.power_shoot:getWidth(), Assets.santa.power_shoot:getHeight()),
	},
	elf = {
		fixing = anim8.newGrid(20, 42, Assets.elf.fixing:getWidth(), Assets.elf.fixing:getHeight())
	},
	enemy_cookie = {
		walk = {
			up = anim8.newGrid(64, 64, Assets.enemy_cookie.walk.up:getWidth(), Assets.enemy_cookie.walk.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.enemy_cookie.walk.down:getWidth(), Assets.enemy_cookie.walk.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.enemy_cookie.walk.left:getWidth(), Assets.enemy_cookie.walk.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.enemy_cookie.walk.right:getWidth(), Assets.enemy_cookie.walk.right:getHeight())
		},
		attack = {
			up = anim8.newGrid(64, 64, Assets.enemy_cookie.attack.up:getWidth(), Assets.enemy_cookie.attack.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.enemy_cookie.attack.down:getWidth(), Assets.enemy_cookie.attack.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.enemy_cookie.attack.left:getWidth(), Assets.enemy_cookie.attack.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.enemy_cookie.attack.right:getWidth(), Assets.enemy_cookie.attack.right:getHeight())
		},
		death = {
			up = anim8.newGrid(64, 64, Assets.enemy_cookie.death.up:getWidth(), Assets.enemy_cookie.death.up:getHeight()),
			down = anim8.newGrid(64, 64, Assets.enemy_cookie.death.down:getWidth(), Assets.enemy_cookie.death.down:getHeight()),
			left = anim8.newGrid(64, 64, Assets.enemy_cookie.death.left:getWidth(), Assets.enemy_cookie.death.left:getHeight()),
			right = anim8.newGrid(64, 64, Assets.enemy_cookie.death.right:getWidth(), Assets.enemy_cookie.death.right:getHeight())
		}
	},
	sled = anim8.newGrid(100,60, Assets.sled:getWidth(), Assets.sled:getHeight()),
	sled_smoke = anim8.newGrid(20,20, Assets.sled_smoke:getWidth(), Assets.sled_smoke:getHeight())
}

return Grid
