local menuState = {}

function menuState.load()
  love.graphics.setFont(love.graphics.newFont(50))
end
 
function menuState.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.quit('Thank you for playing!')
  end
  
  if love.keyboard.isDown('space') then
    return 'play'
  end
end
 
function menuState.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('Hello menu')
end

return menuState;