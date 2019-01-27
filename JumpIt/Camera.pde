public class Camera {

  private static final float OFFSET = 300;
  private float y;

  public Camera() {
    y = 0;
  }

  public float adapt(float y1) {
    return  -((y1 - y) - height);
  }

  public void setHighest(float highest) {
    y = highest - OFFSET;
  }
}
