public class Game {

  private ArrayList<Player> players;
  private World world;
  
  private Camera camera;
  
  private boolean started;
  private boolean finished;

  public Game() {
    players = new ArrayList<Player>();
  }

  public void init() {
    world = new World();
    camera = new Camera();
    started = false;
    finished = false;
  }

  public void startGame() {
    started = true;
  }

  public void run() {
      updateSprites();
      renderSprites();
  }

  public void addPlayer(Player p) {
    players.add(p);
  }

  private void renderSprites() {
    world.render(camera);
    for(Player p : players){
      p.render(camera);
    }
  }

  private void updateSprites() {
    if (started) {
      float highest = Float.MIN_VALUE;
      //Update & Collision for each Player
      for (Player p : players) {
        float cy = p.update();
        
        //Wenn player höher als vorheriger Höchster, soll dieser wert gespeichert werden -> Kameraverfolgung des höchsten
        if(cy > highest){
          highest = cy;
        }
        
        if (p.getVy() < 0) {
          for (Platform pf : world.getPlatforms()) {
            if (CollisionHelper.collide(p, pf)) {
              p.jump();
              println("tst");
              return;
            }
          }
        }
      }
      camera.setHighest(highest);
    }
  }
}
