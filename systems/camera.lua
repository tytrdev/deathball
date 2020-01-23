local Concord = require 'libraries.concord'

local Camera = require 'components.camera'
local Transform = require 'components.transform'
local Target = require 'components.target'
local Physics = require 'components.physics'

local CameraSystem = Concord.system({ Camera, Transform, Target })

function CameraSystem:update()
    for _, e in ipairs(self.pool) do
        local camera = e[Camera]
        local transform = e[Transform]
        local target = e[Target]
        
        -- This might be questionable
        -- Oh, types, for where art thou?
        local targetBody = target.source[Physics].body
        local x, y = targetBody:getPosition()

        x = x - love.graphics.getWidth() / 2
        y = y - love.graphics.getHeight() / 2

        xmax = _G.MAP.totalwidth - _G.GAME.SCREEN_WIDTH
        if x < 0 then x = 0 end
        if x > xmax then x = xmax end

        ymax = _G.MAP.totalheight - _G.GAME.SCREEN_HEIGHT
        if y < 0 then y = 0 end
        if y > ymax then y = ymax end

        transform.position.x = -1 * x
        transform.position.y = -1 * y
    end
end

return CameraSystem