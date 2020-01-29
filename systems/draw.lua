local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Drawable = require 'components.drawable'

local DrawSystem = Concord.system({ Transform, Drawable })

function DrawSystem:draw()
    local camera = _G.CAMERA
    if camera then
        local cameraTransform = camera[Transform]
        local graphicsTransform = love.math.newTransform(
            cameraTransform.position.x,
            cameraTransform.position.y
        )
        love.graphics.applyTransform(graphicsTransform)
    end

    for _, e in ipairs(self.pool) do
        local transform = e[Transform]
        local drawable = e[Drawable]

        if drawable.img then
            x = transform.position.x - transform.dimensions.width / 2
            y = transform.position.y - transform.dimensions.height / 2

            if drawable.quad then
                if transform.direction then
                    love.graphics.draw(drawable.img, drawable.quad, x, y, 0, transform.direction or 1, 1)
                else
                    love.graphics.draw(drawable.img, drawable.quad, x, y)
                end
            else
                love.graphics.draw(drawable.img, x, y)
            end
        else
            love.graphics.circle('fill', transform.position.x, transform.position.y, 25)
        end
    end
end

return DrawSystem