local Suit = require('lib.suit')
local Utils = require('src.utils')
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

local logo_img = love.graphics.newImage('assets/img/initial/logo.png')

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

	Initial:draw_logo()

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

	local default_margin = {
		x = 50,
		y = 120
	}

	local control_wasd_pos = {
		x = 50,
		y = Constants.WINDOW_SETTINGS.height - 180
	}

	local control_space_pos = {
		x = controls_wasd:getWidth() + default_margin.x,
		y = Constants.WINDOW_SETTINGS.height - default_margin.y
	}

	local control_p_pos = {
		x = controls_space:getWidth() + controls_wasd:getWidth() + default_margin.x,
		y = Constants.WINDOW_SETTINGS.height - default_margin.y
	}

	love.graphics.draw(controls_wasd, control_wasd_pos.x, control_wasd_pos.y, 0, default_scale.x, default_scale.y)
	love.graphics.draw(controls_space, control_space_pos.x, control_space_pos.y, 0, default_scale.x, default_scale.y)
	love.graphics.draw(controls_p, control_p_pos.x, control_p_pos.y, 0, default_scale.x, default_scale.y)

	-- draw separator
	love.graphics.line(
		control_p_pos.x + default_margin.x * 3,
		control_p_pos.y - 20,
		control_p_pos.x + default_margin.x * 3,
		control_p_pos.y + 100
	)

	love.graphics.setLineWidth(5)

	Initial:draw_names({ x=control_p_pos.x + default_margin.x * 3, y=control_p_pos.y - 20 })
end

function Initial:draw_names(last_position)
	local x = last_position.x + 50
	local y = last_position.y

	local color = { normal = {fg = {1,1,1}} }

	Suit.Label('Caique Jacomini', { color=color, font=BASE_FONT }, x, y)
	Suit.Label('Henrique Moraes',{ color=color, font=BASE_FONT },x,y + 25)
	Suit.Label('Pablo Maganha',{ color=color, font=BASE_FONT },x,y + 50)
	Suit.Label('Rodrigo Maganha',{ color=color, font=BASE_FONT },x,y + 75)
end

function Initial:draw_logo()
	love.graphics.push()

	love.graphics.scale(0.6,0.6)

	local logo_center = Utils:center(logo_img:getWidth(),logo_img:getHeight())
	love.graphics.draw(logo_img, logo_center.width + 425, logo_center.height - 30)

	love.graphics.scale(1,1)

	love.graphics.pop()
end

return Initial
