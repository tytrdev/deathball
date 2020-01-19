local module = {}

function module.spawnPlatform(object, world)
  for k,v in pairs(object) do
    print(k, v)
  end

  for k,v in pairs(object.quad) do
    print(k, v)
  end

  print('Spawning platform!', object.x, object.y)
  local platform = {}
  platform.x = object.x
  platform.y = object.y
  platform.body = love.physics.newBody( world, platform.x, platform.y, 'static' )
  return platform;
end

return module