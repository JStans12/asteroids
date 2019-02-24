local ParticleSystem = class('ParticleSystem', System)

function ParticleSystem:requires()
  return { 'particleEmitter' }
end

function ParticleSystem:update(dt)
  for _, entity in pairs(self.targets) do
    local particleEmitter = entity:get('particleEmitter')
    if particleEmitter.emitted then
    else
      particleEmitter.particleSystem:emit(particleEmitter.amount)
      particleEmitter.emitted = true
    end
    particleEmitter.particleSystem:update(dt)
  end
end

return ParticleSystem
