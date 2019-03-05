local MenuSystem = require('systems.MenuSystem')
local MenuDrawSystem = require('systems.MenuDrawSystem')

local function loadMenu()
  engine = Engine()
  engine:addSystem(MenuSystem())
  engine:addSystem(MenuDrawSystem(), 'draw')
end

return loadMenu
