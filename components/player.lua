local Concord = require('libraries.concord') 

local Player = Concord.component(function(player)
  player.movespeed = 25
end)

return Player