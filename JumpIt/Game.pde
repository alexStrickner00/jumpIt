public class Game {

  private ArrayList<Player> players;
  private World world;
  private NetworkConnection con;

  private Camera camera;

  private boolean started;
  private boolean finished;
  private float highest = 0;

  public Game(NetworkConnection con) {
    this.con = con;
    this.con.setGame(this);
    players = new ArrayList<Player>();
    con.setPlayers(players);
    this.init();
  }

  public void init() {
    world = new World();
    camera = new Camera();
    started = false;
    finished = false;
    for (Player p : players) {
      p.init();
    }
  }

  public void startGame() {
    this.init();
    started = true;
  }

  public void restartGame() {
    this.end();
    this.startGame();
  }

  public void run() {
    updateSprites();
    renderSprites();
    world.checkAndGenerate(highest);
  }

  public int addPlayer() {
    int id = players.size();
    players.add(new Player(id));
    return id;
  }

  private void renderSprites() {
    world.render(camera);
    for (Player p : players) {
      p.render(camera);
    }
  }

  private void updateSprites() {
    if (started && !finished) {
      finished = true;
      float _highest = Float.MIN_VALUE;
      //Update & Collision for each Player
      for (Player p : players) {
        float cy = p.update();

        if (p.isAlive())
          finished = false;
        //Wenn player höher als vorheriger Höchster, soll dieser wert gespeichert werden -> Kameraverfolgung des höchsten
        if (cy > _highest) {
          _highest = cy;
        }

        if (p.getVy() < 0) {
          for (Platform pf : world.getPlatforms()) {
            if (CollisionHelper.collide(p, pf)) {
              p.jump();
              break;
            }
          }
        }
      }
      highest = _highest;
      camera.setHighest(highest);
    }
  }

  public void end() {
    this.finished = true;
  }
}
