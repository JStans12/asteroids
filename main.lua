local hasValue = require('helpers.hasValue')
local suit = require('lib.suit')

-- setup lovetoys
local lovetoys = require('lib.lovetoys.lovetoys')
lovetoys.initialize({ globals = true, debug = true })

-- width, height, {}
love.window.setMode(750, 500, {
  highdpi = true
})
-- love.window.setFullscreen(true)

local Camera = require('lib.hump.camera')

-- globals
engine = nil -- engine is reset in each loader
camera = Camera(0, 0)
inspect = require('lib.inspect')
globalConfig = {}

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
require('components.Type')
require('components.OnMap')
require('components.Size')
require('components.ParticleEmitter')
require('components.HealthBarFlag')

function love.load(arg)
  math.randomseed(os.time())

  require('loaders.loadMenu')()

  if hasValue(arg, 'hitbox') then
    local HitboxDrawSystem = require('systems.HitboxDrawSystem')
    engine:addSystem(HitboxDrawSystem(), 'draw')
  end

  if hasValue(arg, 'grid') then
    local GridSystem = require('systems.GridSystem')
    engine:addSystem(GridSystem(), 'draw')
  end
end

function love.update(dt)
  engine:update(dt)
end

function love.draw()
  camera:attach()
  engine:draw()
  camera:detach()
end
