local CameraSystem = class('CameraSystem', System)

function CameraSystem:requires()
  return { 'cameraFollow' }
end

function CameraSystem:update(dt)
  for _, player in pairs(self.targets) do
    local position = player:get('position')

    if position.x < -map.size.width/2 then
      position.x = map.size.width + position.x
    elseif position.x > map.size.width/2 then
      position.x = -map.size.width + position.x
    end

    if position.y < -map.size.height/2 then
      position.y = map.size.height + position.y
    elseif position.y > map.size.height/2 then
      position.y = -map.size.height + position.y
    end

    camera:lookAt(position.x, position.y)
  end
end

return CameraSystem
