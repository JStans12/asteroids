local function findCollisionPoint(entity1, entity2)
  local position1 = entity1:get('position')
  local position2 = entity2:get('position')
  local hitbox1 = entity1:get('hitbox')
  local hitbox2 = entity2:get('hitbox')

  local dist = (position1.x - position2.x)^2 + (position1.y - position2.y)^2
  local colliding = dist <= (hitbox1.radius + hitbox2.radius)^2
  if colliding then
    local collisionX = ((position1.x * hitbox2.radius) + (position2.x * hitbox1.radius))/(hitbox1.radius + hitbox2.radius)
    local collisionY = ((position1.y * hitbox2.radius) + (position2.y * hitbox1.radius))/(hitbox1.radius + hitbox2.radius)
    return { x = collisionX, y = collisionY }
  else
    return false
  end
end

local function checkCollision(entities, handleCollision)
  local checkable = {}
  for i, entity1 in pairs(entities) do
    for j, entity2 in pairs(checkable) do
      local collisionPoint = findCollisionPoint(entity1, entity2)
      if collisionPoint then
        handleCollision(entity1, entity2, collisionPoint)
      end
    end
    table.insert(checkable, entity1)
  end
end

return checkCollision
