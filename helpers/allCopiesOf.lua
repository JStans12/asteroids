local function allCopiesOf(entity)
  if entity:has('offMap') then
    entity = entity:getParent()
  end
  local copies = { entity }
  for _, child in pairs(entity.children) do
    table.insert(copies, child)
  end
  return copies
end

return allCopiesOf
