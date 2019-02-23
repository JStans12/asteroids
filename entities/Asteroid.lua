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
    -- x = 450,
    -- y = 450
  }
end

local function randomStaticRotation(size)
  return {
    direction = math.random(1, 2) == 1 and 'left' or 'right',
    speed     = math.random(1, 10) / config.staticRotation[size].speed
  }
end

local function buildChild(parent)
  local parentAnimation      = parent:get('animation')
  local parentHealth         = parent:get('health')
  local parentHitbox         = parent:get('hitbox')
  local parentPhysics        = parent:get('physics')
  local parentPosition       = parent:get('position')
  local parentRotation       = parent:get('rotation')
  local parentSprite         = parent:get('sprite')
  local parentStaticRotation = parent:get('staticRotation')

  local animation      = { sequences = parentAnimation.sequences }
  local health         = { value = parentHealth.value }
  local hitbox         = { radius = parentHitbox.radius, bounce = parentHitbox.bounce, priority = parentHitbox.priority }
  local physics        = { ax = parentPhysics.ax, ay = parentPhysics.ay, vx = parentPhysics.vx, vy = parentPhysics.vy }
  local position       = { x = parentPosition.x, y = parentPosition.y }
  local rotation       = { direction = parentRotation.direction }
  local sprite         = { spriteSheet = parentSprite.spriteSheet, frames = parentSprite.frames, currentFrame = parentSprite.currentFrame, size = parentSprite.size }
  local staticRotation = { direction = parentStaticRotation.direction, speed = parentStaticRotation.speed }

  return animation,
         health,
         hitbox,
         physics,
         position,
         rotation,
         sprite,
         staticRotation
end

local function configure(arg)
  if arg.parent then return buildChild(arg.parent) end

  local animation      = config.animation
  local health         = config.health[arg.size]
  local hitbox         = config.hitbox[arg.size]
  local offMap         = nil
  local physics        = randomPhysics()
  local position       = randomPosition()
  local rotation       = config.rotation
  local sprite         = buildSprite(config.sprite[arg.size])
  local staticRotation = randomStaticRotation(arg.size)

  return animation,
         health,
         hitbox,
         physics,
         position,
         rotation,
         sprite,
         staticRotation
end

local function Asteroid(arg)
  local animation,
        health,
        hitbox,
        physics,
        position,
        rotation,
        sprite,
        staticRotation =
        configure(arg)

  local asteroid = Entity(arg.parent)
  asteroid:initialize()
  asteroid:addMultiple({
    Animation(animation.sequences),
    Health(health.value),
    Hitbox(hitbox.radius, hitbox.bounce, hitbox.priority),
    Physics(physics.ax, physics.ay, physics.vx, physics.vy),
    Position(position.x, position.y),
    Rotation(rotation.direction),
    Sprite(sprite.spriteSheet, sprite.frames, sprite.currentFrame, sprite.size),
    StaticRotation(staticRotation.direction, staticRotation.speed),
    Type('asteroid')
  })

  if arg.parent then
    asteroid:add(OffMap(arg.position))
  else
    asteroid:add(OnMap())
    for _, position in pairs({ 'x', 'y', 'corner' }) do
      local child = Asteroid({ parent = asteroid, position = position })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return asteroid
end

return Asteroid
