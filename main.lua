_G.GAME = require 'config.game'
_G.DIMENSIONS = require 'config.dimensions'
_G.MAPS = require 'config.maps'

_G.CAMERA = nil
_G.CURRENT_MAP = nil

_G.DEBUG_GAME = true

local menu = require 'states.menu'
local stageselect = require 'states.stage_select'
local play = require 'states.play'
local pause = require 'states.pause'

local Input = require 'config.input'

local gamestate = nil
 
function love.load()
	love.window.setTitle('Melee is terrible')
	love.window.setMode(_G.GAME.SCREEN_WIDTH, _G.GAME.SCREEN_HEIGHT, { fullscreen = _G.GAME.IS_FULLSCREEN or false })

	gamestate = play
	gamestate.load()

	local music = love.audio.newSource('resources/music/wiiu_final.ogg', 'stream')
	music:setVolume(1.0)
	music:play()
end
 
function love.update(dt)
	local message = gamestate.update(dt)

	if message and message == 'play' then
		gamestate = play
		gamestate.load()
	elseif message and message == 'pause' then
		gamestate = pause
		gamestate.load()
	end

	Input.update()
end
 
function love.draw()
	gamestate.draw()
end

-- Tasks
-- Input state tracking system
-- Figure out physics and collision detection
-- Add states component/system
-- Add animations/animation system
-- Add dashing/wavedashing
-- Add bullets/targets destruction/point system/progress tracking
-- Add level listing/selection view