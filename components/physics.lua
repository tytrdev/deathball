local Concord = require('libraries.concord')

local Physics = Concord.component(function(physics, transform, world, type)
  physics.velocity = {
    x = 10,
    y = 10,
    max = 10 * love.physics.getMeter(),
  }

  local x = transform.position.x
  local y = transform.position.y
  local w = transform.dimensions.width or 32
  local h = transform.dimensions.height or 32
  
  physics.body = world:newRectangleCollider(x, y, w, h)
  physics.body:setType(type or 'static')
end)

return Physics
