local Concord = require('libraries.concord') 

local Player = Concord.component(function(player)
  player.movespeed = 200
end)

return Player