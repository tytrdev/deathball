local logger = {}

local inspect = require 'libraries.inspect'

function iter (data, i)
  i = i + 1
  local v = data[i]
  if v then
    return i, v
  end
end

function ipairs(data)
  return iter, data, 0
end

function logger.debug(message, data)
  if message and data and type(data) == 'userdata' then
    print(message)
    print(inspect(getmetatable(someuserdata)))
  elseif message and data then
    print(message .. ' ' .. data)
  else
    print(message)
  end
end

return logger