_G.GAME = require 'config.game'
_G.DIMENSIONS = require 'config.dimensions'
_G.MAPS = require 'config.maps'

_G.CAMERA = nil
_G.CURRENT_MAP = nil

_G.DEBUG_GAME = true

local menu = require 'states.menu'
local stageSelect = require 'states.stage_select'
local play = require 'states.play'
local pause = require 'states.pause'

local state = nil
 
function love.load()
	love.window.setMode(_G.GAME.SCREEN_WIDTH, _G.GAME.SCREEN_HEIGHT, { fullscreen = _G.GAME.IS_FULLSCREEN or false })

	state = play
	state.load()
end
 
function love.update(dt)
	local message = state.update(dt)

	-- local music = love.audio.newSource('resources/music/wiiu_final.ogg', 'stream')
	-- music:setVolume(1.0)
	-- music:play()

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

-- Tasks
-- Implement camera system
	-- Ensure that camera facilitates smaller screen sizes
-- Figure out physics and collision detection
-- Add states component/system
-- Add animations/animation system
-- Add music/sound effects
-- Add dashing/wavedashing
-- Add bullets/targets destruction/point system/progress tracking
-- Add level listing/selection view