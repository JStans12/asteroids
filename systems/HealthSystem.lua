local HealthSystem = class('HealthSystem', System)
local tableLength = require('helpers.tableLength')
local Explosion = require('entities.Explosion')
local Asteroid = require('entities.Asteroid')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')

function HealthSystem:requires()
  return { 'health' }
end

local function selfOrParent(entity)
  if entity:has('onMap') then return entity end
  return entity:getParent()
end

local function newAsteroidConfigs(entity)
  local position = entity:get('position')
  local hitbox = entity:get('hitbox')
  local size = entity:get('size')

  local smallerSize = {
    large = 'medium',
    medium = 'small'
  }

  local randomDirection = math.random(0, math.pi)
  local x = math.cos(randomDirection)
  local y = math.sin(randomDirection)

  local configs = {
    {
      size = smallerSize[size.value],
      x = position.x - (hitbox.radius / 2) * x,
      y = position.y - (hitbox.radius / 2) * y
    },
    {
      size = smallerSize[size.value],
      x = position.x + (hitbox.radius / 2) * x,
      y = position.y + (hitbox.radius / 2) * y
    }
  }

  if size.value == 'large' then
    local rotatedX = math.cos(randomDirection + math.pi / 2)
    local rotatedY = math.sin(randomDirection + math.pi / 2)

    local babyAsteroidConfig = {
      size = "small",
      x = position.x + (hitbox.radius * .75) * rotatedX,
      y = position.y + (hitbox.radius * .75) * rotatedY
    }

    table.insert(configs, babyAsteroidConfig)
  end

  return configs
end

local function spawnSmallerAsteroids(entity)
  local targetEntity = selfOrParent(entity)
  local size = targetEntity:get('size')

  if not (size.value == 'small') then

    local configs = newAsteroidConfigs(entity)

    for _, config in pairs(configs) do
      local asteroid = Asteroid({
        size = config.size,
        coords = { x = config.x, y = config.y }
      })
      engine:addEntity(asteroid)
    end
  end
end

function HealthSystem:update()
  for _, entity in pairs(self.targets) do
    local health = entity:get('health')
    local type = entity:get('type')

    if health.value <= 0 then
      if type.value == 'asteroid' then spawnSmallerAsteroids(entity) end
      local position
      if entity:has('offMap') then
        parent = entity:getParent()
        position = parent:get('position')
        engine:removeEntity(parent, true)
      else
        position = entity:get('position')
        engine:removeEntity(entity, true)
      end
      if type.value == 'player' then
        local explosion = Explosion({ playerPosition = position })
        engine:addEntity(explosion)
        startOrContinueAnimation(explosion, 'explode')
      end
    end
    if health.hitCooldown > 0 then
      health.hitCooldown = health.hitCooldown - 1
    end
  end
end

return HealthSystem
