local module = {}

local logger = require 'logger'

function module.spawnPlayer(object, world) 
  local player = {}
  player.x = object.x
  player.y = object.y
  player.img = love.graphics.newImage('resources/purple.png')
  player.speed = 200    
  player.y_velocity = 0        
  player.jump_height = -300
  player.gravity = -500
  player.body = love.physics.newBody( world, player.x, player.y, 'dynamic' )
  return player;
end

function module.update(player, dt)
  -- local x, y = player.body.getPosition(player.body)
  -- player.x = x
  -- player.y = y
  -- logger.debug('Debugging body', player.body)
end

return module;