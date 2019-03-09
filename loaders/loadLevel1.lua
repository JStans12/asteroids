local hasValue = require('helpers.hasValue')

local MoveSystem           = require('systems.MoveSystem')
local StaticRotationSystem = require('systems.StaticRotationSystem')
local CollisionSystem      = require('systems.CollisionSystem')
local HealthSystem         = require('systems.HealthSystem')
local AnimationSystem      = require('systems.AnimationSystem')
local DrawSystem           = require('systems.DrawSystem')
local CameraSystem         = require('systems.CameraSystem')
local OffMapSystem         = require('systems.OffMapSystem')
local OnMapSystem          = require('systems.OnMapSystem')
local TtlSystem            = require('systems.TtlSystem')
local InputSystem          = require('systems.InputSystem')
local ParticleSystem       = require('systems.ParticleSystem')
local ParticleDrawSystem   = require('systems.ParticleDrawSystem')
local HealthBarSystem      = require('systems.HealthBarSystem')
local WinSystem            = require('systems.WinSystem')
local GlobalStateSystem    = require('systems.GlobalStateSystem')

local Player   = require('entities.Player')
local HealthBar = require('entities.HealthBar')
local Asteroid = require('entities.Asteroid')

local function loadLevel1()
  globalState.state = 'level1'

  engine = Engine()
  local wWidth, wHeight = love.window.getMode()
  map = { size = { width = wWidth * 1.25, height = wHeight * 1.25 } }

  engine:addSystem(InputSystem())
  engine:addSystem(OnMapSystem())
  engine:addSystem(OffMapSystem())
  engine:addSystem(MoveSystem())
  engine:addSystem(StaticRotationSystem())
  engine:addSystem(CollisionSystem())
  engine:addSystem(HealthSystem())
  engine:addSystem(AnimationSystem())
  engine:addSystem(CameraSystem())
  engine:addSystem(TtlSystem())
  engine:addSystem(ParticleSystem())
  engine:addSystem(HealthBarSystem())
  engine:addSystem(WinSystem())
  engine:addSystem(GlobalStateSystem())
  engine:addSystem(DrawSystem(), 'draw')
  engine:addSystem(ParticleDrawSystem(), 'draw')

  local keymaps      = require('config.keymaps')
  local player = Player({ keymap = keymaps.playerOne })
  local healthBar = HealthBar({ player = player })
  local playerPosition = player:get('position')
  camera:lookAt(playerPosition.x, playerPosition.y)

  engine:addEntity(player)
  engine:addEntity(healthBar)
  require('loaders.loadAsteroids')()

  if hasValue(globalConfig, 'hitbox') then
    local HitboxDrawSystem = require('systems.HitboxDrawSystem')
    engine:addSystem(HitboxDrawSystem(), 'draw')
  end

  if hasValue(globalConfig, 'grid') then
    local GridSystem = require('systems.GridSystem')
    engine:addSystem(GridSystem(), 'draw')
  end
end

return loadLevel1
