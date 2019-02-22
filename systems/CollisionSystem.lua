local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')
local allCopiesOf = require('helpers.allCopiesOf')

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

local function decreaseHealth(entity)
  local health = entity:get('health')
  health.value = health.value - 1
end

local function determineHealth(entity1, entity2)
  if entity1:has('health') and entity2:has('health') then
    local priority1 = entity1:get('hitbox').priority
    local priority2 = entity2:get('hitbox').priority
    if priority1 == priority2 then
      decreaseHealth(entity1)
      decreaseHealth(entity2)
    elseif priority1 > priority2 then
      decreaseHealth(entity2)
    else
      decreaseHealth(entity1)
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
        if entity:get('animation').sequences.hit then
          startOrContinueAnimation(entity, 'hit')
        end
      end
    end
  end
end

function CollisionSystem:update()
  checkCollision(self.targets, handleCollision)
end

return CollisionSystem
