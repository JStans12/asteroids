local buildEntity = require('helpers.buildEntity')
local buildSpriteSheet = require('helpers.buildSpriteSheet')

local Position,
      Physics,
      Sprite,
      Rotation,
      StaticRotation,
      Hitbox,
      Health,
      Animation =
      Component.load({
        'position',
        'physics',
        'sprite',
        'rotation',
        'staticRotation',
        'hitbox',
        'health',
        'animation'
      })

local function configureSize(size)
  if size == "large" then
    local img = 'asteroid_lg_1.png'
    local dimensions = {
      rows    = 1,
      columns = 3,
      height  = 128,
      width   = 128
    }
    local hitbox = { radius = 58 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 128, y = 128 }
    local rotationSpeed = math.random(1, 10) / 80
    local health = 3
    return img, dimensions, hitbox, position, size, rotationSpeed, health
  elseif size == "medium" then
    local img = 'asteroid_md_1.png'
    local dimensions = {
      rows    = 1,
      columns = 3,
      height  = 64,
      width   = 64
    }
    local hitbox = { radius = 28 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 64, y = 64 }
    local rotationSpeed = math.random(1, 10) / 60
    local health = 2
    return img, dimensions, hitbox, position, size, rotationSpeed, health
  elseif size == "small" then
    local img = 'asteroid_sm_1.png'
    local dimensions = {
      rows    = 1,
      columns = 3,
      height  = 32,
      width   = 32
    }
    local hitbox = { radius = 14 }
    local position = {
      x = math.random(20, 748),
      y = math.random(20, 492)
    }
    local size = { x = 32, y = 32 }
    local rotationSpeed = math.random(1, 10) / 40
    local health = 1
    return img, dimensions, hitbox, position, size, rotationSpeed, health
  end
end

local function Asteroid(size)
  local img,
        dimensions,
        hitbox,
        position,
        size,
        rotationSpeed,
        health =
        configureSize(size)

  return buildEntity({
    Position(position.x, position.y),
    Physics(0, 0, math.random(-10, 10), math.random(-10, 10)),
    Sprite(buildSpriteSheet({
      img          = img,
      dimensions   = dimensions,
      currentFrame = 1
    })),
    Rotation(0),
    StaticRotation(
      math.random(1, 2) == 1 and 'left' or 'right',
      rotationSpeed
    ),
    Hitbox(hitbox.radius, true, 2),
    Health(health),
    Animation(
      { hit = { frames = { 2 }, frameDelay = .15 } }
    )
  })
end

return Asteroid
