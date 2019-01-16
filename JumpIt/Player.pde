class Player {

  private float x = 0;
  private float y = 1000;
  private float vx = 0;
  private float vy = 0;

  private final static boolean SHOW_HITBOX = true;

  final int SPEED_X = 6;
  
  private float ax = 0.1;
  private float ay = -0.3;
  private float jumpVy = 18;

  PImage sprite;

  public Player() {  
    sprite = loadImage("player.png");
  }

  public float update() {
    y += vy;
    vy += ay;
    x += vx;

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

    if (x > 0) {
      x %= width;
    }

    if (x < (0-sprite.width)) {
      x += width;
      x %= width;
    }
    return y;
  }

  void render(Camera camera) {
    image(sprite, x, camera.adapt(y));
    image(sprite, x - width, camera.adapt(y));
    image(sprite, x + width, camera.adapt(y));
    if (SHOW_HITBOX) {
      noFill();
      rect(x, camera.adapt(y), sprite.width, sprite.height);
    }
  }

  public void jump(){
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
}
