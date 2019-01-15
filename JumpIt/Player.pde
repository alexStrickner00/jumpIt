class Player {


  float x = 0;
  float y = 100;
  float vx = 0;

  boolean move = true;
  boolean hitbox = false;

  final int SPEED_X = 6;
  final float ax = 0.1;

  PImage sprite;

  public Player(boolean hitbox) {  
    this.hitbox = hitbox;
    sprite = loadImage("player.png");
  }

  void update() {
    if (!move)
      return;
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
  }

  void render() {
    image(sprite, x, y);
    image(sprite, x - width, y);
    image(sprite, x + width, y);
    if (hitbox) {
      noFill();
      rect(x, y, sprite.width, sprite.height);
    }
  }

  void left() {
    vx = -SPEED_X;
  }

  void right() {
    vx = SPEED_X;
  }
}
