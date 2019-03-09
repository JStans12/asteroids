local GlobalStateSystem = class('GlobalStateSystem', System)

function GlobalStateSystem:requires()
  return { 'globalState' }
end

function GlobalStateSystem:update(dt)
  if globalState.transition > 0 then
    globalState.transition = globalState.transition - 1
  end
end

return GlobalStateSystem
