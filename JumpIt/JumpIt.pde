Game game;

void setup() {
  size(400, 800);
  game = new Game();
  game.init();
  game.startGame();
  game.addPlayer(new Player());
}

void draw(){
  game.run();
}
