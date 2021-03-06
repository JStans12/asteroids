return {
  animation = {
    sequences = {
      hit = {
        frames = { 2 },
        frameDelay = .1
      }
    }
  },
  health = {
    large = {
      value = 3,
      hitCooldown = 0
    },
    medium = {
      value = 2,
      hitCooldown = 0
    },
    small = {
      value = 1,
      hitCooldown = 0
    }
  },
  hitbox = {
    large = {
      radius = 58,
    },
    medium = {
      radius = 28,
    },
    small = {
      radius = 14,
    }
  },
  physics = {
    ax = 0,
    ay = 0,
    vx = 10,
    vy = 10
  },
  position = {
    x = 100,
    y = 100
  },
  rotation = {
    value = 0
  },
  sprite = {
    large = {
      spriteSheet = 'asteroid_lg_1.png',
      dimensions = {
        rows    = 1,
        columns = 3,
        height  = 128,
        width   = 128
      },
      currentFrame = 1
    },
    medium = {
      spriteSheet = 'asteroid_md_1.png',
      dimensions = {
        rows    = 1,
        columns = 3,
        height  = 64,
        width   = 64
      },
      currentFrame = 1
    },
    small = {
      spriteSheet = 'asteroid_sm_1.png',
      dimensions = {
        rows    = 1,
        columns = 3,
        height  = 32,
        width   = 32
      },
      currentFrame = 1
    }
  },
  staticRotation = {
    large = {
      speed = 80
    },
    medium = {
      speed = 60
    },
    small = {
      speed = 40
    },
  }
}
