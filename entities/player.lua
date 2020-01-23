local module = {}

local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Drawable = require 'components.drawable'
local Physics = require 'components.physics'
local Player = require 'components.player'

local logger = require 'logger'

function module.spawnPlayer(object, world, box2d_world) 
  local player = Concord.entity(world)
    :give(Transform, object.x, object.y)
    :give(Drawable, love.graphics.newImage('resources/textures/purple.png'))
    :give(Player)
  
  player:give(Physics, player[Transform], box2d_world, 'dynamic')

  local playerBody = player[Physics].body
  playerBody:setFixedRotation(true)
  
  local shape = love.physics.newRectangleShape(32, 32)
  local fixture = love.physics.newFixture(playerBody, shape) 
  -- fixture:setSensor(true)

  -- local footShape = love.physics.newRectangleShape(2, 32)
  -- local footFixture = love.physics.newFixture(playerBody, footShape);
  -- footFixture:setSensor(true)

  return player;
end

return module;