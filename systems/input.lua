local Concord = require 'libraries.concord'

local Player = require 'components.player'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

local InputSystem = Concord.system({Player, Transform, Physics})

function InputSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local player = e[Player]
        local transform = e[Transform]
        local physics = e[Physics]

        physics.velocity.x = 0
        -- physics.velocity.y = 0
        
        if love.keyboard.isDown('w') then
            print('applying force!')
            physics.body:applyForce(0, -250 * love.physics.getMeter())
        end

        if love.keyboard.isDown('s') then
            print('applying force!')
            physics.body:applyForce(0, 250 * love.physics.getMeter())
        end

        if love.keyboard.isDown('d') then
            physics.velocity.x = physics.velocity.x + player.movespeed
        end

        if love.keyboard.isDown('a') then
            physics.velocity.x = physics.velocity.x - player.movespeed
        end
    end
end

return InputSystem