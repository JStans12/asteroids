local buildEntity = require('helpers.buildEntity')
local buildSprite = require('helpers.buildSprite')
local config      = require('config.asteroid')

local Animation,
      Health,
      Hitbox,
      OffMap,
      Physics,
      Position,
      Rotation,
      Sprite,
      StaticRotation =
      Component.load({
        'animation',
        'health',
        'hitbox',
        'offMap',
        'physics',
        'position',
        'rotation',
        'sprite',
        'staticRotation'
      })

local function randomPhysics()
  local pConfig = config.physics
  return {
    ax = pConfig[ax],
    ay = pConfig[ay],
    vx = math.random(-pConfig.vx, pConfig.vx),
    vy = math.random(-pConfig.vy, pConfig.vy)
  }
end

local function randomPosition()
  local pConfig = config.position
  return {
    x = math.random(-pConfig.x, pConfig.x),
    y = math.random(-pConfig.y, pConfig.y)
  }
end

local function randomStaticRotation(size)
  return {
    direction = math.random(1, 2) == 1 and 'left' or 'right',
    speed     = math.random(1, 10) / config.staticRotation[size].speed
  }
end

local function configure(size, player)
  if player then
    return copy(player)
  end

  local animation      = config.animation
  local health         = config.health[size]
  local hitbox         = config.hitbox[size]
  local offMap         = nil
  local physics        = randomPhysics()
  local position       = randomPosition()
  local rotation       = config.rotation
  local sprite         = buildSprite(config.sprite[size])
  local staticRotation = randomStaticRotation(size)

  return animation,
         health,
         hitbox,
         offMap,
         physics,
         position,
         rotation,
         sprite,
         staticRotation
end

local function Asteroid(size)
  local animation,
        health,
        hitbox,
        offMap,
        physics,
        position,
        rotation,
        sprite,
        staticRotation =
        configure(size, player)

  return buildEntity({
    Animation(animation.sequences),
    Health(health.value),
    Hitbox(hitbox.radius, hitbox.bounce, hitbox.priority),
    OffMap(),
    Physics(physics.ax, physics.ay, physics.vx, physics.vy),
    Position(position.x, position.y),
    Rotation(rotation.direction),
    Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
    StaticRotation(staticRotation.direction, staticRotation.speed)
  })
end

return Asteroid
