local player = require 'entities.player'
local platform = require 'entities.platform'
local target = require 'entities.target'

return {
  Spawns = {
    generator = player.build,
    visible = false,
    entityKey = 'Player'
  },
  Ground = {
    generator = platform.build,
    visible = false,
  },
  Ramps = {
    generator = platform.buildRamp,
    visible = true,
  },
  Platforms = {
    generator = platform.buildOneWayPlatform,
    visible = false,
  },
  Walls = {
    generator = platform.buildWall,
    visible = false,
  },
  Targets = {
    generator = target.build,
    visible = false,
  },
}