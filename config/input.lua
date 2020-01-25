local neutral = 'neutral'
local pressed = 'pressed'
local held = 'held'
local released = 'released'

local inputState = {
  move_left = neutral,
  move_right = neutral,
  down = neutral,
  jump = neutral,
  shoot = neutral,
  dash = neutral,
}

local inputMap = {
  w = 'jump',
  s = 'down',
  a = 'move_left',
  d = 'move_right',
  f = 'shoot',
  space = 'dash',
  shift = 'dash',
}

function love.keypressed(key, scancode, isrepeat)
  if inputState == nil or inputState == nil or key == nil then return false end

  local currentstate = inputState[inputMap[key]]
  if currentstate == pressed then
    inputState[inputMap[key]] = held
  else
    inputState[inputMap[key]] = pressed
  end
end

function love.keyreleased(key, scancode)
  inputState[inputMap[key]] = neutral
end

-- Module API Declarations
local module = {}

function module.update()
  for key, state in pairs(inputState) do
    if state == pressed then
      print('held now', key)
      inputState[key] = held
    end
  end
end

function module.wasPressed(name)
  return inputState[name] == pressed
end

function module.isBeingHeld(name)
  return inputState[name] == held
end

function module.isActive(name)
  return inputState[name] == held or inputState[name] == pressed
end

function module.isNeutral(name)
  return inputState[name] == neutral
end

return module