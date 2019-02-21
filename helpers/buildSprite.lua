local function buildFrames(img, dimensions)
  local frames = {}

  for i=1, dimensions.rows do
    for j=1, dimensions.columns do
      local quad = love.graphics.newQuad(
        (j - 1) * dimensions.width,
        (i - 1) * dimensions.height,
        dimensions.width,
        dimensions.height,
        img:getDimensions()
      )

      table.insert(frames, quad)
    end
  end

  return frames
end

local function buildSprite(arg)
  local spriteSheet  = love.graphics.newImage(arg.spriteSheet)
  local frames       = buildFrames(spriteSheet, arg.dimensions)
  local currentFrame = arg.currentFrame
  local size         = { width = arg.dimensions.width, height = arg.dimensions.height}

  return {
    spriteSheet = spriteSheet,
    frames = frames,
    currentFrame = currentFrame,
    size = size
  }
end

return buildSprite
