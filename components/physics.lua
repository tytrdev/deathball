local Concord = require('libraries.concord')

local Physics = Concord.component(function(physics, transform, world, type)
  physics.velocity = {
    x = 10,
    y = 10,
    max = 100 * love.physics.getMeter(),
  }

  local x = transform.position.x - transform.dimensions.width
  local y = transform.position.y - transform.dimensions.height
  physics.body = world:newRectangleCollider(x, y, 32, 32)
  physics.body:setType('static')
end)

return Physics
