local buildSprite = require('helpers.buildSprite')
local moveOffMap  = require('helpers.moveOffMap')

local Position,
      Sprite,
      Animation,
      Ttl,
      OffMap,
      OnMap,
      Type =
      Component.load({
        'position',
        'sprite',
        'animation',
        'ttl',
        'offMap',
        'onMap',
        'type'
      })

local function Explosion(arg)
  local sprite = buildSprite({
    spriteSheet = 'explosion.png',
    dimensions = {
      rows    = 1,
      columns = 4,
      height  = 64,
      width   = 64
    },
    currentFrame = 1
  })

  local explosion = Entity(arg.parent)
  explosion:initialize()
  explosion:addMultiple({
    Position(arg.playerPosition.x, arg.playerPosition.y),
    Type('explosion')
  })

  if arg.parent then
    explosion:addMultiple({
      OffMap(arg.orientation),
      Sprite()
    })
  else
    explosion:addMultiple({
      Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
      Animation({
        explode = { frames = { 1, 2, 3, 4 }, frameDelay = .14 }
      }),
      Ttl(60),
      OnMap()
    })
    for _, orientation in pairs({ 'x', 'y', 'corner '}) do
      local child = Explosion({ parent = explosion, orientation = orientation, playerPosition = arg.playerPosition })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return explosion
end

return Explosion
