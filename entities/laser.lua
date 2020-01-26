local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Drawable = require 'components.drawable'
local Physics = require 'components.physics'
local Projectile = require 'components.projectile'

local laserimg = love.graphics.newImage('resources/textures/laser.png')

function module.build(position, direction, world, wfworld)
  if direction == 0 then direction = 1 end
  local targetVelocity = direction * 50 * love.physics.getMeter()

  local laser = Concord.entity(world)
    :give(Transform, position.x, position.y, 20, 5)
    :give(Drawable, laserimg)
    :give(Projectile, targetVelocity)

  laser:give(Physics, laser[Transform], wfworld, 'dynamic')
  laser[Physics].body:setCollisionClass('Projectile')
  laser[Physics].body:setFixedRotation(true)
  laser[Physics].body:setGravityScale(0)
  laser[Physics].body:setLinearVelocity(targetVelocity, 0)
  
  return laser
end

return module