-- setup lovetoys
local lovetoys = require('lib.lovetoys.lovetoys')
lovetoys.initialize({ globals = true, debug = true })

-- width, height, {}
love.window.setMode(768, 512, {
  highdpi = true
})

-- camera
local Camera = require('lib.hump.camera')
camera = Camera(0, 0)

-- helpers
inspect  = require('lib.inspect')
local getInput = require('helpers.getInput')
local hasValue = require('helpers.hasValue')

-- register components
require('components.Position')
require('components.Physics')
require('components.Sprite')
require('components.Controllable')
require('components.Rotation')
require('components.StaticRotation')
require('components.Hitbox')
require('components.Health')
require('components.Animation')
require('components.CameraFollow')
require('components.OffMap')
require('components.Ttl')

-- entities
local Player   = require('entities.Player')
local Asteroid = require('entities.Asteroid')

-- systems
local MoveSystem           = require('systems.MoveSystem')
local StaticRotationSystem = require('systems.StaticRotationSystem')
local CollisionSystem      = require('systems.CollisionSystem')
local HealthSystem         = require('systems.HealthSystem')
local AnimationSystem      = require('systems.AnimationSystem')
local DrawSystem           = require('systems.DrawSystem')
local CameraSystem         = require('systems.CameraSystem')
local OffMapSystem         = require('systems.OffMapSystem')
local GridSystem           = require('systems.GridSystem')
local TtlSystem            = require('systems.TtlSystem')

engine = Engine()

local keymaps      = require('config.keymaps')
local InputHandler = require('handlers.InputHandler')

function love.load(arg)
  math.randomseed(os.time())

  -- starting entities
  local player = Player(keymaps.playerOne)
  local playerPosition = player:get('position')
  camera:lookAt(playerPosition.x, playerPosition.y)

  -- setup engine
  engine:addSystem(OffMapSystem())
  engine:addSystem(MoveSystem())
  engine:addSystem(StaticRotationSystem())
  engine:addSystem(CollisionSystem())
  engine:addSystem(HealthSystem())
  engine:addSystem(AnimationSystem())
  engine:addSystem(CameraSystem())
  engine:addSystem(TtlSystem())
  engine:addSystem(DrawSystem(), 'draw')

  engine:addEntity(player)
  require('loaders.loadAsteroids')()
  -- rock = Asteroid({ size = 'large' })
  -- engine:addEntity(rock)

  InputHandler:register(player)

  if hasValue(arg, 'hitbox') then
    local HitboxDrawSystem = require('systems.HitboxDrawSystem')
    engine:addSystem(HlitboxDrawSystem(), 'draw')
  end

  if hasValue(arg, 'grid') then
    local HitboxDrawSystem = require('systems.HitboxDrawSystem')
    engine:addSystem(GridSystem(), 'draw')
  end
end

function love.update(dt)
  InputHandler:perform(getInput())
  engine:update(dt)
end

function love.draw()
  camera:attach()
  engine:draw()
  camera:detach()
end
