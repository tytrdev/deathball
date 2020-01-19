local pauseState = {}

function pauseState.load()
end
 
function pauseState.update(dt)
	if love.keyboard.isDown('escape') then
		return 'play'
  end
end
 
function pauseState.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('Game is paused')
end

return pauseState;