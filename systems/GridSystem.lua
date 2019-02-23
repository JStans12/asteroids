local GridSystem = class('GridSystem', System)

function GridSystem:requires()
  return {}
end

function GridSystem:draw()
  local wWidth, wHeight = love.window.getMode()

  love.graphics.setColor(.75, .25, 1)
  love.graphics.line(-map.size.width, -map.size.height / 2, map.size.width, -map.size.height / 2)
  love.graphics.line(-map.size.width, map.size.height / 2, map.size.width, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, -map.size.height, -map.size.width / 2, map.size.height)
  love.graphics.line(map.size.width / 2, -map.size.height, map.size.width / 2, map.size.height)
  love.graphics.line(-map.size.width, -map.size.height, map.size.width, -map.size.height)
  love.graphics.line(-map.size.width, map.size.height, map.size.width, map.size.height)
  love.graphics.line(-map.size.width, -map.size.height, -map.size.width, map.size.height)
  love.graphics.line(map.size.width, -map.size.height, map.size.width, map.size.height)


  love.graphics.setColor(1, 1, 1)
  love.graphics.line(0, -map.size.height / 2, 0, map.size.height / 2)
  love.graphics.line(map.size.width / 2, -map.size.height / 2,  map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, -map.size.height / 2, -map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, 0 / 2, map.size.width / 2, 0)
  love.graphics.line(-map.size.width / 2, map.size.height / 2, map.size.width / 2, map.size.height / 2)
  love.graphics.line(-map.size.width / 2, -map.size.height / 2, map.size.width / 2, -map.size.height / 2)

end

return GridSystem
