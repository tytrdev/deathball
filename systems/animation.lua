local Concord = require 'libraries.concord'

local Animation = require 'components.animation'
local Drawable = require 'components.drawable'

local AnimationSystem = Concord.system({Animation, Drawable})

function AnimationSystem:update(dt)
    for _, e in ipairs(self.pool) do
        -- I use lowerCamelCase to indicate its an instance
        local animation = e[Animation]
        local drawable = e[Drawable]

        animation.currentFrameTime = animation.currentFrameTime + dt
        if animation.currentFrameTime > animation.timeBetweenFrames then
            animation.currentFrameTime = 0.0
            animation.currentQuadNum = (animation.currentQuadNum + 1) % animation.numQuads

            -- TODO: Seriously improve this garbage
            if animation.currentQuadNum == 0 then animation.currentQuadNum = 1 end
            animation.currentQuad = animation.quads[animation.currentQuadNum]
        end

        animation.currentAnimation = animation.targetAnimation
        drawable.img = animation.currentSpritesheet
        drawable.quad = animation.currentQuad
    end
end

return AnimationSystem