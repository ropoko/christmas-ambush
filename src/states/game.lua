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
local Gift = require('src.entities.gift')

local Game = {
	actual_wave = 1,
	number_of_waves = 3,
	enemies_per_wave = 10,
	enemies_killed = 0,
	actual_enemy = EnemySnowman,
	time_power_up = 11 -- always will consider -1 seconds, so in this case => 10
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
	if Gift.gift_collected then
		Game:timer(dt)
	end

	if TRY_AGAIN == true then
		Game:try_again()
	end

	if ENEMIES_KILLED == self.enemies_per_wave then
		self:next_wave()
	end

	if self.actual_wave == self.number_of_waves then
		self:reset()
		CONTEXT:change('finish')
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

	Gift:update(dt)
end

function Game:draw()
	love.graphics.setLineWidth(1)

	self:draw_background()

	self:draw_wave()

	Gift:draw()

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
	self.actual_enemy:draw(self.enemies_per_wave/2)

	-- check collision shoot x enemies
	self.actual_enemy:collision_shoots()

	-- check collision enemies x sled
	self.actual_enemy:collision_sled()

	-- check collision player x enemies
	Player:collision_enemies(self.actual_enemy)

	-- check collision player x gift
	Player:collision_gift()
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

	ENEMIES_KILLED = 0

	Sled.life = Sled.max_life
	Player.life = Player.max_life

	self.actual_enemy:clear_enemies()
end

function Game:next_wave()
	self.actual_wave = self.actual_wave + 1

	ENEMIES_KILLED = 0
	self.enemies_per_wave = 10 * self.actual_wave

	if self.actual_wave == 2 then
		self.actual_enemy = EnemyCookie
	end

	if self.actual_wave == 3 then
		self.actual_enemy = EnemyCookie
	end
end

function Game:timer(dt)
	if math.floor(self.time_power_up) == 0 then
		Gift:new()
		self.time_power_up = 11
		-- return
	end

	self.time_power_up = self.time_power_up - dt

	local seconds = tostring(math.floor(self.time_power_up % 60))
	local minutes = tostring(math.floor(self.time_power_up / 60))

	if tonumber(seconds) <= 9 then
		seconds = '0'..seconds
	end
	if tonumber(minutes) <= 9 then
		minutes = '0'..minutes
	end

	local time = minutes..':'..seconds

	local color = { normal = {fg = {1,1,1}} }

	local center = Utils:center(100, 200)
	Suit.Label(time, { align='center', font = BASE_FONT, color = color}, center.width, 10, 100, 200)
end

function Game:reset()
	self.actual_wave = 1
	self.enemies_per_wave = 10
	self.actual_enemy = EnemySnowman
end

return Game
