local stageSelectState = {}

function stageSelectState.load()
end
 
function stageSelectState.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.quit('Thank you for playing!')
  end
  
  if love.keyboard.isDown('space') then
    return 'play'
  end
end
 
function stageSelectState.draw()
  love.graphics.setColor(1, 1, 1)
  
  for i, stage in ipairs(_G.MAPS) do 
    x = love.graphics.getWidth() / 2
    y = i * 32
    love.graphics.print(stage.title, x, y)
  end
end

return stageSelectState;