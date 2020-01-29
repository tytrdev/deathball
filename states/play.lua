-- Local module
local playState = {};

-- Dependencies - Works from project root
local sti = require 'libraries.sti'
local Concord = require 'libraries.concord'
local wf = require 'libraries.windfield'

local playerUtils = require 'entities.player'
local platformUtils = require 'entities.platform'
local targetUtils = require 'entities.target'
local cameraUtils =require 'entities.camera'

local InputSystem = require 'systems.input'
local PhysicsSystem = require 'systems.physics'
local ProjectileSystem = require 'systems.projectile'
local AnimationSystem = require 'systems.animation'
local DrawSystem = require 'systems.draw'
local CameraSystem = require 'systems.camera'

local Transform = require 'components.transform'
local Physics = require 'components.physics'
local Drawable = require 'components.drawable'

local DebugPhysics = require 'libraries.box2debug'

-- Local Variables
local player = nil
local world = nil
local wfworld = nil
local platforms = {}
local targets = {}

SCORE = 0

function playState.load()
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
	wfworld:addCollisionClass('Target')
	wfworld:addCollisionClass('Projectile', {ignores = {'Player'}})

	_G.wfworld = wfworld

	-- Set world meter size (in pixels)
	-- love.physics.setMeter(32)

	-- -- Load a map exported to Lua from Tiled
	map = sti('resources/maps/test.lua')
	map.totalwidth = map.width * map.tilewidth
	map.totalheight = map.height * map.tileheight 
	_G.MAP = map

	local spawnLayer = map.layers['Spawns']
	
	local targetLayer = map.layers['Targets']
	for i, object in pairs(targetLayer.objects) do
		targets[i] = targetUtils.spawnTarget(object, world, wfworld)
	end
	
	-- Load the platforms for this map
	-- Should probably refactor this to be a utility that takes a callback or something
  local platformLayer = map.layers['Platforms']
	for i, v in ipairs(platformLayer.data) do
		for j, v2 in pairs(v) do
				if platforms[i] == nil then
					platforms[i] = {}
				end

				local tile = { x = j * 32, y = i * 32 }
				platforms[i][j] = platformUtils.spawnPlatform(tile, world, wfworld)
		end
	end

	for k, object in pairs(map.objects) do
		if object.name == 'Player' or object.type == 'Player' then
      player = playerUtils.spawnPlayer(object, world, wfworld)
		end
	end

	-- Create camera with a target of player
	_G.CAMERA = cameraUtils.build(world, player)
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
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	-- wfworld:draw()
end

return playState