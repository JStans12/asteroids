local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function bounce(entity1, entity2, dt)
  if entity1:has('onMap') or entity2:has('onMap') then
    local position1 = entity1:get('position')
    local position2 = entity2:get('position')
    local hitbox1   = entity1:get('hitbox')
    local hitbox2   = entity2:get('hitbox')

    local physics1, physics2
    if entity1:has('offMap') then
      print('1 off')
      local parent1 = entity1:getParent()
      physics1 = parent1:get('physics')
    else
      physics1 = entity1:get('physics')
    end
    if entity2:has('offMap') then
      print('2 off')
      local parent2 = entity2:getParent()
      physics2 = parent2:get('physics')
    else
      physics2 = entity2:get('physics')
    end
    print('end')

    local vxTotal = physics1.vx - physics2.vx
    local vyTotal = physics1.vy - physics2.vy
    local newVX1 = (physics1.vx * (hitbox1.radius - hitbox2.radius) + (2 * hitbox2.radius * physics2.vx)) / (hitbox1.radius + hitbox2.radius)
    local newVY1 = (physics1.vy * (hitbox1.radius - hitbox2.radius) + (2 * hitbox2.radius * physics2.vy)) / (hitbox1.radius + hitbox2.radius)
    local newVX2 = vxTotal + newVX1
    local newVY2 = vyTotal + newVY1

    physics1.vx = newVX1
    physics1.vy = newVY1
    physics2.vx = newVX2
    physics2.vy = newVY2

    position1.x = position1.x + newVX1 * dt
    position1.y = position1.y + newVY1 * dt
    position2.x = position2.x + newVX2 * dt
    position2.y = position2.y + newVY2 * dt
  end
end

local function hit(entities)
  for _, entity in pairs(entities) do
    local health
    if entity:has('offMap') then
      local parent = entity:getParent()
      health = parent:get('health')
    else
      health = entity:get('health')
    end

    if health.hitCooldown == 0 then
      health.hitCooldown = 50
      health.value = health.value - 1
      if entity:has('animation') then
        if entity:get('animation').sequences.hit then
          startOrContinueAnimation(entity, 'hit')
        end
      end
    end
  end
end

local function handleCollision(entity1, entity2, collisionPoint, dt)
  local type1 = entity1:get('type').value
  local type2 = entity2:get('type').value

  if type1 == 'asteroid' and type2 == 'asteroid' then
    bounce(entity1, entity2, dt)
  elseif type1 == 'player' and type2 == 'asteroid' then
    bounce(entity1, entity2, dt)
    hit({ entity1 })
  elseif type1 == 'asteroid' and type2 == 'player' then
    bounce(entity1, entity2, dt)
    hit({ entity2 })
  elseif type1 == 'asteroid' and type2 == 'bullet' or
    type1 == 'bullet' and type2 == 'asteroid' then
    hit({ entity1, entity2 })
  end
end

function CollisionSystem:update(dt)
  checkCollision(self.targets, handleCollision, dt)
end

return CollisionSystem
