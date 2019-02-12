local function areColliding(entity1, entity2)
  local position1 = entity1:get('position')
  local position2 = entity2:get('position')
  local hitbox1 = entity1:get('hitbox')
  local hitbox2 = entity2:get('hitbox')

  local dist = (position1.x - position2.x)^2 + (position1.y - position2.y)^2
  return dist <= (hitbox1.radius + hitbox2.radius)^2
end

local function checkCollision(entities, handleCollision)
  for i = 1, #entities do
    for j = 1, #entities - i do
      if (areColliding(entities[i], entities[i+j])) then
        handleCollision(entities[i], entities[i+j])
      end
    end
  end
end

return checkCollision
