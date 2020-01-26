local Concord = require('libraries.concord') 

local Projectile = Concord.component(function(projectile, speed, direction)
  projectile.speed = speed or 25
  projectile.direction = direction or 1
end)

return Projectile