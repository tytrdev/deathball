local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

function module.spawnPlatform(object, world, box2d_world)
  local platform = Concord.entity(world)
    :give(Transform, object.x, object.y)
  
  platform:give(Physics, platform[Transform], box2d_world, 'static')
  local platformBody = platform[Physics].body
  platformBody:setCollisionClass('Platform')
  
  return platform
end

return module