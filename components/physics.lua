local Concord = require('libraries.concord')

local Physics = Concord.component(function(physics, transform, world, type)
  physics.velocity = {
    x = 0,
    y = 0,
    max = 100 * love.physics.getMeter(),
  }

  local x = transform.position.x - transform.dimensions.width / 2
  local y = transform.position.y - transform.dimensions.height / 2
  physics.body = love.physics.newBody( world, x, y, type or 'dynamic' )
end)

return Physics
