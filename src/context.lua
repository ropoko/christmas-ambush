local Initial = require('src.states.initial')
local Game = require('src.states.game')
local GameOver = require('src.states.game-over')
local Pause = require('src.states.pause')

local Context = {
	states = {
		initial = Initial,
		game = Game,
		game_over = GameOver,
		pause = Pause
	},

	current = 'initial',

	update = function(self, dt)
		return self.states[self.current]:update(dt)
	end,

	draw = function(self)
		return self.states[self.current]:draw()
	end,

	change = function(self, ctx)
		-- TODO: added log file
		print('changing state for: ', ctx)

		if ctx == nil then
			error('Context should not be nil')
		end

		local new_ctx = self.states[ctx]

		if new_ctx ~= nil then
			self.current = ctx
			self.states[self.current]:load()
		else
			error('This context does not exist')
		end
	end
}

return Context
