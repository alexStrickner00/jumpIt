public class Platform {
  public static final boolean DRAW_SPRITE = true;

  private float x = 0;
  private float y = 0;
  private PImage sprite = loadImage("platform.png");

  private float W = DRAW_SPRITE ? sprite.width : 70;
  private float H = DRAW_SPRITE ? sprite.height : 10;


  public Platform(float y, boolean randomize) {
    this.x = (float)Math.random() * (width - W);

    if (randomize) {
      this.y = (float)Math.random() * 300 + y;
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
