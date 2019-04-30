static float lastX = 0;

public class Platform {
  private static final boolean DRAW_SPRITE = true;
  
  //probability in percent if x-position of generated platform should depend on last generated platforms x-position
  private static final float ALTERNATING_SITE_PROBABILITY = 75;

  private float x = 0;
  private float y = 0;
  private PImage sprite = loadImage("platform.png");

  private float W = DRAW_SPRITE ? sprite.width : 70;
  private float H = DRAW_SPRITE ? sprite.height : 10;


  public Platform(float y, boolean randomize) {

    if (random(100) < ALTERNATING_SITE_PROBABILITY) {
      if (lastX < (width - W) / 2) {
        this.x = random(((width - W) / 2), (width-W));
      } else {
        this.x = random(0, ((width-W) / 2));
      }
    } else {
      this.x = random((width - W));
    }
    
    lastX = this.x;
    
    if (randomize) {
      this.y = random(200, 540) + y;
    } else {
      this.y = y;
    }
  }

  public void render(Camera camera) {

    if (DRAW_SPRITE) {
      image(sprite, x, camera.adapt(y));
    } else {
      fill(0);
      rect(x, camera.adapt(y), W, H);
    }
  }

  public void update() {
  }

  public float getY() {
    return y;
  }

  public float getX() {
    return x;
  }
}
