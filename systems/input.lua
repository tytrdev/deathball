local Concord = require 'libraries.concord'

local Input = require 'config.input'

local Player = require 'components.player'
local Transform = require 'components.transform'
local Physics = require 'components.physics'
local Animation = require 'components.animation'

local laserUtils = require 'entities.laser'

local InputSystem = Concord.system({Player, Transform, Physics, Animation})

local laser_sound_effect = love.audio.newSource('resources/sounds/laser.wav', 'static')

function InputSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local player = e[Player]
        local transform = e[Transform]
        local physics = e[Physics]
        local animation = e[Animation]

        physics.velocity.x = 0
        -- physics.velocity.y = 0

        local direction = 0
        
        if player.grounded and Input.wasPressed('jump') then
            physics.body:applyForce(0, -1000 * love.physics.getMeter())
        end

        if Input.wasPressed('down') then
            physics.body:applyForce(0, 250 * love.physics.getMeter())
        end

        if Input.isActive('move_right') then
            direction = direction + 1
            physics.velocity.x = player.movespeed * love.physics.getMeter()
        end

        if Input.isActive('move_left') then
            direction = direction - 1
            physics.velocity.x = -1 * player.movespeed * love.physics.getMeter()
        end

        if Input.wasPressed('shoot') then
            laserUtils.build(transform.position, direction, _G.world, _G.wfworld)
            laser_sound_effect:play()
        end

        if physics.body:enter('Platform') or physics.body:stay('Platform') then
            player.grounded = true
            animation.targetAnimation = 'grounded'
        end

        if not physics.body:stay('Platform') or physics.body:exit('Platform') then
            player.grounded = false
            animation.targetAnimation = 'grounded'
        end
    end
end

return InputSystem