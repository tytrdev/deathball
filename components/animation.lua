local Concord = require('libraries.concord')

local Animation = Concord.component(function(animation, data)
  animation.data = data
  animation.spritesheet = love.graphics.newImage(data.sheet)
  animation.currentAnimation = 'default'
  animation.currentFrame = 0
  animation.targetAnimation = nil
end)

function Animation.getImage(self)
  return self.spritesheet
end

return Animation