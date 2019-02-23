local CameraSystem = class('CameraSystem', System)

function CameraSystem:requires()
  return { 'cameraFollow' }
end

function CameraSystem:update(dt)
  for _, player in pairs(self.targets) do
    local position = player:get('position')

    camera:lookAt(position.x, position.y)
  end
end

return CameraSystem
