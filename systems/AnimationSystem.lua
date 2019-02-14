local AnimationSystem = class('AnimationSystem', System)

function AnimationSystem:requires()
  return { 'animation', 'sprite' }
end

function AnimationSystem:update(dt)
  for _, entity in pairs(self.targets) do
    local animation = entity:get('animation')
    local sprite = entity:get('sprite')
    if animation.currentSequence then
      if animation.timeSinceFrameChange > animation.sequences[animation.currentSequence].frameDelay then
        animation.timeSinceFrameChange = animation.timeSinceFrameChange - dt
        animation.currentFrame = animation.currentFrame + 1
      else
        animation.timeSinceFrameChange = animation.timeSinceFrameChange + dt
      end
      sprite.currentFrame = animation.sequences[animation.currentSequence].frames[animation.currentFrame]
      if sprite.currentFrame == nil then
        sprite.currentFrame = 'rest'
        animation.currentSequence = nil
        animation.timeSinceFrameChange = nil
        animation.currentFrame = nil
      end
    end
  end
end

return AnimationSystem
