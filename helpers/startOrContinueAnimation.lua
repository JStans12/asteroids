local function startOrContinueAnimation(entity, sequenceName)
  local animation = entity:get('animation')
  if animation.currentSequence == sequenceName then
  else
    animation.currentSequence = sequenceName
    animation.currentFrame = 1
    animation.timeSinceFrameChange = 0
  end
end

return startOrContinueAnimation
