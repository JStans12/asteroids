local buildEntity = require('helpers/buildEntity')

local spriteSheet = love.graphics.newImage('bullet.png')
local frames = {
  love.graphics.newQuad(0, 0, 4, 4, spriteSheet:getDimensions())
}

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
    Sprite(spriteSheet, frames, 1, { x = 4, y = 4 }),
    Rotation(),
    Hitbox(2, false, 2),
    Health(1)
  })
end

return Bullet
