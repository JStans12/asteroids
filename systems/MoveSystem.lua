local MoveSystem = class('MoveSystem', System)

function MoveSystem:requires()
  return { 'position', 'physics' }
end

function MoveSystem:update(dt)
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')
    local physics = entity:get('physics')
    position.x = position.x + physics.vx * dt
    position.y = position.y + physics.vy * dt
  end
end

return MoveSystem
