local module = {}

local Concord = require 'libraries.concord'

local Transform = require 'components.transform'
local Drawable = require 'components.drawable'
local Physics = require 'components.physics'
local Player = require 'components.player'
local Animation = require 'components.animation'

local playerAnimations = require 'animations.player'

-- local logger = require 'logger'

function module.build(object, world, box2d_world) 
  local player = Concord.entity(world)
    :give(Animation, playerAnimations)
    :give(Transform, object.x, object.y, playerAnimations.width, playerAnimations.height)
    :give(Drawable, love.graphics.newImage('resources/textures/purple.png'))
    :give(Player)
  
  player:give(Physics, player[Transform], box2d_world, 'dynamic')

  player[Physics].velocity.max = 1000
  local playerBody = player[Physics].body
  playerBody:setFixedRotation(true)
  playerBody:setType('dynamic')
  playerBody:setCollisionClass('Player')
  playerBody:setDensity(0)
  playerBody:setObject(player)

  playerBody:setPreSolve(function(collider_1, collider_2, contact)        
    if collider_1.collision_class == 'Player' and collider_2.collision_class == 'OneWayPlatform' then
      local px, py = collider_1:getPosition()            
      local pw, ph = 20, 40            
      local tx, ty = collider_2:getPosition() 
      local tw, th = 100, 20
      if py + ph/2 > ty - th/2 then contact:setEnabled(false) end
    end   
  end)

  return player;
end

return module;