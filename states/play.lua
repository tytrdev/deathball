-- Local module
local playState = {};

-- Dependencies - Works from project root
local Concord = require 'libraries.concord'
local wf = require 'libraries.windfield'

local InputSystem = require 'systems.input'
local PhysicsSystem = require 'systems.physics'
local ProjectileSystem = require 'systems.projectile'
local AnimationSystem = require 'systems.animation'
local DrawSystem = require 'systems.draw'
local CameraSystem = require 'systems.camera'

local Transform = require 'components.transform'
local Physics = require 'components.physics'
local Drawable = require 'components.drawable'

local MapUtils = require 'utils.map'
local CameraUtils = require 'entities.camera'

local DebugPhysics = require 'libraries.box2debug'

-- Local Variables
local player = nil
local world = nil
local wfworld = nil
local platforms = {}
local targets = {}

SCORE = 0

function playState.load()
	love.graphics.setFont(love.graphics.newFont(20))

	-- Create the World
	world = Concord.world()

	-- Add the Systems
	world:addSystems(
		InputSystem,
		PhysicsSystem,
		ProjectileSystem,
		CameraSystem,
		AnimationSystem,
		DrawSystem
	)
	_G.world = world

	wfworld = wf.newWorld(0, 0, true)
	wfworld:setGravity(0, 10 * love.physics.getMeter())

	wfworld:addCollisionClass('Player')
	wfworld:addCollisionClass('Platform')
	wfworld:addCollisionClass('OneWayPlatform')
	wfworld:addCollisionClass('Wall')
	wfworld:addCollisionClass('Ramp')
	wfworld:addCollisionClass('Target', {ignores = {'Player'}})
	wfworld:addCollisionClass('Projectile', {ignores = {'Player'}})

	_G.wfworld = wfworld

	-- Set world meter size (in pixels)
	-- love.physics.setMeter(32)

	-- -- Load a map exported to Lua from Tiled
	map, entities = MapUtils.loadMap('resources/maps/test.lua', world, wfworld)
	_G.MAP = map

	-- Create camera with a target of player
	_G.CAMERA = CameraUtils.build(world, entities['Player'])
end
 
function playState.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.quit('Thank you for playing!');
	end
	
	if love.keyboard.isDown('r') then
		playState.load()
	end
  
  if love.keyboard.isDown('p') then
    return 'pause'
	end
	
	wfworld:update(dt)
	world:emit('update', dt)
end

function playState.draw()
	love.graphics.setColor(1, 1, 1)
	
	local cameraTransform = _G.CAMERA[Transform]
	local x = cameraTransform.position.x
	local y = cameraTransform.position.y

	map:draw(x, y)
	world:emit("draw")

	-- print(SCORE)
	love.graphics.setColor(0, 0, 0)

	wfworld:draw()
	love.graphics.origin()
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )))
end

return playState