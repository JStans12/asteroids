-- setup lovetoys
local lovetoys = require('lib.lovetoys.lovetoys')
lovetoys.initialize({ globals = true, debug = true })

-- width, height, {}
love.window.setMode(768, 512, {
  highdpi = true
})

-- helpers
local getInput = require('helpers.getInput')
local inspect  = require('lib.inspect')
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

-- entities
local Player   = require('entities.Player')
local Asteroid = require('entities.Asteroid')

-- systems
local MoveSystem           = require('systems.MoveSystem')
local StaticRotationSystem = require('systems.StaticRotationSystem')
local CollisionSystem      = require('systems.CollisionSystem')
local HealthSystem         = require('systems.HealthSystem')
local DrawSystem           = require('systems.DrawSystem')

engine = Engine()

local keymaps      = require('config.keymaps')
local InputHandler = require('handlers.InputHandler')

function love.load(args)
  math.randomseed(os.time())
  -- starting entities
  local player = Player(keymaps.playerOne)

  -- setup engine
  engine:addEntity(player)
  require('loaders.loadAsteroids')()
  engine:addSystem(MoveSystem())
  engine:addSystem(StaticRotationSystem())
  engine:addSystem(CollisionSystem())
  engine:addSystem(HealthSystem())
  engine:addSystem(DrawSystem(), 'draw')

  InputHandler:register(player)

  if hasValue(args, "hitbox") then
    local HitboxDrawSystem = require('systems.HitboxDrawSystem')
    engine:addSystem(HitboxDrawSystem(), 'draw')
  end
end

function love.update(dt)
  print("engine", engine:getEntityCount('hitbox'))
  InputHandler:perform(getInput())
  engine:update(dt)
end

function love.draw()
  engine:draw()
end
