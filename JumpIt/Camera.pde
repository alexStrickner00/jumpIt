public class Camera {

  private static final float OFFSET = 300;
  private static final float STEP = 40;
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
  
  public void up(){
    this.y += STEP;
  }
  
  public void down(){
    this.y -= STEP;
  }
 
  public void move(float e){
    this.y -= e * 30;
  }
  
}
