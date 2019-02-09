local StaticRotationSystem = class('StaticRotationSystem', System)

function StaticRotationSystem:requires()
  return { 'staticRotation', 'rotation' }
end

function StaticRotationSystem:update()
  for _, entity in pairs(self.targets) do
    local staticRotation = entity:get('staticRotation')
    local rotation = entity:get('rotation')
    if staticRotation.direction == 'left' then
      rotation.direction = rotation.direction - staticRotation.speed
    else
      rotation.direction = rotation.direction + staticRotation.speed
    end
  end
end

return StaticRotationSystem
