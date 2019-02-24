local moveOffMap = require('helpers.moveOffMap')

local ParticleEmitter,
      Position,
      OffMap,
      OnMap,
      Ttl,
      Type
      = Component.load({
        'particleEmitter',
        'position',
        'offMap',
        'onMap',
        'ttl',
        'type'
      })

local function ParticleEmissionSite(arg)
  local pCanvas = love.graphics.newCanvas(1, 1)
  pCanvas:renderTo(arg.renderFunction);

  pSystem = love.graphics.newParticleSystem(pCanvas, arg.distribution.amount)
  pSystem:setParticleLifetime(.1, .4)
  pSystem:setRadialAcceleration(200, 400)
  pSystem:setEmissionArea('ellipse', arg.distribution.x, arg.distribution.y, 0, true)

  local particleEmissionSite = Entity(arg.parent)
  particleEmissionSite:initialize()
  particleEmissionSite:addMultiple({
    ParticleEmitter(pSystem, false, arg.distribution.amount),
    Position(arg.coords.x, arg.coords.y),
    Ttl(30),
    Type('particleEmissionSite')
  })

  if arg.parent then
    particleEmissionSite:add(OffMap(arg.position))
  else
    particleEmissionSite:add(OnMap())
    for _, position in pairs({ 'x', 'y', 'corner' }) do
      local child = ParticleEmissionSite({ parent = particleEmissionSite, position = position, renderFunction = arg.renderFunction, coords = arg.coords, distribution = arg.distribution })
      engine:addEntity(child)
      moveOffMap(child)
    end
  end

  return particleEmissionSite
end

return ParticleEmissionSite
