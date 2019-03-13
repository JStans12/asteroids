local hasValue = require('helpers.hasValue')

local DrawSystem = class('DrawSystem', System)

function DrawSystem:requires()
  return { 'position', 'sprite' }
end

function DrawSystem:draw()
  local wWidth, wHeight = love.window.getMode()
  local cx,cy = camera:position()

  for _, entity in pairs(self.targets) do
    local position = entity:get('position')

    local sprite, rotation
    if entity:has('offMap') then
      local parent = entity:getParent()
      sprite = parent:get('sprite')
      rotation = parent:get('rotation')
      if hasValue(globalConfig, 'grid') then
        love.graphics.setColor(.25, .75, 1)
      end
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

  if globalState.state == 'gameOver' then
    local mediumFont = love.graphics.newFont("slkscre.ttf", 48)
    love.graphics.setFont(mediumFont)

    love.graphics.printf(
      'GAME OVER',
      cx - wWidth / 2,
      cy - 50,
      wWidth,
      'center'
    )

    local smallFont = love.graphics.newFont("slkscre.ttf", 36)
    love.graphics.setFont(smallFont)

    love.graphics.printf(
      '-- Press Space to Restart --',
      cx - wWidth / 2,
      cy + 50,
      wWidth,
      'center'
    )
  end

  if globalState.state == 'gameWon' then
    local mediumFont = love.graphics.newFont("slkscre.ttf", 48)
    love.graphics.setFont(mediumFont)

    love.graphics.printf(
      'YOU WIN!',
      cx - wWidth / 2,
      cy - 50,
      wWidth,
      'center'
    )

    local smallFont = love.graphics.newFont("slkscre.ttf", 36)
    love.graphics.setFont(smallFont)

    love.graphics.printf(
      '-- Press Space to Restart --',
      cx - wWidth / 2,
      cy + 50,
      wWidth,
      'center'
    )
  end
end

return DrawSystem
