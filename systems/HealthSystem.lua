local HealthSystem = class('HealthSystem', System)

function HealthSystem:requires()
  return { 'health' }
end

function HealthSystem:update()
  for _, entity in pairs(self.targets) do
    local health = entity:get('health')
    if health.value <= 0 then
      engine:removeEntity(entity, true)
    end
  end
end

return HealthSystem
