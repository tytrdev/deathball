local module = {}

local sti = require 'libraries.sti'

local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

local LayerConfig = require 'config.layers'

function module.loadMap(path, world, wfworld)
  local map = sti('resources/maps/test.lua')
	map.totalwidth = map.width * map.tilewidth
  map.totalheight = map.height * map.tileheight

  local entities = {}

  for i, config in pairs(LayerConfig) do
    local layer = map.layers[i]
    layer.visible = config.visible

    for i, object in pairs(layer.objects) do
      local entity = config.generator(object, world, wfworld)
      entity.id = uuid()
      
      if config.entityKey then
        entities[config.entityKey] = entity
      else
        entities[entity.id] = entity
      end
    end
  end

  return map, entities
end

return module;