import java.net.*;

Game game;
ServerSocket server;
NetworkConnection con;


void setup() {
  size(400, 800);

  try {
    server = new ServerSocket(8099);
    Socket client = null;
    while (client == null || !client.isConnected()) {
      client = server.accept();
      con = new NetworkConnection(client);
    }
    
  } 
  catch(IOException e) {
    e.printStackTrace();
  }
  
  game = new Game(con);
  game.init();
  game.startGame();
  con.start();
  
}

void draw() {
  game.run();
}
