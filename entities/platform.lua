local module = {}

local Concord = require 'libraries.concord'
local Transform = require 'components.transform'
local Physics = require 'components.physics'

function module.build(object, world, box2d_world)
  local platform = Concord.entity(world)
    :give(Transform, object.x, object.y, object.width, object.height)
  
  platform:give(Physics, platform[Transform], box2d_world, 'static')
  local platformBody = platform[Physics].body
  platformBody:setCollisionClass('Platform')
  platformBody:setObject(platform)
  
  return platform
end

function module.buildWall(object, world, box2d_world)
  local platform = Concord.entity(world)
    :give(Transform, object.x, object.y, object.width, object.height)
  
  platform:give(Physics, platform[Transform], box2d_world, 'static')
  local platformBody = platform[Physics].body
  platformBody:setCollisionClass('Wall')
  platformBody:setObject(platform)
  
  return platform
end

function module.buildOneWayPlatform(object, world, box2d_world)
  local platform = Concord.entity(world)
    :give(Transform, object.x, object.y, object.width, object.height)
  
  platform:give(Physics, platform[Transform], box2d_world, 'static')
  local platformBody = platform[Physics].body
  platformBody:setCollisionClass('OneWayPlatform')
  platformBody:setObject(platform)
  
  return platform
end

function module.buildRamp(object, world, wfworld)
  local ramp = Concord.entity(world)
    :give(Transform, object.x, object.y)


  local polygonValues = {}

  for i, values in pairs(object.polygon) do
    print('x', values.x, 'y', values.y)
    table.insert(polygonValues, values.x)
    table.insert(polygonValues, values.y)
  end
  ramp.body = wfworld:newPolygonCollider(polygonValues)
  ramp.body:setType('static')
  ramp.body:setCollisionClass('Ramp')
  return ramp
end

return module