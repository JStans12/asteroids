local OnMapSystem = class('OnMapSystem', System)

function OnMapSystem:requires()
  return { 'onMap' }
end

function OnMapSystem:update()
  for _, entity in pairs(self.targets) do
    local position = entity:get('position')

    if position.x > map.size.width / 2 then
      position.x = position.x - map.size.width
    elseif position.x < -map.size.width / 2 then
      position.x = position.x + map.size.width
    end

    if position.y > map.size.height / 2 then
      position.y = position.y - map.size.height
    elseif position.y < -map.size.height / 2 then
      position.y = position.y + map.size.height
    end

  end
end

return OnMapSystem
