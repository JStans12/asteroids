local buildEntity = require('helpers.buildEntity')
local buildSprite = require('helpers.buildSprite')
local moveOffMap  = require('helpers.moveOffMap')

local Position,
      Physics,
      Sprite,
      Controllable,
      Rotation,
      Hitbox,
      Animation,
      CameraFollow,
      Type,
      OffMap =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'hitbox',
        'animation',
        'cameraFollow',
        'type',
        'offMap'
      })

local function Player(arg)
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

  local player = Entity(arg.parent)
  player:initialize()
  player:addMultiple({
    Position(0, 0),
    Physics(),
    Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
    Controllable(arg.keymap, 0),
    Rotation(0),
    Hitbox(15, false, 101),
    Animation(
      { thrust = { frames = { 2, 3 }, frameDelay = .05, repeatable = true } }
    ),
    Type('player')
  })

  -- local player = buildEntity({
  --   Position(0, 0),
  --   Physics(),
  --   Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
  --   Controllable(keymap, 0),
  --   Rotation(0),
  --   Hitbox(15, false, 101),
  --   Animation(
  --     { thrust = { frames = { 2, 3 }, frameDelay = .05, repeatable = true } }
  --   ),
  --   CameraFollow(50),
  --   Type('player')
  -- })

  if arg.parent then
    player:add(OffMap(arg.position))
  else
    player:add(CameraFollow(50))
    for _, position in pairs({ 'x', 'y', 'corner '}) do
      local child = Player({ parent = player, position = position, keymap = arg.keymap })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return player
end

return Player
