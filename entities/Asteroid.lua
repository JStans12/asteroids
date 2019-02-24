local buildSprite = require('helpers.buildSprite')
local config      = require('config.asteroid')
local moveOffMap  = require('helpers.moveOffMap')

local Animation,
      Health,
      Hitbox,
      OffMap,
      OnMap,
      Physics,
      Position,
      Rotation,
      Sprite,
      StaticRotation,
      Size,
      Type =
      Component.load({
        'animation',
        'health',
        'hitbox',
        'offMap',
        'onMap',
        'physics',
        'position',
        'rotation',
        'sprite',
        'staticRotation',
        'size',
        'type'
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

local function buildChild(parent)
  local parentHitbox         = parent:get('hitbox')
  local parentPosition       = parent:get('position')

  local hitbox   = { radius = parentHitbox.radius, bounce = parentHitbox.bounce, priority = parentHitbox.priority }
  local position = { x = parentPosition.x, y = parentPosition.y }

  return hitbox, position
end

local function configure(arg)
  if arg.parent then return buildChild(arg.parent) end

  local hitbox         = config.hitbox[arg.size]
  local position       = arg.position or randomPosition()
  local animation      = config.animation
  local health         = config.health[arg.size]
  local offMap         = nil
  local physics        = randomPhysics()
  local rotation       = config.rotation
  local sprite         = buildSprite(config.sprite[arg.size])
  local staticRotation = randomStaticRotation(arg.size)

  return hitbox,
         position,
         animation,
         health,
         physics,
         rotation,
         sprite,
         staticRotation
end

local function Asteroid(arg)
  local hitbox,
        position,
        animation,
        health,
        physics,
        rotation,
        sprite,
        staticRotation =
        configure(arg)

  local asteroid = Entity(arg.parent)
  asteroid:initialize()
  asteroid:addMultiple({
    Hitbox(hitbox.radius),
    Position(position.x, position.y),
    Type('asteroid')
  })

  if arg.parent then
    asteroid:addMultiple({
      OffMap(arg.orientation),
      Sprite()
    })
  else
    asteroid:addMultiple({
      Animation(animation.sequences),
      Health(health.value, health.hitCooldown),
      Physics(physics.ax, physics.ay, physics.vx, physics.vy),
      Rotation(rotation.direction),
      Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
      StaticRotation(staticRotation.direction, staticRotation.speed),
      OnMap(),
      Size(arg.size)
    })
    for _, orientation in pairs({ 'x', 'y', 'corner' }) do
      local child = Asteroid({ parent = asteroid, orientation = orientation })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return asteroid
end

return Asteroid
