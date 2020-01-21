local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Drawable = require 'components.drawable'

local DrawSystem = Concord.system({ Transform, Drawable })

function DrawSystem:draw()
    for _, e in ipairs(self.pool) do
        local transform = e[Transform]
        local drawable = e[Drawable]

        if _G.DEBUG_GAME then 
            myColor = {0, 1, 0, 1}
            love.graphics.setColor(myColor)
        end

        if drawable.img then
            x = transform.position.x - transform.dimensions.width / 2
            y = transform.position.y - transform.dimensions.height / 2
            love.graphics.draw(drawable.img, x, y)
        else
            love.graphics.circle('fill', transform.position.x, transform.position.y, 5)
        end
    end
end

return DrawSystem