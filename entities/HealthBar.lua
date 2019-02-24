local buildSprite = require('helpers.buildSprite')

local Position,
      Sprite,
      HealthBarFlag,
      Type =
      Component.load({
        'position',
        'sprite',
        'healthBarFlag',
        'type'
      })

local function HealthBar(arg)
  local sprite = buildSprite({
    spriteSheet = 'health_bar.png',
    dimensions = {
      rows      = 1,
      columns   = 13,
      height    = 128,
      width     = 128
    },
    currentFrame = 1
  })

  local healthBar = Entity(arg.player)
  healthBar:initialize()
  healthBar:addMultiple({
    Position(0, 0),
    Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
    HealthBarFlag(),
    Type('healthBar')
  })

  return healthBar
end

return HealthBar
