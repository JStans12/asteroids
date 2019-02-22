local OffMapSystem = class('OffMapSystem', System)
local moveOffMap = require('helpers.moveOffMap')

function OffMapSystem:requires()
  return { 'offMap' }
end

function OffMapSystem:update()
  for _, entity in pairs(self.targets) do
    moveOffMap(entity)
  end
end

return OffMapSystem
