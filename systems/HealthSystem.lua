local HealthSystem = class('HealthSystem', System)
local tableLength = require('helpers.tableLength')
local Explosion = require('entities.Explosion')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')

function HealthSystem:requires()
  return { 'health' }
end

function HealthSystem:update()
  for _, entity in pairs(self.targets) do
    local health = entity:get('health')
    local type = entity:get('type')

    if health.value <= 0 then
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
