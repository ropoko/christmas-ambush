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
		}
	}
}

return Assets
