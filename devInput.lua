local Asteroid = require('entities.Asteroid')

local function devInput(pressedKeys, keymap)
  if pressedKeys[keymap['dev1']] then
    print(rock)
    local asteroid = Asteroid({ parent = rock })
    local position = asteroid:get('position')
    position.x = position.x - 200
    position.y = position.y - 200
    engine:addEntity(asteroid)
  end
end

return devInput
