local OffMapSystem = class('OffMapSystem', System)
local Asteroid = require('entities.Asteroid')

function OffMapSystem:requires()
  return { 'offMap' }
end

function OffMapSystem:update()
  local map = { size = { width = 2000, height = 1500 } }

  local wWidth, wHeight = love.window.getMode()
  -- for _, entity in pairs(self.targets) do
  --   local position = entity:get('position')
  --   local sprite = entity:get('sprite')
  --   print(-map.size.width/2 + wWidth/2)
  --   if position.x - sprite.size.width < -map.size.width/2 + wWidth/2 then
  --     print("adding")
  --     offScreenXChild = Asteroid("large", entity)
  --     offScreenXChild:remove('offMap')
  --     local offMapPosition = offScreenXChild:get('position')
  --     offMapPosition.x = offMapPosition.x + 150
  --     engine:addEntity(entity)
  --   end
  -- end
end

return OffMapSystem
