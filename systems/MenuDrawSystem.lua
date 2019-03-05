local MenuDrawSystem = class('MenuDrawSystem', System)

function MenuDrawSystem:requires()
  return {}
end

function MenuDrawSystem:draw()
  love.graphics.printf(
    'Press Space to Start',
    0,
    0,
    0,
    'center'
  )

  -- love.graphics.circle('fill', 0, 0, 50)
end

return MenuDrawSystem
