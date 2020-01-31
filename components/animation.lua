local Concord = require('libraries.concord')

local Animation = Concord.component(function(animation, data)
  animation.data = data
  animation.spritesheet = love.graphics.newImage(data.sheet)
  animation.currentSpritesheet = animation.spritesheet
  animation.currentAnimation = 'default'
  animation.currentFrame = 0
  animation.targetAnimation = nil
  animation.fps = 6
  animation.timeBetweenFrames = 60.0 / animation.fps / 100
  animation.currentFrameTime = 0
  animation.currentQuadNum = 1
  animation.numQuads = data.frames
  animation.quads = {}
  
  for i=1, data.frames, 1 do
    local spacing = ((i - 1) * (data.spacing + data.width)) + data.offset
    animation.quads[i] = love.graphics.newQuad(spacing, data.verticaloffset, data.width, data.height, animation.spritesheet:getDimensions())
  end

  animation.currentQuad = animation.quads[animation.currentQuadNum]
end)

return Animation