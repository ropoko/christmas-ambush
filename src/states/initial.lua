local Suit = require('lib.suit')
local Utils = require('src.utils')
-- local Camera = require('lib.camera')
local Constants = require('src.constants')

local Initial = {}

local music = love.audio.newSource('assets/audio/xmas-jingle-intro.mp3', 'stream')
music:setVolume(0.1)

local background_img = love.graphics.newImage('assets/img/initial/background-menu.png')

local button_play = love.graphics.newImage('assets/img/initial/button-play.png')
local button_play_hover = love.graphics.newImage('assets/img/initial/button-play-hover.png')

local button_sound = love.graphics.newImage('assets/img/button-sound.png')
local button_mute = love.graphics.newImage('assets/img/button-mute.png')

local controls_wasd = love.graphics.newImage('assets/img/initial/controls_wasd.png')
local controls_p = love.graphics.newImage('assets/img/initial/controls_p.png')
local controls_space = love.graphics.newImage('assets/img/initial/controls_space.png')

function Initial:update()
	music:play()
end

function Initial:draw()
	local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
	local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

	-- draw background
	for i = 0, Constants.WINDOW_SETTINGS.width / background_img:getWidth() do
		for j = 0, Constants.WINDOW_SETTINGS.height / background_img:getHeight() do
			love.graphics.draw(background_img, i * background_img:getWidth(), j * background_img:getHeight(), 0, background_scale_x, background_scale_y)
		end
	end

	if Constants.WINDOW_SETTINGS.height >= 600 then
		Initial:draw_opacity_bar()
		Initial:draw_controls()
	end

	local button_center = Utils:center(button_play:getWidth(),button_play:getHeight())
	local play_button = Suit.ImageButton(button_play, { hovered = button_play_hover }, button_center.width, button_center.height + 10)

	if play_button.hit then
		music:stop()
		CONTEXT:change('game')
	end

	Initial:draw_sound_button()
end

function Initial:draw_sound_button()
	local button_top = Utils:top_right(10,10)
	local sound_button = {}

	if music:getVolume() ~= 0 then
		sound_button = Suit.ImageButton(button_sound, button_top.width, button_top.height)
	else
		sound_button = Suit.ImageButton(button_mute, button_top.width, button_top.height)
	end

	self:handle_sound(sound_button)
end

function Initial:handle_sound(sound_button)
	if sound_button.hit then
		if music:getVolume() ~= 0 then
			music:setVolume(0)
		else
			music:setVolume(0.1)
		end
	end
end

function Initial:draw_opacity_bar()
	local sx = love.graphics.getWidth() / Constants.WINDOW_SETTINGS.width
	local sy = love.graphics.getHeight() / Constants.WINDOW_SETTINGS.height

	love.graphics.setColor(0,0,0, 0.6)
	love.graphics.rectangle('fill', 0, Constants.WINDOW_SETTINGS.height - 200, Constants.WINDOW_SETTINGS.width + 1000, 200, 0, sx, sy)
	love.graphics.setColor(1,1,1)
end

function Initial:draw_controls()
	local default_scale = {
		x = 0.8,
		y = 0.8
	}

	local control_wasd_pos = {
		x = 50,
		y = Constants.WINDOW_SETTINGS.height - 180
	}

	local control_space_pos = {
		x = controls_wasd:getWidth() + 50,
		y = Constants.WINDOW_SETTINGS.height - 120
	}

	local control_p_pos = {
		x = controls_space:getWidth() + controls_wasd:getWidth() + 50,
		y = Constants.WINDOW_SETTINGS.height - 120
	}

	love.graphics.draw(controls_wasd, control_wasd_pos.x, control_wasd_pos.y, 0, default_scale.x, default_scale.y)
	love.graphics.draw(controls_space, control_space_pos.x, control_space_pos.y, 0, default_scale.x, default_scale.y)
	love.graphics.draw(controls_p, control_p_pos.x, control_p_pos.y, 0, default_scale.x, default_scale.y)
end

return Initial
