local Set = require('helpers.Set')
local physicsConfig = require('config.physics')

local InputHandler = {
  targets = {}
}

function InputHandler:register(entity)
  table.insert(self.targets, entity)
end

function InputHandler:perform(downKeys)
  for _, entity in pairs(self.targets) do
    local keymap = {}
    keymap['up'] = entity:get('controllable').keymap['up']
    keymap['left'] = entity:get('controllable').keymap['left']
    keymap['right'] = entity:get('controllable').keymap['right']

    local entityKeys = Set {
      keymap['up'],
      keymap['left'],
      keymap['right']
    }

    local pressedKeys = {}

    for _, key in pairs(downKeys) do
      pressedKeys[key] = entityKeys[key]
    end

    local rotation  = entity:get('rotation')
    local physics   = entity:get('physics')
    local animation = entity:get('animation')

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

      animation.state = 'thrust'
    else
      animation.state = 'rest'
    end

    -- Friction
    physics.vx = physics.vx * physicsConfig.friction
    physics.vy = physics.vy * physicsConfig.friction

    if pressedKeys[keymap['left']] and pressedKeys[keymap['right']] then
    elseif pressedKeys[keymap['left']] then
      rotation.direction = rotation.direction - 1
    elseif pressedKeys[keymap['right']] then
      rotation.direction = rotation.direction + 1
    end
  end
end

return InputHandler
