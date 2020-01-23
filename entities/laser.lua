local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Drawable = require 'components.drawable'
local Physics = require 'components.physics'
local Projectile = require 'components.projectile'

local laserimg = love.graphics.newImage('resources/textures/laser.png')

function module.build(position, world, box2d_world)
  local laser = Concord.entity(world)
    :give(Transform, position.x, position.y)
    :give(Drawable, laserimg)
    :give(Projectile)

  laser:give(Physics, laser[Transform], box2d_world, 'kinematic')
  -- local platformBody = platform[Physics].body
  -- local shape = love.physics.newRectangleShape(32, 32)
  -- local fixture = love.physics.newFixture(platformBody, shape)
  -- fixture:setFriction(0)
  
  return laser
end

return module