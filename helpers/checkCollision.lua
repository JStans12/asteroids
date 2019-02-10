local function areColliding(entity1, entity2)
  local position1 = entity1:get('position')
  local position2 = entity2:get('position')
  local hitbox1 = entity1:get('hitbox')
  local hitbox2 = entity2:get('hitbox')

  return
    position1.x - hitbox1.x < (position2.x - hitbox2.x)+(hitbox2.x * 2) and
    position2.x - hitbox2.x < (position1.x - hitbox1.x)+(hitbox1.x * 2) and
    position1.y - hitbox1.y < (position2.y - hitbox2.y)+(hitbox2.y * 2) and
    position2.y - hitbox2.y < (position1.y - hitbox1.y)+(hitbox1.y * 2)
end

local function checkCollision(entities, handleCollision, default)
  for i = 1, #entities do
    for j = 1, #entities - i do
      if (areColliding(entities[i], entities[i+j])) then
        return handleCollision(entities[i], entities[i+j])
      else
        return default
      end
    end
  end
end

return checkCollision
