local buildEntity = require('helpers.buildEntity')

local largeSpriteSheet = love.graphics.newImage('space_rocks_lg.png')
local largeFrames = {
  love.graphics.newQuad(0, 0, 128, 128, largeSpriteSheet:getDimensions()),
  love.graphics.newQuad(128, 0, 128, 128, largeSpriteSheet:getDimensions()),
  love.graphics.newQuad(256, 0, 128, 128, largeSpriteSheet:getDimensions())
}

local mediumSpriteSheet = love.graphics.newImage('space_rocks_md.png')
local mediumFrames = {
  love.graphics.newQuad(0, 0, 64, 64, mediumSpriteSheet:getDimensions()),
  love.graphics.newQuad(64, 0, 64, 64, mediumSpriteSheet:getDimensions()),
  love.graphics.newQuad(128, 0, 64, 64, mediumSpriteSheet:getDimensions())
}

local smallSpriteSheet = love.graphics.newImage('space_rocks_sm.png')
local smallFrames = {
  love.graphics.newQuad(0, 0, 32, 32, smallSpriteSheet:getDimensions()),
  love.graphics.newQuad(32, 0, 32, 32, smallSpriteSheet:getDimensions()),
  love.graphics.newQuad(64, 0, 32, 32, smallSpriteSheet:getDimensions())
}

local Position,
      Physics,
      Sprite,
      Rotation,
      StaticRotation,
      Hitbox =
      Component.load({
        'position',
        'physics',
        'sprite',
        'rotation',
        'staticRotation',
        'hitbox'
      })

local function configureSize(size)
  if size == "large" then
    local spriteSheet = largeSpriteSheet
    local frames      = largeFrames
    local currentFrame = math.random(1, 3)
    local hitbox = { radius = 60 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 128, y = 128 }
    return spriteSheet, frames, currentFrame, hitbox, position, size
  elseif size == "medium" then
    local spriteSheet = mediumSpriteSheet
    local frames      = mediumFrames
    local currentFrame = math.random(1, 3)
    local hitbox = { radius = 30 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 64, y = 64 }
    return spriteSheet, frames, currentFrame, hitbox, position, size
  elseif size == "small" then
    local spriteSheet = smallSpriteSheet
    local frames      = smallFrames
    local currentFrame = math.random(1, 3)
    local hitbox = { radius = 15 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 32, y = 32 }
    return spriteSheet, frames, currentFrame, hitbox, position, size
  end
end

local function Asteroid(size)
  local spriteSheet,
        frames,
        currentFrame,
        hitbox,
        position,
        size =
        configureSize(size)

  return buildEntity({
    Position(position.x, position.y),
    Physics(0, 0, math.random(-10, 10), math.random(-10, 10)),
    Sprite(spriteSheet, frames, currentFrame, size),
    Rotation(0),
    StaticRotation(
      math.random(1, 2) == 1 and 'left' or 'right',
      math.random(1, 10) / 40
    ),
    Hitbox(hitbox.radius)
  })
end

return Asteroid
