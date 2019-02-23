local CollisionSystem = class('CollisionSystem', System)
local checkCollision  = require('helpers.checkCollision')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')

function CollisionSystem:requires()
  return { 'position', 'hitbox' }
end

local function bounce(entity1, entity2)
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

    -- local midpointX = (position1.x + position2.x)/2
    -- local midpointY = (position1.y + position1.y)/2
    -- local dist = math.sqrt((position1.x - position2.x)^2 + (position1.y - position2.y)^2)
    -- position1.x = midpointX + hitbox1.radius * (position1.x - position2.x)/dist
    -- position1.y = midpointY + hitbox1.radius * (position1.y - position2.y)/dist
    -- position2.x = midpointX + hitbox2.radius * (position2.x - position1.x)/dist
    -- position2.y = midpointY + hitbox2.radius * (position2.y - position1.y)/dist

    physics1.vx = newVX1
    physics1.vy = newVY1
    physics2.vx = newVX2
    physics2.vy = newVY2
  end
end

local function decreaseHealth(entity)
  local health
  if entity:has('offMap') then
    local parent = entity:getParent()
    health = parent:get('health')
  else
    health = entity:get('health')
  end

  health.value = health.value - 1
end

local function hit(entities)
  for _, entity in pairs(entities) do
    decreaseHealth(entity)
    if entity:has('animation') then
      if entity:get('animation').sequences.hit then
        startOrContinueAnimation(entity, 'hit')
      end
    end
  end
end

local function handleCollision(entity1, entity2, collisionPoint)
  local type1 = entity1:get('type').value
  local type2 = entity2:get('type').value

  if type1 == 'asteroid' and type2 == 'asteroid' then
    bounce(entity1, entity2)
  elseif type1 == 'player' and type2 == 'asteroid' then
    bounce(entity1, entity2)
    hit({ entity1 })
  elseif type1 == 'asteroid' and type2 == 'player' then
    bounce(entity1, entity2)
    hit({ entity2 })
  elseif type1 == 'asteroid' and type2 == 'bullet' or
    type1 == 'bullet' and type2 == 'asteroid' then
    hit({ entity1, entity2 })
  end
end

function CollisionSystem:update()
  checkCollision(self.targets, handleCollision)
end

return CollisionSystem
