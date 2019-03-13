local WinSystem = class('WinSystem', System)

function WinSystem:requires()
  return { 'type' }
end

function WinSystem:update()
  local playerIsAlive = false
  local asteroidsExist = false

  for _, entity in pairs(self.targets) do
    local type = entity:get('type')
    if type.value == 'player' then
      playerIsAlive = true
    end
    if type.value == 'asteroid' then
      asteroidsExist = true
    end
  end

  if playerIsAlive and not asteroidsExist then
    globalState.state = 'gameWon'
    globalState.transition = 60
    engine:addSystem(require('systems.MenuSystem')())
    engine:stopSystem('WinSystem')
  end
end

return WinSystem
