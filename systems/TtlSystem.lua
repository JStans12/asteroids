local TtlSystem = class('TtlSystem', System)

function TtlSystem:requires()
  return { 'ttl' }
end

function TtlSystem:update(dt)
  for _, entity in pairs(self.targets) do
    local ttl = entity:get('ttl')
    ttl.remaining = ttl.remaining - 100 * dt
    if ttl.remaining < 0 then
      engine:removeEntity(entity)
    end
  end
end

return TtlSystem
