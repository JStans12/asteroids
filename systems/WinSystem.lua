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
    print('winner')
  end

  if not playerIsAlive then
    print('loser')
  end
end

return WinSystem
