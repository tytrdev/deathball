local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

function module.spawnPlatform(object, world, box2d_world)
  local platform = Concord.entity(world)
    :give(Transform, object.x, object.y)
  
  platform:give(Physics, platform[Transform], box2d_world, 'static')
  local platformBody = platform[Physics].body
  local shape = love.physics.newRectangleShape(32, 32)
  local fixture = love.physics.newFixture(platformBody, shape)
  fixture:setFriction(0)
  
  return platform
end

return module