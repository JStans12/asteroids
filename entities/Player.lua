local buildSprite = require('helpers.buildSprite')
local moveOffMap  = require('helpers.moveOffMap')

local Position,
      Physics,
      Sprite,
      Controllable,
      Rotation,
      Hitbox,
      Health,
      Animation,
      CameraFollow,
      Type,
      OffMap,
      OnMap =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'hitbox',
        'health',
        'animation',
        'cameraFollow',
        'type',
        'offMap',
        'onMap'
      })

local function Player(arg)
  local sprite = buildSprite({
    spriteSheet = 'ship.png',
    dimensions = {
      rows      = 1,
      columns   = 4,
      height    = 32,
      width     = 32
    },
    currentFrame = 1
  })

  local player = Entity(arg.parent)
  player:initialize()
  player:addMultiple({
    Position(100, 100),
    Hitbox(15),
    Type('player')
  })

  if arg.parent then
    player:addMultiple({
      OffMap(arg.orientation),
      Sprite()
    })
  else
    player:addMultiple({
      Controllable(arg.keymap, 0),
      CameraFollow(50),
      Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
      Animation({
        thrust = { frames = { 2, 3 }, frameDelay = .05, repeatable = true },
        hit = { frames = { 4 }, frameDelay = .1 }
      }),
      Rotation(0),
      Physics(),
      Health(12, 0),
      OnMap()
    })
    for _, orientation in pairs({ 'x', 'y', 'corner '}) do
      local child = Player({ parent = player, orientation = orientation })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return player
end

return Player
