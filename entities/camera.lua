local module = {}

local Concord = require 'libraries.concord'

local Camera = require 'components.camera'
local Transform = require 'components.transform'
local Target = require 'components.target'

function module.build(world, target) 
  local camera = Concord.entity(world)
    :give(Transform, 0, 0) -- Default to 0,0 for now
    :give(Camera)
    :give(Target, target)

  return camera;
end

return module;