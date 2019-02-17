local function stopAnimation(entity)
  local sprite = entity:get('sprite')
  sprite.currentFrame = 1

  local animation = entity:get('animation')
  animation.currentSequence = nil
  animation.timeSinceFrameChange = nil
  animation.currentFrame = nil
end

return stopAnimation
