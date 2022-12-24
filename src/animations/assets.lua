-- load the assets

local Assets = {
	santa = {
		idle = {
			up = love.graphics.newImage('assets/img/game/santa/idle-up.png'),
			down = love.graphics.newImage('assets/img/game/santa/idle-down.png'),
			left = love.graphics.newImage('assets/img/game/santa/idle-left.png'),
			right = love.graphics.newImage('assets/img/game/santa/idle-right.png')
		},
		walk = {
			up = love.graphics.newImage('assets/img/game/santa/walk-up.png'),
			down = love.graphics.newImage('assets/img/game/santa/walk-down.png'),
			left = love.graphics.newImage('assets/img/game/santa/walk-left.png'),
			right = love.graphics.newImage('assets/img/game/santa/walk-right.png')
		},
		dash = {
			up = love.graphics.newImage('assets/img/game/santa/dash-up.png'),
			down = love.graphics.newImage('assets/img/game/santa/dash-down.png'),
			left = love.graphics.newImage('assets/img/game/santa/dash-left.png'),
			right = love.graphics.newImage('assets/img/game/santa/dash-right.png')
		},
		death = love.graphics.newImage('assets/img/game/santa/death.png'),
		shoot = love.graphics.newImage('assets/img/game/santa/shoot.png'),
		power_shoot = love.graphics.newImage('assets/img/game/santa/power-shoot.png')
	},
	elf = {
		fixing = love.graphics.newImage('assets/img/game/elf/fixing.png')
	},
	enemy_cookie = {
		walk = {
			up = love.graphics.newImage('assets/img/game/enemy-cookie/walk-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-cookie/walk-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-cookie/walk-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-cookie/walk-right.png')
		},
		attack = {
			up = love.graphics.newImage('assets/img/game/enemy-cookie/attack-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-cookie/attack-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-cookie/attack-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-cookie/attack-right.png')
		},
		death = {
			up = love.graphics.newImage('assets/img/game/enemy-cookie/death-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-cookie/death-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-cookie/death-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-cookie/death-right.png')
		}
	},
	enemy_snowman = {
		walk = {
			up = love.graphics.newImage('assets/img/game/enemy-snowman/walk-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-snowman/walk-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-snowman/walk-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-snowman/walk-right.png')
		},
		attack = {
			up = love.graphics.newImage('assets/img/game/enemy-snowman/attack-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-snowman/attack-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-snowman/attack-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-snowman/attack-right.png')
		},
		death = {
			up = love.graphics.newImage('assets/img/game/enemy-snowman/death-up.png'),
			down = love.graphics.newImage('assets/img/game/enemy-snowman/death-down.png'),
			left = love.graphics.newImage('assets/img/game/enemy-snowman/death-left.png'),
			right = love.graphics.newImage('assets/img/game/enemy-snowman/death-right.png')
		}
	},
	sled = love.graphics.newImage('assets/img/game/sled.png'),
	sled_smoke = love.graphics.newImage('assets/img/game/sled-smoke.png'),
	gift = love.graphics.newImage('assets/img/game/gift.png')
}

return Assets
