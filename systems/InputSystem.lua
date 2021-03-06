local Set = require('helpers.Set')
local physicsConfig = require('config.physics')
local Bullet = require('entities.Bullet')
local startOrContinueAnimation = require('helpers.startOrContinueAnimation')
local stopAnimation = require('helpers.stopAnimation')
local getInput = require('helpers.getInput')
local devInput = require('devInput')

local InputSystem = class('InputSystem', System)

function InputSystem:requires()
  return { 'controllable' }
end

function InputSystem:update()
  local downKeys = getInput()
  for _, entity in pairs(self.targets) do
    local controllable = entity:get('controllable')

    local keymap = {}
    keymap['up'] = controllable.keymap['up']
    keymap['left'] = controllable.keymap['left']
    keymap['right'] = controllable.keymap['right']
    keymap['shoot'] = controllable.keymap['shoot']
    keymap['dev1'] = controllable.keymap['dev1']
    keymap['dev2'] = controllable.keymap['dev2']
    keymap['dev3'] = controllable.keymap['dev3']
    keymap['dev4'] = controllable.keymap['dev4']

    local entityKeys = Set {
      keymap['up'],
      keymap['left'],
      keymap['right'],
      keymap['shoot'],
      keymap['dev1'],
      keymap['dev2'],
      keymap['dev3'],
      keymap['dev4']
    }

    local pressedKeys = {}

    for _, key in pairs(downKeys) do
      pressedKeys[key] = entityKeys[key]
    end

    local rotation  = entity:get('rotation')
    local physics   = entity:get('physics')
    local animation = entity:get('animation')

    devInput(pressedKeys, keymap)

    -- Acceleration
    if pressedKeys[keymap['up']] then
      physics.ax =  math.sin(math.rad(rotation.direction)) * physicsConfig.acceleration
      physics.ay =  -math.cos(math.rad(rotation.direction)) * physicsConfig.acceleration
      physics.vx = (physics.vx + physics.ax)
      physics.vy = (physics.vy + physics.ay)

      -- Restrict Speed
      local speed = math.sqrt(math.pow(physics.vx, 2) + math.pow(physics.vy, 2))
      if speed > physicsConfig.maxSpeed then
        local direction = math.atan(physics.vy / physics.vx)
        local maxSpeedX = math.abs(math.cos(direction) * physicsConfig.maxSpeed)
        local maxSpeedY = math.abs(math.sin(direction) * physicsConfig.maxSpeed)
        if physics.vx > maxSpeedX  then physics.vx = maxSpeedX  end
        if physics.vx < -maxSpeedX then physics.vx = -maxSpeedX end
        if physics.vy > maxSpeedY  then physics.vy = maxSpeedY  end
        if physics.vy < -maxSpeedY then physics.vy = -maxSpeedY end
      end

      if animation.currentSequence == nil then
        startOrContinueAnimation(entity, 'thrust')
      end
    elseif animation.currentSequence == 'thrust' then
      stopAnimation(entity)
    end

    -- Friction
    physics.vx = physics.vx * physicsConfig.friction
    physics.vy = physics.vy * physicsConfig.friction

    if pressedKeys[keymap['left']] and pressedKeys[keymap['right']] then
    elseif pressedKeys[keymap['left']] then
      rotation.direction = rotation.direction - 1.3
    elseif pressedKeys[keymap['right']] then
      rotation.direction = rotation.direction + 1.3
    end

    if controllable.shootCooldown == 0 then
      if pressedKeys[keymap['shoot']] then
        local bullet = Bullet({ player = entity })
        engine:addEntity(bullet)
        controllable.shootCooldown = controllable.shootCooldown + 50
      end
    else
      controllable.shootCooldown = controllable.shootCooldown - 1
    end
  end
end

return InputSystem
