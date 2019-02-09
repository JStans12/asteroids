local function getInput()
  pressedKeys = {}
  if love.keyboard.isDown('up') then
    table.insert(pressedKeys, 'up')
  end
  if love.keyboard.isDown('down') then
    table.insert(pressedKeys, 'down')
  end
  if love.keyboard.isDown('left') then
    table.insert(pressedKeys, 'left')
  end
  if love.keyboard.isDown('right') then
    table.insert(pressedKeys, 'right')
  end
  if love.keyboard.isDown('w') then
    table.insert(pressedKeys, 'w')
  end
  if love.keyboard.isDown('s') then
    table.insert(pressedKeys, 's')
  end
  if love.keyboard.isDown('a') then
    table.insert(pressedKeys, 'a')
  end
  if love.keyboard.isDown('d') then
    table.insert(pressedKeys, 'd')
  end


  return pressedKeys
end

return getInput
