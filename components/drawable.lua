local Concord = require('libraries.concord') 

local Drawable = Concord.component(function(drawable, img)
  drawable.img = img
end)

return Drawable