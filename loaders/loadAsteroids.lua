local Asteroid       = require('entities.Asteroid')
local checkCollision = require('helpers.checkCollision')

local function load(engine, size, amount)
  for i = 1, amount do
    local collision = false
    repeat

      local asteroid = Asteroid(size)
      engine:addEntity(asteroid)

      local entities = engine:getEntitiesWithComponent('hitbox')

      local function handleCollision()
        engine:removeEntity(asteroid)
        return true
      end

      collision = checkCollision(entities, handleCollision, false)
    until (collision == false)
  end
end

local function loadAsteroids(engine)
  load(engine, "small", 6)
end

return loadAsteroids
