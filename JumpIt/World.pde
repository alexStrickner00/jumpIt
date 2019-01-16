public class World{

  private ArrayList<Platform> platforms;
  
  public World(){
    initPlatforms();
  }
  
  private void initPlatforms(){
    platforms = new ArrayList<Platform>();
    platforms.add(new Platform(600, false));
    platforms.add(new Platform(200, false));
    generate(10);
  }
  
  public void generate(int amount){
    float lastY = platforms.get(platforms.size()-1).getY();
    
    for(int i = 0; i < amount; i++){
      lastY = platforms.get(platforms.size()-1).getY();
      platforms.add(new Platform(lastY , true));
    }
  }
  
  public ArrayList<Platform> getPlatforms(){
    return platforms;
  }

  public void render(Camera camera){
    fill(255);
    rect(0,0,width, height);
    for(Platform pf : platforms){
      pf.render(camera);
    }
  }

}
