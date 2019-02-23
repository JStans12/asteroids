local Asteroid       = require('entities.Asteroid')
local checkCollision = require('helpers.checkCollision')

local function load(size, amount)
  for i = 1, amount do
    repeat
      local collision = false

      local asteroid = Asteroid({ size = size })
      engine:addEntity(asteroid)

      local entities = engine:getEntitiesWithComponent('hitbox')

      local function handleCollision()
        engine:removeEntity(asteroid, true)
        collision = true
      end

      checkCollision(entities, handleCollision)
    until (collision == false)
  end
end

local function loadAsteroids()
  load("large", 1)
  -- load("medium", 1)
  -- load("small", 1)
end

return loadAsteroids
