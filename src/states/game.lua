local Player = require('src.entities.player')
local Shoot = require('src.entities.shoot')
local Sled = require('src.entities.sled')
local Utils = require('src.utils')
local Keys = require('src.entities.keys')
local EnemyCookie = require('src.entities.enemy-cookie')
local Constants = require('src.constants')
local Elf = require('src.entities.elf')
local Suit = require('lib.suit')
local EnemySnowman = require('src.entities.enemy-snowman')

local Game = {
	actual_wave = 1,
	number_of_waves = 3,
	enemies_per_wave = 5,
	enemies_killed = 0,
	actual_enemy = EnemyCookie
}

-- only one shoot per click
function love.keypressed(key)
	if key == Keys.shoot then
		Player:shoot()
	end

	if key == Keys.pause and CONTEXT.current == 'game' or CONTEXT.current == 'pause' then
		if CONTEXT.current == 'pause' then
			CONTEXT:change('game')
		else
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
	if TRY_AGAIN == true then
		Game:try_again()
	end

	self.enemies_killed = ENEMIES_KILLED

	Elf:update(dt)

	Player:update(dt)

	if love.keyboard.isDown(unpack(Keys.move)) then
		Player:move()
	end

	Shoot:move()

	self.actual_enemy:update(dt)

	Shoot:update(dt)

	Sled:update(dt)
end

function Game:draw()
	self:draw_background()

	self:draw_wave()

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

	Player:draw()

	self:draw_trees()

	Shoot:draw()

	-- enemies
	self.actual_enemy:draw(self.enemies_per_wave)

	-- check collision shoot x enemies
	self.actual_enemy:collision_shoots()

	-- check collision enemies x sled
	self.actual_enemy:collision_sled()

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

function Game:draw_wave()
	local text_wave = 'Wave: '..self.actual_wave..'/'..self.number_of_waves

	local text_enemies = 'Enemies Killed: '..self.enemies_killed..'/'..self.enemies_per_wave

	local text = text_wave..' - '..text_enemies

	local color = { normal = {fg = {1,0,0}} }
	local center_label = Utils:left_bottom(50,25)
	Suit.Label(text, { color=color, font=MEDIUM_BASE_FONT }, center_label.width, center_label.height - 50)
end

function Game:try_again()
	TRY_AGAIN = false

	Sled.life = Sled.max_life
	Player.life = Player.max_life

	self.actual_enemy:clear_enemies()
end

function Game:next_wave()

end

return Game
