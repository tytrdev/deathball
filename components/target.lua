local Concord = require('libraries.concord') 

local Target = Concord.component(function(target, source)
  target.source = source
end)

return Target