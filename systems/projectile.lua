local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Projectile = require 'components.projectile'
local Physics = require 'components.physics'

local ProjectileSystem = Concord.system({Transform, Physics, Projectile})

local explosionsound = love.audio.newSource('resources/sounds/explosion.wav', 'static')

function ProjectileSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local transform = e[Transform]
        local projectile = e[Projectile]
        local physics = e[Physics]

        -- local x, y = physics.body:getPosition()
        -- physics.body:setPosition(x + projectile.speed, y)
        physics.body:setLinearVelocity(projectile.speed, 0)
        
        if physics.body:enter('Target') then
            physics.body:destroy()
            e:destroy()
            -- local collision_data = self.collider:getEnterCollisionData('Target')
            -- local target = collision_data.collider:getObject()
            explosionsound:play()
            SCORE = SCORE + 1
        end

        if physics.body:enter('Platform') then
            physics.body:destroy()
            e:destroy()
        end
    end
end

return ProjectileSystem