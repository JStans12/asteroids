local HitboxDrawSystem = class('HitboxDrawSystem', System)

function HitboxDrawSystem:requires()
  return { 'position', 'hitbox' }
end

function HitboxDrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')
    local hitbox = entity:get('hitbox')

    love.graphics.rectangle(
      "line",
      position.x - hitbox.x,
      position.y - hitbox.y,
      hitbox.x * 2,
      hitbox.y * 2
    )
  end
end

return HitboxDrawSystem
