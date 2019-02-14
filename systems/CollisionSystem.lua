local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function bounce(entity1, entity2)
  local position1 = entity1:get('position')
  local position2 = entity2:get('position')
  local physics1  = entity1:get('physics')
  local physics2  = entity2:get('physics')
  local hitbox1   = entity1:get('hitbox')
  local hitbox2   = entity2:get('hitbox')

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
end

local function determineHealth(entity1, entity2)
  health1 = entity1:get('health')
  health2 = entity2:get('health')
  if health1 and health2 then
    local priority1 = entity1:get('hitbox').priority
    local priority2 = entity2:get('hitbox').priority
    if priority1 == priority2 then
      health2.value = health2.value - 1
      health1.value = health1.value - 1
    elseif priority1 > priority2 then
      health2.value = health2.value - 1
    else
      health1.value = health1.value - 1
    end
  end
end

local function handleCollision(entity1, entity2, collisionPoint)
  local hitbox1 = entity1:get('hitbox')
  local hitbox2 = entity2:get('hitbox')

  if (hitbox1.bounce and hitbox2.bounce) then
    bounce(entity1, entity2)
  else
    determineHealth(entity1, entity2)
    for _, entity in pairs({ entity1, entity2 }) do
      if entity:has('animation') then
        local animation = entity:get('animation')
        animation.currentSequence = 'hit'
        animation.currentFrame = 1
        animation.timeSinceFrameChange = 0
      end
    end
  end
end

function CollisionSystem:update()
  checkCollision(self.targets, handleCollision)
end

return CollisionSystem
