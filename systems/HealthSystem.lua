local HealthSystem = class('HealthSystem', System)
local tableLength = require('helpers.tableLength')
local Explosion = require('entities.Explosion')
local Asteroid = require('entities.Asteroid')
local ParticleEmissionSite = require('entities.ParticleEmissionSite')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')
local selfOrParent = require('helpers.selfOrParent')

function HealthSystem:requires()
  return { 'health' }
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
        position = { x = config.x, y = config.y }
      })
      engine:addEntity(asteroid)
    end
  end
end

local function spawnParticleEmissionSite(entity)
  local targetEntity = selfOrParent(entity)
  local position = targetEntity:get('position')
  local hitbox = targetEntity:get('hitbox')
  local distribution = hitbox.radius * 2

  local function pointParticle()
    love.graphics.points(1, 1)
  end

  local particleEmissionSite = ParticleEmissionSite({
    position = { x = position.x, y = position.y },
    distribution = { x = distribution, y = distribution, amount = hitbox.radius },
    renderFunction = pointParticle
  })

  engine:addEntity(particleEmissionSite)
end

function HealthSystem:update()
  for _, entity in pairs(self.targets) do
    local health = entity:get('health')
    local type = entity:get('type')

    if health.value <= 0 then
      if type.value == 'asteroid' then
        spawnSmallerAsteroids(entity)
        spawnParticleEmissionSite(entity)
      end
      local targetEntity = selfOrParent(entity)
      local position = targetEntity:get('position')
      engine:removeEntity(targetEntity, true)

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
