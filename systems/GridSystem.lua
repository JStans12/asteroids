local GridSystem = class('GridSystem', System)

function GridSystem:requires()
  return {}
end

function GridSystem:draw()
  local wWidth, wHeight = love.window.getMode()

  love.graphics.line(0, -map.size.height / 2, 0, map.size.height / 2)
  love.graphics.line( map.size.width / 2, -map.size.height / 2,  map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, -map.size.height / 2, -map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, 0 / 2, map.size.width / 2, 0)
  love.graphics.line(-map.size.width / 2, map.size.height / 2, map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, -map.size.height / 2, map.size.width / 2, -map.size.height / 2)

end

return GridSystem
