local DrawSystem = class('DrawSystem', System)

function DrawSystem:requires()
  return { 'position', 'sprite', 'rotation' }
end

function DrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local sprite = entity:get('sprite')
    local position = entity:get('position')
    local rotation = entity:get('rotation')

    if entity:has('offMap') then
      love.graphics.setColor(.25, .75, 1)
    end

    love.graphics.draw(
      sprite.spriteSheet,
      sprite.frames[sprite.currentFrame],
      position.x,
      position.y,
      math.rad(rotation.direction),
      1,
      1,
      sprite.size.height / 2,
      sprite.size.width / 2
    )

    love.graphics.setColor(1, 1, 1)
  end
end

return DrawSystem
