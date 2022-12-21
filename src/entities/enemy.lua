local Utils = require('src.utils')

local Enemy = {
	x = 0,
	y = 0,
	width = 20,
	height = 20,
	speed = 2,
	all_enemies = {}
}

function Enemy:spawn()
	local enemy = {}

	table.insert(self.all_enemies, enemy)
end

return Enemy
