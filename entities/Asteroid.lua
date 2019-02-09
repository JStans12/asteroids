local buildEntity = require('helpers.buildEntity')

local spriteSheet = love.graphics.newImage('asteroids.png')

local frames = {
  normal = love.graphics.newQuad(0, 0, 32, 32, spriteSheet:getDimensions()),
  two    = love.graphics.newQuad(32, 0, 32, 32, spriteSheet:getDimensions()),
  three  = love.graphics.newQuad(64, 0, 32, 32, spriteSheet:getDimensions())
}

local Position,
      Physics,
      Sprite,
      Rotation,
      Animation,
      StaticRotation =
      Component.load({
        'position',
        'physics',
        'sprite',
        'rotation',
        'animation',
        'staticRotation'
      })

local function Asteroid()
  return buildEntity({
    Position(150, 25),
    Physics(),
    Sprite(spriteSheet, frames, 1),
    Rotation(0),
    Animation('normal'),
    StaticRotation(
      math.random(1, 2) == 1 and 'left' or 'right',
      math.random(1, 10) / 40
    )
  })
end

return Asteroid
