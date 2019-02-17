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

local function buildSpriteSheet(args)
  local img          = love.graphics.newImage(args.img)
  local frames       = buildFrames(img, args.dimensions)
  local currentFrame = args.currentFrame
  local size         = { width = args.dimensions.width, height = args.dimensions.height}

  return img, frames, currentFrame, size
end

return buildSpriteSheet
