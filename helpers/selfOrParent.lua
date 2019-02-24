local function selfOrParent(entity)
  if entity:has('onMap') then return entity end
  return entity:getParent()
end

return selfOrParent
