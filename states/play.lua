-- Local module
local playState = {};

-- Dependencies - Works from project root
local sti = require "libraries.sti.sti"
local playerUtils = require "entities.player"
local platformUtils = require "entities.platform"

-- Local Variables
local platforms = {}
local player = nil
local world = nil

function playState.load()
	-- windowWidth  = love.graphics.getWidth()
	-- windowHeight = love.graphics.getHeight()

	-- Set world meter size (in pixels)
	love.physics.setMeter(32)

	-- Load a map exported to Lua from Tiled
	map = sti("resources/maps/test.lua", { "box2d" })
  world = love.physics.newWorld(0, 10 * love.physics.getMeter(), true)
  -- world:setGravity(0, 10)
	-- map:box2d_init(world)

	local spawnLayer = map.layers["Spawns"]
	
	for k, object in pairs(map.objects) do
		if object.name == "Player" or object.type == "Player" then
      print('Got player!')
      player = playerUtils.spawnPlayer(object, world)
      -- world.new
    end
  end
  
  local platformLayer = map.layers["Platforms"]

  for y=1, #platformLayer.data do
    for x=1, #platformLayer.data[y] do
      if platforms[x] == nil then
        platforms[x] = {}
      end

      local tile = platformLayer.data[y][x]

      if tile then
        platforms[x][y] = platformUtils.spawnPlatform(tile, world)
      end
    end
  end

	-- local spriteLayer = map.layers["Platforms"]
	-- spriteLayer.sprites = {
	-- 	player = {
	-- 		image = love.graphics.newImage("resources/purple.png"),
	-- 		x = 64,
	-- 		y = 64,
	-- 		r = 0,
	-- 	}
	-- }

	-- -- Update callback for Custom Layer
	-- function spriteLayer:update(dt)
	-- 	for _, sprite in pairs(self.sprites) do
	-- 		sprite.r = sprite.r + math.rad(90 * dt)
	-- 	end
	-- end

	-- -- Draw callback for Custom Layer
	-- function spriteLayer:draw()
	-- 	for _, sprite in pairs(self.sprites) do
	-- 		local x = math.floor(sprite.x)
	-- 		local y = math.floor(sprite.y)
	-- 		local r = sprite.r
	-- 		love.graphics.draw(sprite.image, x, y, r)
	-- 	end
	-- end
end
 
function playState.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.quit('Thank you for playing!');
  end
  
  if love.keyboard.isDown('p') then
    return 'pause'
  end

  map:update(dt);
  playerUtils.update(player, dt)
  world:update(dt)
  -- if love.keyboard.isDown('d') then
	-- 	-- This makes sure that the character doesn't go pass the game window's right edge.
	-- 	if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
	-- 		player.x = player.x + (player.speed * dt)
	-- 	end
	-- elseif love.keyboard.isDown('a') then
	-- 	-- This makes sure that the character doesn't go pass the game window's left edge.
	-- 	if player.x > 0 then 
	-- 		player.x = player.x - (player.speed * dt)
	-- 	end
  -- end
  
  -- if love.keyboard.isDown('space') then                     -- Whenever the player presses or holds down the Spacebar:
  --   -- The game checks if the player is on the ground. Remember that when the player is on the ground, Y-Axis Velocity = 0.
  --   if player.y_velocity == 0 then
  --     player.y_velocity = player.jump_height    -- The player's Y-Axis Velocity is set to it's Jump Height.
  --   end
  -- end
end
 
function playState.draw()
	love.graphics.setColor(1, 1, 1)
	map:draw()
 
  playerx, playery = player.body:getPosition()
  -- print(playerx, playery)
  love.graphics.draw(player.img, playerx, playery, 0, 1, 1, 0, 32)
	
	love.graphics.setColor(1, 0, 0)
	-- map:box2d_draw(world)
end

return playState