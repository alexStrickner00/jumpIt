private static final float INITIAL_SPEED_MULTIPLIER = 5;
private static float speedMultiplier = INITIAL_SPEED_MULTIPLIER;

public static void setSpeedMultiplier(float sm) {
  if (sm > 0 && sm < 50) {
    speedMultiplier = sm;
  }
}
public static float getSpeedMultiplier() {
  return speedMultiplier;
}


class Player {

  private int id = -1;

  private float x = INIT_X;
  private float y = INIT_Y;
  private float vx = 0;
  private float vy = 0;

  private final static boolean SHOW_HITBOX = false;
  private final static boolean OVERFLOW = false;
  private final static float DYING_SPEED = -25;
  private final static float MAX_TIME_ALIVE_WITHOUT_ACTION = 5;
  private final static float INIT_X = 100;
  private final static float INIT_Y = 100;

  final int SPEED_X = 6;

  private float highest;
  private long lastHighestSet;

  private float ax = 0.1;
  private float ay = -0.3;
  private float jumpVy = 18;
  private boolean alive = true;

  PImage sprite;

  public Player( int id) {
    this.id = id;
    this.sprite = loadImage("player.png");
    init();
  }

  public void init() {
    x = INIT_X;
    y = INIT_Y;
    vx = 0;
    vy = 0;
    alive = true;
    lastHighestSet = System.currentTimeMillis();
    speedMultiplier = INITIAL_SPEED_MULTIPLIER;
    highest = 0;
  }

  public float update() {
    if (!alive) {
      return y;
    }

    synchronized(this) {
      if (vy < DYING_SPEED * speedMultiplier || System.currentTimeMillis() - lastHighestSet > MAX_TIME_ALIVE_WITHOUT_ACTION * 1000)
        alive = false;

      vy += ay * speedMultiplier;
      y += vy * speedMultiplier;
      x += vx * speedMultiplier;

      if (y - 5 > highest) {
        highest = y;
        lastHighestSet = System.currentTimeMillis();
      }

      if (vx > 0) {
        if (vx - ax >= 0) {
          vx -= ax * speedMultiplier;
        } else {
          vx = 0;
        }
      }

      if (vx < 0) {
        if (vx + ax <= 0) {
          vx += ax * speedMultiplier;
        } else {
          vx = 0;
        }
      }
      if (OVERFLOW) {
        if (x > 0) {
          x %= width;
        }

        if (x < (0-sprite.width)) {
          x += width;
          x %= width;
        }
      } else {
        if (x < 0)
          x = 0;

        if (x + sprite.width > width)
          x = width - sprite.width;
      }
    }
    return y;
  }

  void render(Camera camera) {
    image(sprite, x, camera.adapt(y));
    if (OVERFLOW) {
      image(sprite, (x - width), camera.adapt(y));
      image(sprite, (x + width), camera.adapt(y));
    }
    if (SHOW_HITBOX) {
      noFill();
      rect(x, camera.adapt(y), sprite.width, sprite.height);
    }
    if (!alive) {
      fill(255, 0, 0);
      rect(x, camera.adapt(y), sprite.width, sprite.height);
    }
  }

  public void jump() {
    vy = jumpVy;
  }

  public void left() {
    vx = -SPEED_X;
  }

  public void right() {
    vx = SPEED_X;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getAy() {
    return ay;
  }

  public float getVx() {
    return vx;
  }

  public float getVy() {
    return vy;
  }

  public float getHighest() {
    return highest;
  }

  public int getId() {
    return this.id;
  }

  public boolean isAlive() {
    return this.alive;
  }

  public String getStats() {
    synchronized(this) {
      Platform[] plat = game.getWorld().getNextPlatform(this);
      double xDistNext = plat[1].getX() - this.getX();
      double yDistNext = plat[1].getY() - this.getY();
      
      double xDistPrev = 10000;
      double yDistPrev = 10000;
      if (plat[0] != null) {
        xDistPrev = plat[0].getX() - this.getX();
        yDistPrev = plat[0].getY() - this.getY();
      }
      
      //return String.format("status_%d_%f_%f_%f_%f", this.id, this.getVy(), xDist, yDist, this.getHighest());
      return String.format("status_%d_%f_%f_%f_%f_%f_%f", this.id, this.getVy(), xDistPrev, yDistPrev, xDistNext, yDistNext, this.getHighest());
    }
  }
}
