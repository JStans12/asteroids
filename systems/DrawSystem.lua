local DrawSystem = class('DrawSystem', System)

function DrawSystem:requires()
  return { 'position', 'sprite' }
end

function DrawSystem:draw()
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')

    local sprite, rotation
    if entity:has('offMap') then
      local parent = entity:getParent()
      sprite = parent:get('sprite')
      rotation = parent:get('rotation')
      love.graphics.setColor(.25, .75, 1)
    else
      sprite = entity:get('sprite')
      rotation = entity:get('rotation')
    end

    if not rotation then rotation = { direction = 0 } end

    love.graphics.draw(
      sprite.spriteSheet,
      sprite.frames[sprite.currentFrame],
      position.x,
      position.y,
      math.rad(rotation.direction),
      sprite.scale or 1,
      sprite.scale or 1,
      sprite.size.height / 2,
      sprite.size.width / 2
    )

    love.graphics.setColor(1, 1, 1)
  end
end

return DrawSystem
