local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')
local allCopiesOf = require('helpers.allCopiesOf')
local selfOrParent = require('helpers.selfOrParent')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function bounce(entity1, entity2, dt)
  if entity1:has('onMap') or entity2:has('onMap') then
    local hitbox1   = entity1:get('hitbox')
    local hitbox2   = entity2:get('hitbox')

    local target1 = selfOrParent(entity1)
    local target2 = selfOrParent(entity2)
    local physics1 = target1:get('physics')
    local physics2 = target2:get('physics')

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

    for _, entity in pairs(allCopiesOf(entity1)) do
      local position = entity:get('position')
      position.x = position.x + newVX1 * dt
      position.y = position.y + newVY1 * dt
    end

    for _, entity in pairs(allCopiesOf(entity2)) do
      local position = entity:get('position')
      position.x = position.x + newVX2 * dt
      position.y = position.y + newVY2 * dt
    end
  end
end

local function hit(entity, amount)
  local targetEntity = selfOrParent(entity)
  local health = targetEntity:get('health')

  if health.hitCooldown == 0 then
    health.hitCooldown = 50
    health.value = health.value - amount
    if entity:has('animation') then
      if entity:get('animation').sequences.hit then
        startOrContinueAnimation(entity, 'hit')
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
    hit(entity1, 5)
  elseif type1 == 'asteroid' and type2 == 'player' then
    bounce(entity1, entity2, dt)
    hit(entity2, 5)
  elseif type1 == 'asteroid' and type2 == 'bullet'then
    hit(entity1, 1)
    hit(entity2, 1)
  elseif type1 == 'bullet' and type2 == 'asteroid' then
    hit(entity1, 1)
    hit(entity2, 1)
  end
end

function CollisionSystem:update(dt)
  checkCollision(self.targets, handleCollision, dt)
end

return CollisionSystem
