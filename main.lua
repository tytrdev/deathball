local menu = require 'states.menu'
local play = require 'states.play'
local pause = require 'states.pause'

local state = nil
 
function love.load()
	love.window.setMode(1920, 1080, { fullscreen = true })

	state = play
	state.load()
end
 
function love.update(dt)
	local message = state.update(dt)

	if message and message == 'play' then
		state = play
		state.load()
	elseif message and message == 'pause' then
		state = pause
		state.load()
	end
end
 
function love.draw()
	state.draw()
end