-- setup lovetoys
local lovetoys = require('lib.lovetoys.lovetoys')
lovetoys.initialize({ globals = true, debug = true })

-- width, height, {}
love.window.setMode(750, 500, {
  highdpi = true
})
love.window.setFullscreen(true)

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
  globalConfig = arg

  require('loaders.loadMenu')()
end

function love.update(dt)
  engine:update(dt)
end

function love.draw()
  camera:attach()
  engine:draw()
  camera:detach()
end
