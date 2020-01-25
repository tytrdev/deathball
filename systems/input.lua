local Concord = require 'libraries.concord'

local Input = require 'config.input'

local Player = require 'components.player'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

local laserUtils = require 'entities.laser'

local InputSystem = Concord.system({Player, Transform, Physics})

local laser_sound_effect = love.audio.newSource('resources/sounds/laser.wav', 'static')

function InputSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local player = e[Player]
        local transform = e[Transform]
        local physics = e[Physics]

        physics.velocity.x = 0
        -- physics.velocity.y = 0
        
        if Input.wasPressed('jump') then
            physics.body:applyForce(0, -1000 * love.physics.getMeter())
        end

        if Input.wasPressed('down') then
            physics.body:applyForce(0, 250 * love.physics.getMeter())
        end

        if Input.isActive('move_right') then
            physics.velocity.x = physics.velocity.x + player.movespeed
        end

        if Input.isActive('move_left') then
            physics.velocity.x = physics.velocity.x - player.movespeed
        end

        if Input.wasPressed('shoot') then
            laserUtils.build(transform.position, _G.world, _G.wfworld)
            laser_sound_effect:play()
        end
    end
end

return InputSystem