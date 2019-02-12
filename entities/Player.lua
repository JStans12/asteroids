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
      Hitbox =
      Component.load({
        'position',
        'physics',
        'sprite',
        'controllable',
        'rotation',
        'hitbox'
      })

local function Player(keymap)
  return buildEntity({
    Position(384, 256),
    Physics(),
    Sprite(spriteSheet, frames, "rest", { x = 32, y = 32 }),
    Controllable(keymap),
    Rotation(0),
    Hitbox(15, false)
  })
end

return Player
