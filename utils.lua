local Constants = require('constants')

local Utils = {}

function Utils:center(obj_width, obj_height)
	local width = Constants.WINDOW_SETTINGS.width
	local height = Constants.WINDOW_SETTINGS.height

	obj_width = obj_width or 0
	obj_height = obj_height or 0

	local central = {
		width = ((width - obj_width) / 2),
		height = ((height - obj_height) / 2)
	}

	return central
end

function Utils:has_collision(x1, y1, w1, h1, x2, y2, w2, h2)
	return (
		x2 < x1 + w1 and
		x1 < x2 + w2 and
		y1 < y2 + h2 and
		y2 < y1 + h1
	)
end

return Utils
