local buildEntity      = require('helpers.buildEntity')
local buildSpriteSheet = require('helpers.buildSpriteSheet')

local Position,
      Physics,
      Sprite,
      Controllable,
      Rotation,
      Hitbox,
      Animation =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'hitbox',
        'animation'
      })

local function Player(keymap)
  return buildEntity({
    Position(384, 256),
    Physics(),
    Sprite(buildSpriteSheet({
      img = 'ship.png',
      dimensions = {
        rows      = 1,
        columns   = 3,
        height    = 32,
        width     = 32
      },
      currentFrame = 1
    })),
    Controllable(keymap, 0),
    Rotation(0),
    Hitbox(15, false, 101),
    Animation(
      { thrust = { frames = { 2, 3 }, frameDelay = .05, repeatable = true } }
    )
  })
end

return Player
