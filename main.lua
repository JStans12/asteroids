-- setup lovetoys
local lovetoys = require('lib.lovetoys.lovetoys')
lovetoys.initialize({ globals = true, debug = true })

-- width, height, {}
love.window.setMode(768, 512, {
  highdpi = true
})

-- helpers
local getInput = require('helpers.getInput')

-- register components
require('components.Position')
require('components.Physics')
require('components.Sprite')
require('components.Controllable')
require('components.Rotation')
require('components.Animation')
require('components.StaticRotation')
require('components.Hitbox')

-- entities
local Player   = require('entities.Player')
local Asteroid = require('entities.Asteroid')

-- systems
local MoveSystem           = require('systems.MoveSystem')
local StaticRotationSystem = require('systems.StaticRotationSystem')
local CollisionSystem      = require('systems.CollisionSystem')
local DrawSystem           = require('systems.DrawSystem')
local HitboxDrawSystem     = require('systems.HitboxDrawSystem')

local engine = Engine()

local keymaps      = require('config.keymaps')
local InputHandler = require('handlers.InputHandler')

function love.load()
  math.randomseed(os.time())
  -- starting entities
  local player = Player(keymaps.playerOne)

  -- setup engine
  engine:addEntity(player)
  require('loaders.loadAsteroids')(engine)
  engine:addSystem(MoveSystem())
  engine:addSystem(StaticRotationSystem())
  engine:addSystem(CollisionSystem())
  engine:addSystem(DrawSystem(), 'draw')
  engine:addSystem(HitboxDrawSystem(), 'draw')

  InputHandler:register(player)
end

function love.update(dt)
  InputHandler:perform(getInput())
  engine:update(dt)
end

function love.draw()
  engine:draw()
end
