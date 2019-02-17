local buildEntity = require('helpers/buildEntity')
local buildSpriteSheet = require('helpers.buildSpriteSheet')

local Position,
      Physics,
      Sprite,
      Hitbox,
      Rotation,
      Health = Component.load({
        'position',
        'physics',
        'sprite',
        'hitbox',
        'rotation',
        'health'
      })

local function Bullet(player)
  local playerPosition = player:get('position')
  local playerRotation = player:get('rotation')

  local speedX = math.sin(math.rad(playerRotation.direction)) * 850
  local speedY = -math.cos(math.rad(playerRotation.direction)) * 850

  return buildEntity({
    Position(playerPosition.x, playerPosition.y),
    Physics(0, 0, speedX, speedY),
    Sprite(buildSpriteSheet({
      img = 'bullet.png',
      dimensions = {
        rows    = 1,
        columns = 1,
        height  = 4,
        width   = 4
      },
      currentFrame = 1
    })),
    Rotation(),
    Hitbox(2, false, 2),
    Health(1)
  })
end

return Bullet
