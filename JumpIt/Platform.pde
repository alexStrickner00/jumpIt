class Platform {

  float x = 0;
  float y = 0;
  PImage sprite;
  boolean drawSprite;

  float jumpSpeed= 30;
  float W = 70;
  float H = 10;

  Platform(float x, float y, boolean drawSprite) {
    this.x = x;
    this.y = y;
    this.drawSprite = drawSprite;
    if (drawSprite)
      sprite = loadImage("platform.png");
  }

  void render() {
    if (drawSprite) {
    } else {
      fill(0);
      rect(x, y, W, H);
    }
  }

  void update(float vy) {
    y += vy;
  }
}
