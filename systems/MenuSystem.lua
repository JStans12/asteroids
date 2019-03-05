local MenuSystem = class('MenuSystem', System)
local getInput = require('helpers.getInput')
local loadLevel1 = require('loaders.loadLevel1')
local hasValue = require('helpers.hasValue')

function MenuSystem:requires()
  return {}
end

function MenuSystem:update(dt)
  local downKeys = getInput()
  if hasValue(downKeys, 'space') then
    loadLevel1()
  end
end

return MenuSystem
