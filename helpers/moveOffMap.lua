local function moveOffMap(entity)
  local offMap = entity:get('offMap')
  local position = entity:get('position')
  local parent = entity:getParent()
  local parentPosition = parent:get('position')

  if offMap.position == 'x' then
    if parentPosition.x >= 0 then
      position.x = parentPosition.x - map.size.width
    else
      position.x = parentPosition.x + map.size.width
    end
    position.y = parentPosition.y
  elseif offMap.position == 'y' then
    if parentPosition.y >= 0 then
      position.y = parentPosition.y - map.size.height
    else
      position.y = parentPosition.y + map.size.height
    end
    position.x = parentPosition.x
  else
    if parentPosition.x >= 0 and parentPosition.y >= 0 then
      position.x = parentPosition.x - map.size.width
      position.y = parentPosition.y - map.size.height
    elseif parentPosition.x >= 0 then
      position.x = parentPosition.x - map.size.width
      position.y = parentPosition.y + map.size.height
    elseif parentPosition.y >= 0 then
      position.x = parentPosition.x + map.size.width
      position.y = parentPosition.y - map.size.height
    else
      position.x = parentPosition.x + map.size.width
      position.y = parentPosition.y + map.size.height
    end
  end
end

return moveOffMap
