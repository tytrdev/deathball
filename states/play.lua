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
local DrawSystem = require 'systems.draw'
local CameraSystem = require 'systems.camera'

local Transform = require 'components.transform'
local Physics = require 'components.physics'
local Drawable = require 'components.drawable'

local DebugPhysics = require 'libraries.box2debug'

-- Local Variables
local player = nil
local world = nil
local box2d_world = nil
local wfworld = nil
local platforms = {}
local targets = {}

function playState.load()
	-- Create the World
	world = Concord.world()

	-- Add the Systems
	world:addSystems(InputSystem, PhysicsSystem, ProjectileSystem, CameraSystem, DrawSystem)
	_G.world = world
	-- windowWidth  = love.graphics.getWidth()
	-- windowHeight = love.graphics.getHeight()

	wfworld = wf.newWorld(0, 0, true)
	wfworld:setGravity(0, 512)

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)

	-- -- Load a map exported to Lua from Tiled
	map = sti('resources/maps/test.lua')
	map.totalwidth = map.width * map.tilewidth
	map.totalheight = map.height * map.tileheight 
	_G.MAP = map

  box2d_world = love.physics.newWorld(0, 10 * love.physics.getMeter(), true)
	box2d_world:setGravity(0, 20 * love.physics.getMeter())
	_G.box2d_world = box2d_world

	local spawnLayer = map.layers['Spawns']
	
	for k, object in pairs(map.objects) do
		if object.name == 'Player' or object.type == 'Player' then
      player = playerUtils.spawnPlayer(object, world, box2d_world)
		end
	end

	-- Create camera with a target of player
	_G.CAMERA = cameraUtils.build(world, player)
	
	local targetLayer = map.layers['Targets']
	for i, object in pairs(targetLayer.objects) do
		targets[i] = targetUtils.spawnTarget(object, world, box2d_world)
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
				platforms[i][j] = platformUtils.spawnPlatform(tile, world, box2d_world)
		end
	end
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
	
	box2d_world.update(box2d_world, dt)
	world:emit("update", dt)
end

-- TODO: Move a lot of this to the draw system?
-- TODO: Organize globals and depend on those in the drawsystem?
function playState.draw()
	-- wfworld:draw()
	love.graphics.setColor(1, 1, 1)
	-- map:box2d_draw(box2d_world)
	
	local cameraTransform = _G.CAMERA[Transform]
	local x = cameraTransform.position.x
	local y = cameraTransform.position.y

	map:draw(x, y)
	world:emit("draw")

	DebugPhysics(box2d_world, -1 * x, -1 * y, _G.GAME.SCREEN_WIDTH, _G.GAME.SCREEN_HEIGHT)
end

return playState