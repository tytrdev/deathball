local Concord = require('libraries.concord')

local Physics = Concord.component(function(physics, transform, world, type)
  physics.velocity = {
    x = 10,
    y = 10,
    max = 100 * love.physics.getMeter(),
  }

  local x = transform.position.x - transform.dimensions.width
  local y = transform.position.y - transform.dimensions.height
  local w = transform.dimensions.width or 32
  local h = transform.dimensions.height or 32
  physics.body = world:newRectangleCollider(x, y, w, h)
  physics.body:setType(type or 'static')
end)

return Physics
