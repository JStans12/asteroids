local OffMapSystem = class('OffMapSystem', System)
local Asteroid = require('entities.Asteroid')

function OffMapSystem:requires()
  return { 'offMap' }
end

function OffMapSystem:update()
  local map = { size = { width = 1000, height = 1000 } }
  local wWidth, wHeight = love.window.getMode()

  for _, entity in pairs(self.targets) do
    local offMap = entity:get('offMap')
    local position = entity:get('position')
    local parent = entity:getParent()
    local parentPosition = parent:get('position')

    if offMap.position == 'x' then
      if position.x > 0 and parentPosition.x > 0 then
        position.x = parentPosition.x - map.size.width
      elseif position.x < 0 and parentPosition.x < 0 then
        position.x = parentPosition.x + map.size.width
      end
    elseif offMap.position == 'y' then
      if position.y > 0 and parentPosition.y > 0 then
        position.y = parentPosition.y - map.size.height
      elseif position.y < 0 and parentPosition.y < 0 then
        position.y = parentPosition.y + map.size.height
      end
    else
      if position.x > 0 and position.y < 0 and (parentPosition.x > 0 or parentPosition.y < 0) then
        position.x = parentPosition.x - map.size.width
        position.y = parentPosition.y + map.size.height
      elseif position.x > 0 and position.y > 0 and (parentPosition.x > 0 or parentPosition.y > 0) then
        position.x = parentPosition.x - map.size.width
        position.y = parentPosition.y - map.size.height
      elseif position.x < 0 and position.y > 0 and (parentPosition.x < 0 or parentPosition.y > 0) then
        position.x = parentPosition.x + map.size.width
        position.y = parentPosition.y - map.size.height
      elseif position.x < 0 and position.y < 0 and (parentPosition.x < 0 or parentPosition.y < 0) then
        position.x = parentPosition.x + map.size.width
        position.y = parentPosition.y + map.size.height
      end
    end
  end
end

return OffMapSystem
