local Concord = require('libraries.concord')

local Transform = Concord.component(function(transform, x, y, w, h)
  transform.position = {}
  transform.position.x = x or 0
  transform.position.y = y or 0
  transform.rotation = 0
  transform.dimensions = {
    width = w or 32,
    height = h or 32,
  }
end)

return Transform