local Asteroid       = require('entities.Asteroid')
local checkCollision = require('helpers.checkCollision')

local function load(engine, size, amount)
  for i = 1, amount do
    repeat
      local collision = false

      local asteroid = Asteroid(size)
      engine:addEntity(asteroid)

      local entities = engine:getEntitiesWithComponent('hitbox')

      local function handleCollision()
        engine:removeEntity(asteroid)
        collision = true
      end

      checkCollision(entities, handleCollision)
    until (collision == false)
  end
end

local function loadAsteroids(engine)
  load(engine, "large", 8)
  load(engine, "medium", 6)
  load(engine,"small", 3)
end

return loadAsteroids
