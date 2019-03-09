local MenuDrawSystem = class('MenuDrawSystem', System)

function MenuDrawSystem:requires()
  return {}
end

function MenuDrawSystem:draw()
  local wWidth, wHeight = love.window.getMode()

  local largeFont = love.graphics.newFont("slkscre.ttf", 84)
  love.graphics.setFont(largeFont)

  local x, y = love.mouse.getPosition()
  love.graphics.printf(
    'ASTEROIDS',
    0 - wWidth / 2,
    -200,
    wWidth,
    'center'
  )

  local mediumFont = love.graphics.newFont("slkscre.ttf", 48)
  love.graphics.setFont(mediumFont)

  love.graphics.printf(
    '-- Press Space to Start --',
    0 - wWidth / 2,
    100,
    wWidth,
    'center'
  )

  -- love.graphics.circle('fill', 0, 0, 50)
end

return MenuDrawSystem
