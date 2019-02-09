local function buildEntity(components)
  local entity = Entity()
  entity:initialize()
  for _, component in pairs(components) do
    entity:add(component)
  end
  return entity
end

return buildEntity
