local Concord = require 'libraries.concord'

local Animation = require 'components.animation'
local Drawable = require 'components.drawable'

local AnimationSystem = Concord.system({Animation, Drawable})

function AnimationSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local animation = e[Animation]
        local drawable = e[Drawable]

        animation.currentAnimation = animation.targetAnimation
        drawable.img = animation:getImage()
    end
end

return AnimationSystem