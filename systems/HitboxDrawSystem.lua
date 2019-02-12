local HitboxDrawSystem = class('HitboxDrawSystem', System)

function HitboxDrawSystem:requires()
  return { 'position', 'hitbox' }
end

function HitboxDrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')
    local hitbox = entity:get('hitbox')

    love.graphics.circle(
      "line",
      position.x,
      position.y,
      hitbox.radius
    )
  end
end

return HitboxDrawSystem
