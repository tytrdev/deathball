-- Local module
local playState = {};

-- Dependencies - Works from project root
local sti = require 'libraries.sti'
local Concord = require 'libraries.concord'

local playerUtils = require 'entities.player'
local platformUtils = require 'entities.platform'
local targetUtils = require 'entities.target'

local InputSystem = require 'systems.input'
local PhysicsSystem = require 'systems.physics'
local DrawSystem = require 'systems.draw'

local Transform = require 'components.transform'
local Physics = require 'components.physics'
local Drawable = require 'components.drawable'

local DebugPhysics = require 'libraries.box2debug'

-- Local Variables
local player = nil
local world = nil
local box2d_world = nil
local platforms = {}
local targets = {}

function playState.load()
	-- Create the World
	world = Concord.world()

	-- Add the Systems
	world:addSystems(InputSystem, PhysicsSystem, DrawSystem)

	-- windowWidth  = love.graphics.getWidth()
	-- windowHeight = love.graphics.getHeight()

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)

	-- -- Load a map exported to Lua from Tiled
	map = sti('resources/maps/test.lua', { 'box2d' })
  box2d_world = love.physics.newWorld(0, 10 * love.physics.getMeter(), true)
  box2d_world:setGravity(0, 20 * love.physics.getMeter())
	map:box2d_init(box2d_world)

	local spawnLayer = map.layers['Spawns']
	
	for k, object in pairs(map.objects) do
		if object.name == 'Player' or object.type == 'Player' then
      print('Got player!')
      player = playerUtils.spawnPlayer(object, world, box2d_world)
		end
	end
	
	local targetLayer = map.layers['Targets']
	for i, object in pairs(targetLayer.objects) do
		print(i, v)
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
	map:update(dt);
	world:emit("update", dt)
end
 
function playState.draw()
	love.graphics.setColor(1, 1, 1)
	map:draw()
	-- map:box2d_draw(box2d_world)

	world:emit("draw")

	DebugPhysics(box2d_world, 0, 0, 1920, 1080)
end

return playState