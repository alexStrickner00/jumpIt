public class World {
  
  private ArrayList<Platform> platforms;

  public World() {
    initPlatforms();
  }

  private void initPlatforms() {
    platforms = new ArrayList<Platform>();
    generate(20);
  }

  public void generate(int amount) {
    float lastY = platforms.size() > 0 ? platforms.get(platforms.size() - 1).getY() : 0;

    for (int i = 0; i < amount; i++) {
      platforms.add(new Platform(lastY, true));
      lastY = platforms.get(platforms.size()-1).getY();
    }
  }

  public ArrayList<Platform> getPlatforms() {
    return platforms;
  }

  public void render(Camera camera) {
    fill(255);
    rect(0, 0, width, height);
    for (Platform pf : platforms) {
      pf.render(camera);
    }
  }

  public void checkAndGenerate(float highestPlayer) {
    if (highestPlayer + 1000 > platforms.get(platforms.size() - 1).getY()) {
      generate(20);
    }
    
  }
}
