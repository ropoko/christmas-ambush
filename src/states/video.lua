local Video = {}

function Video:load()
	INTRO_STREAM = love.video.newVideoStream('assets/video/intro.ogv')
	INTRO = love.graphics.newVideo(INTRO_STREAM)

	INTRO:play()
end

function Video:draw()
	local sx = love.graphics.getWidth() / INTRO:getWidth()
	local sy = love.graphics.getHeight() / INTRO:getHeight()

	if INTRO:isPlaying() then
		love.graphics.draw(INTRO, 0, 0, 0, sx,sy)
	else
		CONTEXT:change('game')
	end
end

function Video:update(dt) end

return Video
