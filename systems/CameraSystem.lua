local CameraSystem = class('CameraSystem', System)

function CameraSystem:requires()
  return { 'cameraFollow' }
end

function CameraSystem:update(dt)
  local player = self.targets[1]
  local position = player:get('position')
  local map = { size = { x = 2000, y = 1500 } }

  if position.x < -map.size.x/2 then
    position.x = map.size.x + position.x
  elseif position.x > map.size.x/2 then
    position.x = -map.size.x + position.x
  end

  if position.y < -map.size.y/2 then
    position.y = map.size.y + position.y
  elseif position.y > map.size.y/2 then
    position.y = -map.size.y + position.y
  end

  camera:lookAt(position.x, position.y)
end

return CameraSystem
