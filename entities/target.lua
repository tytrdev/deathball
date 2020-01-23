local module = {}

local Concord = require 'libraries.concord'
local Drawable = require 'components.drawable'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

function module.spawnTarget(object, world, box2d_world)
  local target = Concord.entity(world)
    :give(Drawable, love.graphics.newImage('resources/target.png'))
    :give(Transform, object.x, object.y)

  target:give(Physics, target[Transform], box2d_world, 'static')

  local targetBody = target[Physics].body
  targetBody:setFixedRotation(true)
  
  local shape = love.physics.newCircleShape(20)
  local fixture = love.physics.newFixture(targetBody, shape) 
  fixture:setFriction(10)
  fixture:setSensor(true)
  
  return target
end

return module