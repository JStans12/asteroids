local function allCopiesOf(entity)
  local type = entity:get('type').value

  if entity:has('offMap') then
    entity = entity:getParent()
  end

  local copies = { entity }
  for _, child in pairs(entity.children) do
    local childType = child:get('type').value
    if type == childType then
      table.insert(copies, child)
    end
  end
  return copies
end

return allCopiesOf
