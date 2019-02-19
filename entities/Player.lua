local buildEntity = require('helpers.buildEntity')
local buildSprite = require('helpers.buildSprite')

local Position,
      Physics,
      Sprite,
      Controllable,
      Rotation,
      Hitbox,
      Animation,
      CameraFollow =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'hitbox',
        'animation',
        'cameraFollow'
      })

local function Player(keymap)
  local sprite = buildSprite({
    spriteSheet = 'ship.png',
    dimensions = {
      rows      = 1,
      columns   = 3,
      height    = 32,
      width     = 32
    },
    currentFrame = 1
  })

  return buildEntity({
    Position(0, 0),
    Physics(),
    Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
    Controllable(keymap, 0),
    Rotation(0),
    Hitbox(15, false, 101),
    Animation(
      { thrust = { frames = { 2, 3 }, frameDelay = .05, repeatable = true } }
    ),
    CameraFollow(50)
  })
end

return Player
