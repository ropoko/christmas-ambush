local Player = require('src.entities.player')
local Shoot = require('src.entities.shoot')
local Sled = require('src.entities.sled')
local Utils = require('src.utils')
local Keys = require('src.entities.keys')
local EnemyCookie = require('src.entities.enemy-cookie')
local Constants = require('src.constants')
local Elf = require('src.entities.elf')

local Game = {}

-- only one shoot per click
function love.keypressed(key)
	if key == Keys.shoot then
		Player:shoot()
	end

	if key == Keys.pause then
		if CONTEXT.current == 'pause' then
			CONTEXT:change('game')
		else
			-- love.graphics.captureScreenshot('screenshot.png')
			love.graphics.captureScreenshot(function(image)
				SCREENSHOT = image
				CONTEXT:change('pause')
			end);
		end
	end
end

function Game:load()
	Game.background_img = love.graphics.newImage('assets/img/game/background-game.png')
	Game.tree = love.graphics.newImage('assets/img/game/tree.png')
end

function Game:update(dt)
	Elf:update(dt)

	Player:update(dt)

	if love.keyboard.isDown(unpack(Keys.move)) then
		Player:move()
	end

	Shoot:move()

	EnemyCookie:update(dt)

	Shoot:update(dt)

	Sled:update(dt)
end

function Game:draw()
	self:draw_background()

	Sled:draw()

	Elf:draw()

	if Player.life <= 0 then
		Player.status = 'death'
	else

		if love.keyboard.isDown('w','a','s','d') then
			Player.status = 'walk'
		else
			Player.status = 'idle'
		end
	end
	-- if love.keyboard.isDown('space') then
	-- 	Player.status = 'dash'

	-- 	Player.current_animation.onLoop = function()
	-- 		Player.status = 'walk'
	-- 	end
	-- end

	-- print(Player.status)

	Player:draw()

	self:draw_trees()

	Shoot:draw()

	-- enemies
	EnemyCookie:draw(5)

	-- check collision shoot x enemies
	EnemyCookie:collision_shoots()

	-- check collision enemies x sled
	EnemyCookie:collision_sled()

	-- check collision player x enemies
	Player:collision_enemies()
end

function Game:draw_background()
	local background_scale_x = love.graphics.getWidth() / self.background_img:getWidth()
	local background_scale_y = love.graphics.getHeight() / self.background_img:getHeight()

	-- draw background
	for i = 0, Constants.WINDOW_SETTINGS.width / self.background_img:getWidth() do
		for j = 0, Constants.WINDOW_SETTINGS.height / self.background_img:getHeight() do
			love.graphics.draw(self.background_img, i * self.background_img:getWidth(), j * self.background_img:getHeight(), 0, background_scale_x, background_scale_y)
		end
	end
end

function Game:draw_trees()
	local center = Utils:center(self.tree:getWidth(), self.tree:getHeight())

	love.graphics.draw(self.tree, center.width - 450, center.height + 100)
	love.graphics.draw(self.tree, center.width - 450, center.height - 300)


	love.graphics.draw(self.tree, center.width + 450, center.height + 100)
	love.graphics.draw(self.tree, center.width + 450, center.height - 300)
end

return Game
