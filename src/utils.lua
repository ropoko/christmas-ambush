local Constants = require('src.constants')

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

function Utils:top_right(margin_right, margin_top)
	local width = Constants.WINDOW_SETTINGS.width
	-- local height = Constants.WINDOW_SETTINGS.height

	margin_right = margin_right or 0
	margin_top = margin_top or 0

	return {
		width = width - margin_right * 10,
		height = margin_top
	}
end

function Utils:has_collision(x1, y1, w1, h1, x2, y2, w2, h2)
	return (
		x2 < x1 + w1 and
		x1 < x2 + w2 and
		y1 < y2 + h2 and
		y2 < y1 + h1
	)
end

function Utils:randomize_coords()
	local side = love.math.random(0,1)
		local vertical_side = love.math.random(0,1)

		local new_random = love.math.random(0,1)

		local random_x = 0
		local random_y = 0

		-- enemy come from left
		if side == 0 then
			random_x = love.math.random(-10, 0)
		-- enemy come from right
		else
			random_x = love.math.random(Constants.WINDOW_SETTINGS.width, Constants.WINDOW_SETTINGS.width + 10)
		end

		-- enemy come from top
		if vertical_side == 0 then
			random_y = love.math.random(-10, 0)
		-- enemy come from bottom
		else
			random_y = love.math.random(Constants.WINDOW_SETTINGS.height, Constants.WINDOW_SETTINGS.height + 10)
		end

		-- override to be more random
		if new_random == 0 then
			random_x = love.math.random(0,Constants.WINDOW_SETTINGS.width)
		else
			random_y = love.math.random(0,Constants.WINDOW_SETTINGS.height)
		end

		return { random_x = random_x, random_y = random_y}
end

function Utils:top_center(obj_width, margin_top)
	local width = Constants.WINDOW_SETTINGS.width

	obj_width = obj_width or 0
	margin_top = margin_top or 0

	return {
		width = ((width - obj_width) / 2),
		height = margin_top
	}
end

function Utils:left_bottom(margin_left, margin_bottom)
	-- local width = Constants.WINDOW_SETTINGS.width
	local height = Constants.WINDOW_SETTINGS.height

	margin_left = margin_left or 0
	margin_bottom = margin_bottom or 0

	return {
		width = margin_left,
		height = height - margin_bottom
	}
end

function Utils:randomize_coords_on_screen()
	local random_x = love.math.random(0,Constants.WINDOW_SETTINGS.width)
	local random_y = love.math.random(0,Constants.WINDOW_SETTINGS.height)

	return { random_x = random_x, random_y = random_y}
end

return Utils
