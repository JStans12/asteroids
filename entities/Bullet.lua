local buildSprite = require('helpers.buildSprite')
local moveOffMap  = require('helpers.moveOffMap')

local Position,
      Physics,
      Sprite,
      Hitbox,
      Rotation,
      Health,
      Ttl,
      OffMap,
      OnMap,
      Type
      = Component.load({
        'position',
        'physics',
        'sprite',
        'hitbox',
        'rotation',
        'health',
        'ttl',
        'offMap',
        'onMap',
        'type'
      })

local function Bullet(arg)
  local playerPosition = arg.player:get('position')
  local playerRotation = arg.player:get('rotation')

  local speedX = math.sin(math.rad(playerRotation.direction)) * 850
  local speedY = -math.cos(math.rad(playerRotation.direction)) * 850

  local sprite = buildSprite({
    spriteSheet = 'bullet.png',
    dimensions = {
      rows    = 1,
      columns = 1,
      height  = 4,
      width   = 4
    },
    currentFrame = 1
  })

  local bullet = Entity(arg.parent)
  bullet:initialize()
  bullet:addMultiple({
    Position(playerPosition.x, playerPosition.y),
    Hitbox(2),
    Type('bullet')
  })

  if arg.parent then
    bullet:addMultiple({
      OffMap(arg.position),
      Sprite()
    })
  else
    bullet:addMultiple({
      Physics(0, 0, speedX, speedY),
      Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
      Rotation(),
      Health(1, 0),
      Ttl(50),
      OnMap()
    })
    for _, position in pairs({ 'x', 'y', 'corner' }) do
      local child = Bullet({ player = arg.player, parent = bullet, position = position })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return bullet
end

return Bullet
