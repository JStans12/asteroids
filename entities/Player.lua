local buildEntity = require('helpers.buildEntity')

local spriteSheet = love.graphics.newImage('ship.png')

local frames = {
  rest = love.graphics.newQuad(0, 0, 32, 32, spriteSheet:getDimensions()),
  thrust = love.graphics.newQuad(32, 0, 32, 32, spriteSheet:getDimensions())
}

local Position,
      Physics,
      Sprite,
      Controllable,
      Rotation,
      Animation =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'animation',
      })

local function Player(keymap)
  return buildEntity({
    Position(384, 256),
    Physics(),
    Sprite(spriteSheet, frames, 1),
    Controllable(keymap),
    Rotation(0),
    Animation('rest')
  })
end

return Player