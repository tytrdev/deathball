local module = {}

local Concord = require 'libraries.concord'
local Drawable = require 'components.drawable'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

function module.spawnTarget(object, world, wfworld)
  local target = Concord.entity(world)
    :give(Drawable, love.graphics.newImage('resources/textures/target.png'))
    :give(Transform, object.x, object.y)

  target:give(Physics, target[Transform], wfworld, 'static')

  local targetBody = target[Physics].body
  targetBody:setFixedRotation(true)
  targetBody:setCollisionClass('Target')
  
  return target
end

return module