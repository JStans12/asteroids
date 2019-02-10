local DrawSystem = class('DrawSystem', System)

function DrawSystem:requires()
  return { 'position', 'sprite', 'rotation', 'animation' }
end

function DrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local sprite = entity:get('sprite')
    local position = entity:get('position')
    local rotation = entity:get('rotation')
    local animation = entity:get('animation')

    love.graphics.draw(
      sprite.spriteSheet,
      sprite.frames[animation.state],
      position.x,
      position.y,
      math.rad(rotation.direction),
      1,
      1,
      16,
      16
    )
  end
end

return DrawSystem
