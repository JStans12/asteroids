local ParticleDrawSystem = class('ParticleDrawSystem', System)

function ParticleDrawSystem:requires()
  return { 'particleEmitter' }
end

function ParticleDrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local particleSystem = entity:get('particleEmitter').particleSystem
    local position = entity:get('position')

    love.graphics.draw(particleSystem, position.x, position.y)
  end
end

return ParticleDrawSystem
