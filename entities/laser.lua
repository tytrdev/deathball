local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Drawable = require 'components.drawable'
local Physics = require 'components.physics'
local Projectile = require 'components.projectile'

local laserimg = love.graphics.newImage('resources/textures/laser.png')

function module.build(position, world, wfworld)
  local laser = Concord.entity(world)
    :give(Transform, position.x, position.y)
    :give(Drawable, laserimg)
    :give(Projectile)

  laser:give(Physics, laser[Transform], wfworld, 'dynamic')
  laser[Physics].body:setType('dynamic')
  laser[Physics].body:setCollisionClass('Projectile')
  laser[Physics].body:setLinearVelocity(25 * love.physics.getMeter(), 0)
  -- local platformBody = platform[Physics].body
  -- local shape = love.physics.newRectangleShape(32, 32)
  -- local fixture = love.physics.newFixture(platformBody, shape)
  -- fixture:setFriction(0)
  
  return laser
end

return module