local Concord = require 'libraries.concord'
local DebugPhysics = require 'libraries.box2debug'

local Transform = require 'components.transform'
local Physics = require 'components.physics'

local PhysicsSystem = Concord.system({Transform, Physics})

function PhysicsSystem:update(dt)
    for _, e in ipairs(self.pool) do
        local transform = e[Transform]
        local physics = e[Physics]

        xvel, yvel = physics.body:getLinearVelocity()
        physics.body:setLinearVelocity(physics.velocity.x, yvel)
        
        if xvel > physics.velocity.max then
            physics.body:setLinearVelocity(physics.velocity.max, yvel)
        end

        if xvel < -1 * physics.velocity.max then
            physics.body:setLinearVelocity(-1 * physics.velocity.max, yvel)
        end

        local x, y = physics.body:getPosition()
        transform.position.x = x
        transform.position.y = y
    end
end

return PhysicsSystem