local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Projectile = require 'components.projectile'
local Physics = require 'components.physics'

local ProjectileSystem = Concord.system({Transform, Physics, Projectile})

function ProjectileSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local transform = e[Transform]
        local projectile = e[Projectile]
        local physics = e[Physics]

        local x, y = physics.body:getPosition()
        physics.body:setPosition(x + projectile.speed, y)
    end
end

return ProjectileSystem