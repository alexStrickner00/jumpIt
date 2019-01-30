class Player {

  private int id = -1;

  private float x = 50;
  private float y = 1000;
  private float vx = 0;
  private float vy = 0;

  private final static boolean SHOW_HITBOX = false;
  private final static boolean OVERFLOW = false;
  private final static float DYING_SPEED = -25;

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
    sprite = loadImage("player.png");
    init();
  }

  public void init() {
    x = 50;
    y = 1000;
    vx = 0;
    vy = 0;
    alive = true;
    lastHighestSet = System.currentTimeMillis();
  }

  public float update() {
    if (!alive) {
      return y;
    }

    if (vy < DYING_SPEED || System.currentTimeMillis() - lastHighestSet > 30 * 1000)
      alive = false;

    y += vy;
    vy += ay;
    x += vx;

    if (y > highest) {
      highest = y;
      lastHighestSet = System.currentTimeMillis();
    }

    if (vx > 0) {
      if (vx - ax >= 0) {
        vx -= ax;
      } else {
        vx = 0;
      }
    }

    if (vx < 0) {
      if (vx + ax <= 0) {
        vx += ax;
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
    return y;
  }

  void render(Camera camera) {
    image(sprite, x, camera.adapt(y));
    if (OVERFLOW) {
      image(sprite, x - width, camera.adapt(y));
      image(sprite, x + width, camera.adapt(y));
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
}
