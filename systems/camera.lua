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

        -- if x < 50 then x = 50 end
        -- if x > 1000 then x = 1000 end

        transform.position.x = -1 * x
        transform.position.y = -1 * y
    end
end

return CameraSystem