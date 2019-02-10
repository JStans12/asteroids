local Asteroid = require('entities.Asteroid')

local function loadAsteroids(engine)
  local asteroid = Asteroid()
  engine:addEntity(asteroid)
end

return loadAsteroids
