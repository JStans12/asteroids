local buildEntity = require('helpers.buildEntity')

local largeSpriteSheet = love.graphics.newImage('asteroid_lg_1.png')
local largeFrames = {
  normal = love.graphics.newQuad(0, 0, 128, 128, largeSpriteSheet:getDimensions()),
  hit    = love.graphics.newQuad(128, 0, 128, 128, largeSpriteSheet:getDimensions()),
}

local mediumSpriteSheet = love.graphics.newImage('asteroid_md_1.png')
local mediumFrames = {
  normal = love.graphics.newQuad(0, 0, 64, 64, mediumSpriteSheet:getDimensions()),
  hit    = love.graphics.newQuad(64, 0, 64, 64, mediumSpriteSheet:getDimensions()),
}

local smallSpriteSheet = love.graphics.newImage('asteroid_sm_1.png')
local smallFrames = {
  normal = love.graphics.newQuad(0, 0, 32, 32, smallSpriteSheet:getDimensions()),
  hit    = love.graphics.newQuad(32, 0, 32, 32, smallSpriteSheet:getDimensions()),
}

local Position,
      Physics,
      Sprite,
      Rotation,
      StaticRotation,
      Hitbox,
      Health =
      Component.load({
        'position',
        'physics',
        'sprite',
        'rotation',
        'staticRotation',
        'hitbox',
        'health'
      })

local function configureSize(size)
  if size == "large" then
    local spriteSheet = largeSpriteSheet
    local frames      = largeFrames
    local hitbox = { radius = 58 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 128, y = 128 }
    local rotationSpeed = math.random(1, 10) / 80
    local health = 3
    return spriteSheet, frames, currentFrame, hitbox, position, size, rotationSpeed, health
  elseif size == "medium" then
    local spriteSheet = mediumSpriteSheet
    local frames      = mediumFrames
    local hitbox = { radius = 28 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 64, y = 64 }
    local rotationSpeed = math.random(1, 10) / 60
    local health = 2
    return spriteSheet, frames, currentFrame, hitbox, position, size, rotationSpeed, health
  elseif size == "small" then
    local spriteSheet = smallSpriteSheet
    local frames      = smallFrames
    local hitbox = { radius = 14 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 32, y = 32 }
    local rotationSpeed = math.random(1, 10) / 40
    local health = 1
    return spriteSheet, frames, currentFrame, hitbox, position, size, rotationSpeed, health
  end
end

local function Asteroid(size)
  local spriteSheet,
        frames,
        currentFrame,
        hitbox,
        position,
        size,
        rotationSpeed,
        health =
        configureSize(size)

  return buildEntity({
    Position(position.x, position.y),
    Physics(0, 0, math.random(-10, 10), math.random(-10, 10)),
    Sprite(spriteSheet, frames, "normal", size),
    Rotation(0),
    StaticRotation(
      math.random(1, 2) == 1 and 'left' or 'right',
      rotationSpeed
    ),
    Hitbox(hitbox.radius, true, 2),
    Health(health)
  })
end

return Asteroid
