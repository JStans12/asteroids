local AnimationSystem = class('AnimationSystem', System)
local stopAnimation = require('helpers.stopAnimation')

function AnimationSystem:requires()
  return { 'animation', 'sprite' }
end

local function incrementFrames(animation)
  animation.timeSinceFrameChange = 0
  animation.currentFrame = animation.currentFrame + 1
end

local function animate(entity, dt)
  local sprite = entity:get('sprite')
  local animation = entity:get('animation')

  local currentSequence = animation.sequences[animation.currentSequence]
  if animation.timeSinceFrameChange > currentSequence.frameDelay then
    incrementFrames(animation)
  else
    animation.timeSinceFrameChange = animation.timeSinceFrameChange + dt
  end
  local currentFrameName = currentSequence.frames[animation.currentFrame]
  if currentFrameName then
    sprite.currentFrame = currentFrameName
  else
    if currentSequence.repeatable then
      animation.currentFrame = 1
    else
      stopAnimation(entity)
    end
  end
end

function AnimationSystem:update(dt)
  for _, entity in pairs(self.targets) do
    local animation = entity:get('animation')
    if animation.currentSequence then
      animate(entity, dt)
    end
  end
end

return AnimationSystem
