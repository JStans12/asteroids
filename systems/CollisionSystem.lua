local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function handleCollision(entity1, entity2, collisionPoint)
  print(true)
end

function CollisionSystem:update()
  checkCollision(self.targets, handleCollision)
end

return CollisionSystem
