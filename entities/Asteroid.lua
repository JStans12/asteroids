local buildEntity = require('helpers.buildEntity')

local Position,
      Physics,
      Sprite,
      Rotation,
      Animation,
      StaticRotation,
      Hitbox =
      Component.load({
        'position',
        'physics',
        'sprite',
        'rotation',
        'animation',
        'staticRotation',
        'hitbox'
      })

local function configureSize(size)
  if size == "large" then

  elseif size == "medium" then

  elseif size == "small" then
    local spriteSheet = love.graphics.newImage('space_rocks_sm.png')
    local frames = {
      normal = love.graphics.newQuad(0, 0, 32, 32, spriteSheet:getDimensions()),
      two    = love.graphics.newQuad(32, 0, 32, 32, spriteSheet:getDimensions()),
      three  = love.graphics.newQuad(64, 0, 32, 32, spriteSheet:getDimensions())
    }
    local hitbox = { x = 15, y = 15 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    return spriteSheet, frames, hitbox, position
  end
end

local function Asteroid(size)
  local spriteSheet,
        frames,
        hitbox,
        position =
        configureSize(size)

  return buildEntity({
    Position(position.x, position.y),
    Physics(),
    Sprite(spriteSheet, frames),
    Rotation(0),
    Animation('normal'),
    StaticRotation(
      math.random(1, 2) == 1 and 'left' or 'right',
      math.random(1, 10) / 40
    ),
    Hitbox(hitbox.x, hitbox.y)
  })
end

return Asteroid
