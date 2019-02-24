local HealthBarSystem = class('HealthBarSystem', System)

function HealthBarSystem:requires()
  return { 'healthBarFlag' }
end

function HealthBarSystem:update()
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')
    local sprite = entity:get('sprite')

    local player = entity:getParent()
    local playerPosition = player:get('position')
    local playerHealth = player:get('health')

    local wWidth, wHeight = love.window.getMode()

    position.x = playerPosition.x + wWidth / 2 - 65
    position.y = playerPosition.y - wHeight / 2 + 35

    sprite.currentFrame = playerHealth.value + 1
  end
end

return HealthBarSystem
