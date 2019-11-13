public class World {

  private ArrayList<Platform> platforms;

  public World() {
    initPlatforms();
  }

  private void initPlatforms() {
    platforms = new ArrayList<Platform>();
    generateInitial();
  }

  private void generateInitial() {
    platforms.add(new Platform(0, 100));
    platforms.add(new Platform(300, 300));
    platforms.add(new Platform(580, 000));
    platforms.add(new Platform(880, 250));
    platforms.add(new Platform(1160, 50));
    platforms.add(new Platform(1430, 300));
    platforms.add(new Platform(2000, 10));
  }

  public void generate(int amount) {
    float lastY = platforms.size() > 0 ? platforms.get(platforms.size() - 1).getY() : 0;
    if (lastY == 0) {
      platforms.add(new Platform(0, 100));
    }
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

  public Platform[] getNextPlatform(Player p) {
    Platform[] plats = new Platform[2];
    for (int i = 0; i < platforms.size(); i++) {
      Platform plat = platforms.get(i);
      if (plat.getY() > p.getY()) {
        plats[1] = plat;
        if (i > 0) {
          plats[0] = platforms.get(i-1);
        }
      }
    }

    return plats;
  }
}
