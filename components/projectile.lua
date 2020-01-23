local Concord = require('libraries.concord') 

local Projectile = Concord.component(function(projectile, direction)
  projectile.speed = 25
  projectile.direction = direction or 1
end)

return Projectile