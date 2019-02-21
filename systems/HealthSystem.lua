local HealthSystem = class('HealthSystem', System)
local tableLength = require('helpers.tableLength')

function HealthSystem:requires()
  return { 'health' }
end

function HealthSystem:update()
  for _, entity in pairs(self.targets) do
    local health = entity:get('health')
    if health.value <= 0 then
      if entity:has('offMap') then
        parent = entity:getParent()
        engine:removeEntity(parent, true)
      else
        engine:removeEntity(entity, true)
      end
    end
  end
end

return HealthSystem
