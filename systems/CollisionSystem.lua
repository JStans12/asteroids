local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function handleCollision(entity1, entity2)
  print(true)
end

function CollisionSystem:update()
  for i = 1, #self.targets do
    for j = 1, #self.targets - i do
      if (checkCollision(self.targets[i], self.targets[i+j])) then
        handleCollision(entity1, entity2)
      end
    end
  end
end

return CollisionSystem
