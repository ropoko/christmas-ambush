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
end

function Game:draw()
	self:draw_background()

	Elf:draw()

	if love.keyboard.isDown('w','a','s','d') then
		Player.status = 'walk'
	else
		Player.status = 'idle'
	end

	Player:draw()

	self:draw_trees()

	Shoot:draw()

	EnemyCookie:draw(5)

	Sled:draw()

	-- collision shoot x enemies
	for i,shoot in pairs(Shoot.all_shoots) do
		for j,enemy in pairs(EnemyCookie.all_enemies) do
			if Utils:has_collision(enemy.x,enemy.y,EnemyCookie.width,EnemyCookie.height,
					shoot.x,shoot.y,shoot.size,shoot.size) then
			EnemyCookie:handle_attack(shoot.damage, j)
			table.remove(Shoot.all_shoots, i)
			end
		end
	end

	-- collision enemies x sled
	for _,enemy in pairs(EnemyCookie.all_enemies) do
		if Utils:has_collision(enemy.x,enemy.y,EnemyCookie.width,EnemyCookie.height,
				Sled.x,Sled.y,Sled.width,Sled.height) then
			Sled:handle_attack(enemy.damage)
		end
	end

	-- collision player x enemies
	for _,enemy in pairs(EnemyCookie.all_enemies) do
		if Utils:has_collision(enemy.x,enemy.y,EnemyCookie.width,EnemyCookie.height,
				Player.x,Player.y,Player.width,Player.height) then
			Player:handle_attack(enemy.damage)
		end
	end
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
